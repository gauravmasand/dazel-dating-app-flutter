const mongoose = require('mongoose');

const chatSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  conversations: [
    {
      receiverId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
      },
      messages: [
        {
          isSender: {
            type: Boolean,
            required: true,
          },
          message: {
            type: String,
          },
          timestamp: {
            type: Date,
            default: Date.now,
          },
          seen: {
            type: Boolean,
            default: false,
          },
          isDoc: {
            type: Boolean,
            default: false,
            required: false
          },
          docUrls: {
            type: [String], // Allow multiple doc URLs
            default: [],
          },
        },
      ],
    },
  ],
});

chatSchema.index({ userId: 1, 'conversations.receiverId': 1 }, {  }); // Compound index

const Chat = mongoose.model('Chat', chatSchema);

module.exports = Chat;
