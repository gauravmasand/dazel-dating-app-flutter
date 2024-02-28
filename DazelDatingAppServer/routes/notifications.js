const express = require('express');
const router = express.Router();
const NotificationSettings = require('../models/notificationsModel');
const authenticateAPIKey = require('../authMiddleware'); // Adjust the path based on your directory structure

// Endpoint for creating or updating notification settings
router.post('/:userId', authenticateAPIKey, async (req, res) => {
    const userId = req.params.userId;
    const settingsData = req.body; // Assuming the request body contains the settings data

    try {
        let notificationSettings = await NotificationSettings.findOne({ user: userId });

        if (!notificationSettings) {
            // If settings for the user don't exist, create a new document
            notificationSettings = new NotificationSettings({
                ...settingsData,
                user: userId,
            });
            await notificationSettings.save();
            res.json({ message: 'Notification settings created successfully' });
        } else {
            // If settings for the user exist, update the existing document
            await NotificationSettings.findOneAndUpdate(
                { user: userId },
                { $set: settingsData },
                { new: true }
            );
            res.json({ message: 'Notification settings updated successfully' });
        }
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

module.exports = router;