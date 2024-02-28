const mongoose = require('mongoose');

const authDataSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User', // Reference to the User model
        required: true,
        unique: true,
    },
    accountSignupType: {
        type: String,
        required: true,
        default: "manual"
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },
});

const AuthData = mongoose.model('AuthData', authDataSchema);

module.exports = AuthData;
