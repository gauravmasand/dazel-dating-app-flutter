const express = require('express');
const router = express.Router();
const User = require('../models/user');
const authenticateAPIKey = require('../authMiddleware'); // Adjust the path based on your directory structure

// API to fetch 10 match users based on specified criteria for explore
router.get('/specific-date/:currentUserId/:dateType', async (req, res) => {
    try {
        const totalUsersToFetch = 10;
        const currentUserId = req.params.currentUserId;
        const dateType = req.params.dateType;
    
        const currentUser = await User.findById(currentUserId);
    
        // Determine opposite gender
        const oppositeGender = currentUser.basicInfo.gender == 'Men' ? 'Women' : 'Men';
    
        // Fetch new users within one week of signup
        const threeDaysAge = new Date();
        threeDaysAge.setDate(threeDaysAge.getDate() - 3);
        const newUsers = await User.find({
          _id: { $ne: currentUserId },
          signupDateAndTime: { $gte: threeDaysAge },
          'basicInfo.gender': oppositeGender,
          'deleted.isDeleted': false
        }).limit(Math.ceil(totalUsersToFetch * 0.2));
    
    
        const aggregatedData = await UserAnalytics.aggregate([
          { $sort: { gotRightSwipeCount: -1 } },
          { $limit: Math.ceil(totalUsersToFetch * 0.3) },
          { $group: { _id: "$gotRightSwipeCount", users: { $push: "$$ROOT" } } },
          { $unwind: "$users" },
          { $limit: 3 }
        ]);
    
        // Extracting unique userIds from aggregatedData
        const userIds = aggregatedData.map(user => user.users.userId); // Assuming userId is a field in users object
    
        // Querying the User model to fetch all users based on userIds
        const popularUsers = await User.find({ _id: { $in: userIds } });
    
    
        // Fetch spotlight activated users
        const spotlightUsers = await User.find({
          _id: { $ne: currentUserId },
          'spotlight.isSpotlight': true,
          'basicInfo.gender': oppositeGender
        }).limit(Math.ceil(totalUsersToFetch * 0.3));
    
        const currentUserDetails = currentUser;
    
        // Query users based on multiple criteria
        const potentialMatches = await User.find({
          _id: { $ne: currentUserDetails._id }, // Exclude the current user
          'basicInfo.gender': oppositeGender
          // Add other criteria here, such as interests, food preferences, etc.
        }).lean(); // Using lean() to get plain JavaScript objects
    
        // Calculate Match for silikar Profiles
        function calculateMatchScore(currentUser, potentialMatch) {
          let matchScore = 0;
    
          // Type of date match
          if (currentUser.typeOfDate === potentialMatch.typeOfDate) {
            matchScore += 30; // Weightage for matching type of date
          }
    
          // Food preferences match
          const currentUserCuisines = currentUser.foodPreferences?.cuisinesILove || [];
          const potentialMatchCuisines = potentialMatch.foodPreferences?.cuisinesILove || [];
          const commonCuisines = currentUserCuisines.filter(pref =>
            potentialMatchCuisines.includes(pref)
          );
          matchScore += commonCuisines.length * 10; // Weightage for matching cuisines
    
          // Interests match
          const currentUserInterests = currentUser.interests || [];
          const potentialMatchInterests = potentialMatch.interests || [];
          const commonInterests = currentUserInterests.filter(interest =>
            potentialMatchInterests.includes(interest)
          );
          matchScore += commonInterests.length * 5; // Weightage for matching interests
    
          return matchScore;
        }
    
        // Calculate match scores based on preferences
        const matchedUsersWithScore = potentialMatches.map(user => {
          // Calculate match score based on criteria and preferences
          const matchScore = calculateMatchScore(currentUserDetails, user);
          return { ...user, matchScore }; // Add match score to each user
        });
    
        // Sort users based on match score
        const sortedMatches = matchedUsersWithScore.sort((a, b) => b.matchScore - a.matchScore);
    
        // Get the top matched users
        const topMatches = sortedMatches.slice(0, totalUsersToFetch * 0.2); // For example, get top 2 matches
    
        // Combine all user categories and send the response
        const combinedUsers = [
          ...newUsers,
          ...popularUsers, // Ensure user exists
          ...spotlightUsers,
          ...topMatches,
        ].filter((user, index, self) =>
          user && index === self.findIndex(u => u?._id === user?._id)
        ).slice(0, totalUsersToFetch);
    
        res.json({ users: combinedUsers });
      } catch (error) {
        res.status(500).json({ message: error.message });
      }
});

module.exports = router;
