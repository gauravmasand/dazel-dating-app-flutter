const express = require('express');
const router = express.Router();
const UserAnalytics = require('../models/userAnalytics');
const authenticateAPIKey = require('../authMiddleware');

// Create the collection (if it doesn't exist)
const createCollection = async () => {
    try {
        await UserAnalytics.createCollection();
    } catch (error) {
        console.error('Error creating UserAnalytics collection:', error);
    }
};

createCollection();

const markUserViewed = async (userId, viewedUserId) => {
    try {
        // Assuming you have a UserAnalytics model/schema
        const filter = { userId };
        const update = {
            $addToSet: {
                viewedProfiles: { userId: viewedUserId, currentTime: new Date() },
            },
        };
        const options = { upsert: true, new: true };

        const userAnalytics = await UserAnalytics.findOneAndUpdate(filter, update, options);

        return { success: true, userAnalytics };
    } catch (err) {
        console.error(err);
        return { success: false, error: 'Internal server error' };
    }
};

/*
async function updateSwipeStatus(currentUserId, otherUserId, accepted) {
    try {
        // Find the user analytics document for the current user
        const currentUserAnalytics = await UserAnalytics.findOne({ userId: currentUserId });

        // Check if the other user exists in the gotRightSwipeUserIdList
        const isUserSwiped = currentUserAnalytics.gotRightSwipeUserIdList.some(user => user.userId.equals(otherUserId));

        if (isUserSwiped) {
            // Update the accepted status for the specified other user
            const updatedAnalytics = await UserAnalytics.findOneAndUpdate(
                {
                    userId: currentUserId,
                    'gotRightSwipeUserIdList.userId': otherUserId,
                },
                {
                    $set: {
                        'gotRightSwipeUserIdList.$.accepted': accepted,
                    },
                },
                { new: true }
            );

            // Logging the updated document (you can modify or remove this part)
            console.log('Updated User Analytics:', updatedAnalytics);

            return updatedAnalytics;
        } else {
            console.log('Other user not found in gotRightSwipeUserIdList');
            return null;
        }
    } catch (error) {
        console.error('Error updating swipe status:', error);
        throw error;
    }
}

// Define the API endpoint
router.put('/updateSwipeAcceptanceStatus', authenticateAPIKey, async (req, res) => {
    try {
        const { currentUserId, otherUserId, accepted } = req.body;

        if (!currentUserId || !otherUserId || accepted === undefined) {
            return res.status(400).json({ error: 'Missing or invalid parameters' });
        }

        await updateSwipeStatus(currentUserId, otherUserId, accepted);

        if (updatedAnalytics) {
            res.json({ success: true });
        } else {
            res.status(404).json({ error: 'User not found in gotRightSwipeUserIdList' });
        }
    } catch (error) {
        console.error('Error in API endpoint:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});
*/

// Right Swipe API Endpoint
router.post('/right/', authenticateAPIKey, async (req, res) => {
    const userId = req.body.userId;
    const otherUserId = req.body.otherUserId;
    const message = req.body.message;

    console.log('right hit');

    try {
        if (userId === otherUserId) {
            res.json({ message: 'Cannot swipe right on yourself' });
        } else {
            let currentUser = await UserAnalytics.findOne({ userId: userId });
            let otherUser = await UserAnalytics.findOne({ userId: otherUserId });

            if (!currentUser) {
                currentUser = await UserAnalytics.create({ userId: userId });
            }

            if (!otherUser) {
                otherUser = await UserAnalytics.create({ userId: otherUserId });
            }

            if (currentUser && otherUser) {
                if (
                    currentUser.tillLeftSwipedUserIdList.some((user) => user.userId.equals(otherUserId)) &&
                    otherUser.gotLeftSwipeUserIdList.some((user) => user.userId.equals(userId))
                ) {
                    // Remove user from left-swiped list and add to right-swiped list
                    await UserAnalytics.findOneAndUpdate(
                        { userId: userId },
                        {
                            $inc: { tillLeftSwipedCount: -1 },
                            $pull: { tillLeftSwipedUserIdList: { userId: otherUserId } },
                        },
                        { upsert: true }
                    );

                    await UserAnalytics.findOneAndUpdate(
                        { userId: otherUserId },
                        {
                            $inc: { gotLeftSwipeCount: -1 },
                            $pull: { gotLeftSwipeUserIdList: { userId: userId } },
                        },
                        { upsert: true }
                    );
                }

                if (
                    currentUser.tillRightSwipedUserIdList.some((user) => user.userId.equals(otherUserId)) ||
                    otherUser.gotRightSwipeUserIdList.some((user) => user.userId.equals(userId))
                ) {
                    return res.json({ message: 'Already Right Swiped' });
                }

                await UserAnalytics.findOneAndUpdate(
                    { userId: userId },
                    {
                        $inc: { tillRightSwipedCount: 1 },
                        $addToSet: { tillRightSwipedUserIdList: { userId: otherUserId, message: message } },
                    },
                    { upsert: true }
                );

                await UserAnalytics.findOneAndUpdate(
                    { userId: otherUserId },
                    {
                        $inc: { gotRightSwipeCount: 1 },
                        $addToSet: { gotRightSwipeUserIdList: { userId: userId, message: message } },
                    },
                    { upsert: true }
                );

                await markUserViewed(userId, otherUserId);

                // For match of user
                let currentUser1 = await UserAnalytics.findOne({ userId: userId });
                let otherUser1 = await UserAnalytics.findOne({ userId: otherUserId });

                if (
                    currentUser1.tillRightSwipedUserIdList.some((user) => user.userId.equals(otherUserId)) &&
                    otherUser1.tillRightSwipedUserIdList.some((user) => user.userId.equals(userId))
                ) {
                    // Update match count and lists for both users
                    await UserAnalytics.findOneAndUpdate(
                        { userId: userId },
                        { $inc: { matchGotCount: 1 }, $addToSet: { matchWithUserIdList: { userId: otherUserId } } },
                        { upsert: true }
                    );

                    await UserAnalytics.findOneAndUpdate(
                        { userId: otherUserId },
                        { $inc: { matchGotCount: 1 }, $addToSet: { matchWithUserIdList: { userId: userId } } },
                        { upsert: true }
                    );

                    return res.json({ message: 'Right swipe successful. It\'s a match!' });
                } else {
                    return res.json({ message: 'Right swipe successful' });
                }

            } else {
                res.json({ message: 'User(s) not found or created' });
            }
        }
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

// Left Swipe API Endpoint
router.post('/left/', authenticateAPIKey, async (req, res) => {
    const userId = req.body.userId;
    const otherUserId = req.body.otherUserId;

    try {
        if (userId === otherUserId) {
            res.json({ message: 'Cannot swipe left on yourself' });
        } else {
            let currentUser = await UserAnalytics.findOne({ userId: userId });
            let otherUser = await UserAnalytics.findOne({ userId: otherUserId });

            if (!currentUser) {
                currentUser = await UserAnalytics.create({ userId: userId });
            }

            if (!otherUser) {
                otherUser = await UserAnalytics.create({ userId: otherUserId });
            }

            if (currentUser && otherUser) {
                if (
                    currentUser.tillRightSwipedUserIdList.some((user) => user.userId.equals(otherUserId)) &&
                    otherUser.gotRightSwipeUserIdList.some((user) => user.userId.equals(userId))
                ) {
                    // Remove user from right-swiped list and add to left-swiped list
                    await UserAnalytics.findOneAndUpdate(
                        { userId: userId },
                        {
                            $inc: { tillRightSwipedCount: -1 },
                            $pull: { tillRightSwipedUserIdList: { userId: otherUserId } },
                        },
                        { upsert: true }
                    );

                    await UserAnalytics.findOneAndUpdate(
                        { userId: otherUserId },
                        {
                            $inc: { gotRightSwipeCount: -1 },
                            $pull: { gotRightSwipeUserIdList: { userId: userId } },
                        },
                        { upsert: true }
                    );
                }

                if (
                    currentUser.matchWithUserIdList.some((user) => user.userId.equals(otherUserId)) &&
                    otherUser.matchWithUserIdList.some((user) => user.userId.equals(userId))
                ) {
                    // Remove user from match list and add to left-swiped list
                    await UserAnalytics.findOneAndUpdate(
                        { userId: userId },
                        {
                            $inc: { matchGotCount: -1 },
                            $pull: { matchWithUserIdList: { userId: otherUserId } },
                        },
                        { upsert: true }
                    );

                    await UserAnalytics.findOneAndUpdate(
                        { userId: otherUserId },
                        {
                            $inc: { matchGotCount: -1 },
                            $pull: { matchWithUserIdList: { userId: userId } },
                        },
                        { upsert: true }
                    );
                }

                if (
                    currentUser.tillLeftSwipedUserIdList.some((user) => user.userId.equals(otherUserId)) ||
                    otherUser.gotLeftSwipeUserIdList.some((user) => user.userId.equals(userId))
                ) {
                    return res.json({ message: 'Already Left Swiped' });
                }

                await markUserViewed(userId, otherUserId);

                await UserAnalytics.findOneAndUpdate(
                    { userId: userId },
                    {
                        $inc: { tillLeftSwipedCount: 1 },
                        $addToSet: { tillLeftSwipedUserIdList: { userId: otherUserId } },
                    },
                    { upsert: true }
                );

                await UserAnalytics.findOneAndUpdate(
                    { userId: otherUserId },
                    {
                        $inc: { gotLeftSwipeCount: 1 },
                        $addToSet: { gotLeftSwipeUserIdList: { userId: userId } }
                    },
                    { upsert: true }
                );

            } else {
                res.json({ message: 'User(s) not found or created' });
            }

            return res.json({ message: 'Left swipe successful' });
        }
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});



module.exports = router;
