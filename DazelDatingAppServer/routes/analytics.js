const express = require('express');
const bodyParser = require('body-parser');
const authenticateAPIKey = require('../authMiddleware'); // Adjust the path based on your directory structure
const UserAnalytics = require('../models/userAnalytics'); // Import your Verification model

const router = express.Router();
router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.json());

// Update user's last active status
router.post('/update-last-active/:userId', authenticateAPIKey, async (req, res) => {
    const userId = req.params.userId;
    const currentTime = new Date(); // Get the current time

    try {
        // Find user analytics by userId
        let userAnalytics = await UserAnalytics.findOne({ userId });

        if (!userAnalytics) {
            // If user analytics not found, create a new entry
            userAnalytics = new UserAnalytics({
                userId,
                onlineStatus: {
                    lastActive: currentTime,
                },
            });

            // Save the new user analytics
            await userAnalytics.save();
        } else {
            // Update the existing user analytics
            userAnalytics.onlineStatus.lastActive = currentTime;

            // Save the updated user analytics
            await userAnalytics.save();
        }

        res.status(200).json({ lastActive: currentTime });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Mark user profile as viewed
router.post('/mark-user-viewed', authenticateAPIKey, async (req, res) => {
    try {
        const { userId, viewedUserId } = req.body; // Assuming userId and viewedUserId are sent in the request body

        // Find or create the document for the given userId
        const filter = { userId };
        const update = {
            $addToSet: {
                viewedProfiles: { userId: viewedUserId, currentTime: new Date() }
            }
        };
        const options = { upsert: true, new: true };

        const userAnalytics = await UserAnalytics.findOneAndUpdate(filter, update, options);

        res.status(200);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal server error' });
    }
});



module.exports = router;
