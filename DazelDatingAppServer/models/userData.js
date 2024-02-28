const mongoose = require('mongoose');

const contactSchema = new mongoose.Schema({
  name: {
    type: String,
  },
  phoneNumbers: [{
    type: String,
    required: true
  }],
  emails: [{
    type: String,
    required: true
  }]
});

const chatSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  data: {
    contacts: {
      list: [contactSchema],
      lastUpdate: {
        type: Date,
        required: true,
        default: Date.now
      }
    }
  }
});

chatSchema.index({ userId: 1, 'data.contacts.list.name': 1 }, { unique: true });

const Chat = mongoose.model('UserData', chatSchema);

module.exports = Chat;
