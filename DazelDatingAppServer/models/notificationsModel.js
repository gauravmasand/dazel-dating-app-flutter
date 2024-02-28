const mongoose = require('mongoose');

const notificationSettingsSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User', // Reference to the User model if required
        unique: true,
    },
    chatNotification: {
        newMessage: { type: Boolean, default: true },
        interestedInYou: { type: Boolean, default: true },
    },
    matchesNotification: {
        newMatches: { type: Boolean, default: true },
        superLikeNotification: { type: Boolean, default: true },
        newLikeNotification: { type: Boolean, default: true },
    },
    profileNotification: {
        topProfileTips: { type: Boolean, default: true },
    },
    otherNotifications: {
        pushNotifications: { type: Boolean, default: true },
        dazelEvents: { type: Boolean, default: true },
        researchAndSurvey: { type: Boolean, default: true },
        promotional: { type: Boolean, default: true },
    },
});

const NotificationSettings = mongoose.model('NotificationSettings', notificationSettingsSchema);

module.exports = NotificationSettings;
