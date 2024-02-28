const express = require('express');
const router = express.Router();
const Chat = require('../models/chatModel');
const authenticateAPIKey = require('../authMiddleware'); // Adjust the path based on your directory structure
const multer = require('multer');
const path = require('path');
const User = require('../models/user'); // Import User model

// Configure multer storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'chatDocs/');
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = `${Date.now()}-${Math.round(Math.random() * 1E9)}`;
    cb(null, `${file.originalname}-${uniqueSuffix}${path.extname(file.originalname)}`);
  },
});

// Create multer instance with the configured storage
const upload = multer({ storage: storage });

router.post('/send-message', authenticateAPIKey, upload.array('files', 4), async (req, res) => {
  const { userId, receiverId, message } = req.body;

  try {
    let senderUser = await Chat.findOne({ userId: userId });
    let participants = await Chat.findOne({ userId: receiverId });

    if (!senderUser) {
      senderUser = await Chat.create({ userId: userId });
    }

    if (!participants) {
      participants = await Chat.create({ userId: receiverId });
    }

    const isDoc = req.files && req.files.length > 0;
    const docUrls = isDoc ? req.files.map((file) => file.filename) : [];

    // Find the conversation index for sender and receiver
    const senderConversationIndex = senderUser.conversations.findIndex(
      (conv) => conv.receiverId.equals(receiverId)
    );

    const receiverConversationIndex = participants.conversations.findIndex(
      (conv) => conv.receiverId.equals(userId)
    );

    // Add message or document to sender's conversation
    if (senderConversationIndex !== -1) {
      senderUser.conversations[senderConversationIndex].messages.push({
        isSender: true,
        message: message ? message : null,
        docUrls: isDoc ? docUrls : [],
        isDoc: isDoc || false,
      });
    } else {
      senderUser.conversations.push({
        receiverId: receiverId,
        messages: [
          {
            isSender: true,
            message: message ? message : null,
            docUrls: isDoc ? docUrls : [],
            isDoc: isDoc || false,
          },
        ],
      });
    }

    // Add message or document to receiver's conversation
    if (receiverConversationIndex !== -1) {
      participants.conversations[receiverConversationIndex].messages.push({
        isSender: false,
        message: message ? message : null,
        docUrls: isDoc ? docUrls : [],
        isDoc: isDoc || false,
      });
    } else {
      participants.conversations.push({
        receiverId: userId,
        messages: [
          {
            isSender: false,
            message: message ? message : null,
            docUrls: isDoc ? docUrls : [],
            isDoc: isDoc || false,
          },
        ],
      });
    }


    // Save changes to the database
    await senderUser.save();
    await participants.save();

    res.status(200).json({ message: 'Message sent successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get all conversations of a user with details including unseen messages and media
router.get('/all-chats/:userId', authenticateAPIKey, async (req, res) => {
  const userId = req.params.userId;

  try {
    const chat = await Chat.findOne({ userId });
    if (!chat) {
      return res.status(404).json({ message: 'Chat not found' });
    }

    const conversations = [];

    for (const conversation of chat.conversations) {
      const receiverId = conversation.receiverId;

      // Fetch receiver details including media from the User collection
      const receiver = await User.findById(receiverId, 'name media');

      // Calculate number of unseen messages, excluding messages of type 'swipe'
      const unseenMessages = conversation.messages.reduce(
        (count, message) => {
          const parsedMessage = JSON.parse(message.message || '{}');
          return (!message.isSender && !message.seen && parsedMessage.type !== 'swipe') ? count + 1 : count;
        },
        0
      );

      // Get the most recent message and its timestamp, regardless of sender
      const mostRecentMessage = conversation.messages
        .sort((a, b) => b.timestamp - a.timestamp)
        .shift(); // Most recent message

      const { message, timestamp } = mostRecentMessage || {};

      conversations.push({
        receiverId,
        name: receiver ? receiver.name : 'Unknown',
        media: receiver ? receiver.media : [],
        unseenMessages,
        mostRecentMessage: message || 'No messages',
        mostRecentMessageTime: timestamp || 'No messages',
      });
    }

    res.status(200).json({ conversations });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Fetch chat by IDs of users
router.post('/fetch-chat', authenticateAPIKey, async (req, res) => {
  const { user1Id, user2Id, sinceTimestamp } = req.body;

  try {
    // Find chat based on users' IDs
    const chat = await Chat.findOne({
      userId: user1Id,
      'conversations.receiverId': user2Id
    });

    if (!chat) {
      return res.status(404).json({ message: 'Chat not found' });
    }

    const conversation = chat.conversations.find(conv => conv.receiverId.equals(user2Id));

    if (!conversation) {
      return res.status(404).json({ message: 'Conversation not found for user2Id' });
    }

    // Filter messages based on sinceTimestamp if provided
    const filteredMessages = sinceTimestamp ?
      conversation.messages.filter(message => message.timestamp > new Date(sinceTimestamp)) :
      conversation.messages;

    res.status(200).json({ messages: filteredMessages });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// POST endpoint to mark messages as seen
router.post('/mark-seen', authenticateAPIKey, async (req, res) => {
  const { userId, receiverId } = req.body;

  try {
    const chat0 = await Chat.findOneAndUpdate(
      { receiverId, 'conversations.receiverId': userId },
      { $set: { 'conversations.$.messages.$[].seen': true } },
      { new: true }
    );
    const chat1 = await Chat.findOneAndUpdate(
      { userId, 'conversations.receiverId': receiverId },
      { $set: { 'conversations.$.messages.$[].seen': true } },
      { new: true }
    );

    if (!chat0) {
      return res.status(404).json({ message: 'Chat not found' });
    }

    if (!chat1) {
      return res.status(404).json({ message: 'Chat not found' });
    }

    res.status(200).json({ message: 'Messages marked as seen' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});



module.exports = router;
