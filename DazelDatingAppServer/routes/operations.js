const express = require('express');
const bodyParser = require('body-parser');
const authenticateAPIKey = require('../authMiddleware'); // Adjust the path based on your directory structure
const UserData = require('../models/userData'); // Import your Verification model
const constants = require('../constants'); // Import your Verification model
const User = require('../models/user');

const router = express.Router();
router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.json());


// Update User Location API
router.post('/updateLocation/:userId', authenticateAPIKey, async (req, res) => {
    const userId = req.params.userId;

    console.log('hit');

    console.log(req.body.latitude);
    console.log(req.body.longitude);

    try {
        const user = await User.findById(userId);

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        const { latitude, longitude } = req.body;

        // Update user's location
        user.realtimeUserLocation = { latitude, longitude };

        // Save the updated user data
        await user.save();

        res.status(200).json({ message: "success" });
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

// Endpoint to enable the spotlight for a user
router.post('/enable-spotlight', authenticateAPIKey, async (req, res) => {
    try {
        const userId = req.body.userId; // Assuming you pass userId in the request body

        // Fetch the user by userId
        const user = await User.findOne({ _id: userId });

        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        // Enable the spotlight for the user
        user.spotlight.isSpotlight = true;
        user.spotlight.startMilliseconds = Date.now(); // Set startMilliseconds to current timestamp

        // Save the updated user data
        await user.save();

        res.json({ success: true, message: 'Spotlight enabled successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// Enable/Disable Incognito Mode API
router.post('/incognito/:userId', authenticateAPIKey, async (req, res) => {
    const userId = req.params.userId; // Extract user ID from the request parameters

    try {
        const user = await User.findById(userId); // Find the user by ID

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // Update incognito mode based on the provided value (true/false)
        user.incognitoMode = req.body.incognitoMode;

        // Save the updated user data
        const updatedUser = await user.save();
        res.json(updatedUser);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

module.exports = router;
