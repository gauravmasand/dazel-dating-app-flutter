const mongoose = require('mongoose');

const verificationSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User', // Reference to the User model assuming a User collection exists
    required: true,
  },
  imagePath: {
    type: String,
    required: true,
  },
  currentTime: {
    type: Date,
    default: Date.now,
  },
}, { timestamps: true });

const Verification = mongoose.model('ProfileVerification', verificationSchema);

module.exports = Verification;
