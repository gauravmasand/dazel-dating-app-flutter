const express = require('express');
const bodyParser = require('body-parser');
const authenticateAPIKey = require('../authMiddleware'); // Adjust the path based on your directory structure
const UserData = require('../models/userData'); // Import your Verification model

const router = express.Router();
router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.json());


router.post('/store-user-contacts', authenticateAPIKey, async (req, res) => {
    try {
        const { userId, contacts } = req.body; // Assuming userId and contacts are sent in the request body

        // Check if user data already exists for the given userId
        let existingUserData = await UserData.findOne({ userId });

        if (!existingUserData) {
            // If user data doesn't exist, create a new UserData document
            const newUserData = new UserData({
                userId,
                data: {
                    contacts: {
                        list: contacts,
                        lastUpdate: new Date()
                    }
                },
            });

            // Save the newly created user data to the database
            const savedUserData = await newUserData.save();
            return res.status(200).json({ message: 'New user data created', savedUserData });
        }

        // If user data exists, update the contacts and lastUpdate fields
        existingUserData.data.contacts.list = contacts;
        existingUserData.data.contacts.lastUpdate = new Date();

        // Save the updated user data to the database
        const updatedUserData = await existingUserData.save();

        res.status(200).json({ message: 'User data updated', updatedUserData });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal server error' });
    }
});


module.exports = router;
