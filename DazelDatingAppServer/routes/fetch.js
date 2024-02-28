const express = require('express');
const router = express.Router();
const User = require('../models/user');
const UserAnalytics = require('../models/userAnalytics');
const path = require('path'); // Import the path module
const exploreAPI = require('./exploreAPI');
const authenticateAPIKey = require('../authMiddleware'); // Adjust the path based on your directory structure
const mongoose = require('mongoose');

router.use('/explore', exploreAPI);

// Route to fetch user details by email or user ID
router.get('/user-details', authenticateAPIKey, async (req, res) => {
  const { email, userId } = req.query;

  try {
    let user;
    if (email) {
      user = await User.findOne({ email: email }); // Find user by email
    } else if (userId) {
      user = await User.findById(userId); // Find user by user ID
    } else {
      return res.status(400).json({ message: 'Missing parameters' });
    }

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.json(user);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.get('/fetch-users/:currentUserId/:opositeGender', authenticateAPIKey, async (req, res) => {
  try {
    const totalUsersToFetch = 5;
    const currentUserId = req.params.currentUserId;
    const opositeGender = req.params.opositeGender;

    // Find or create the UserAnalytics document for the current user
    let userAnalytics = await UserAnalytics.findOne({ userId: currentUserId });

    if (!userAnalytics) {
      userAnalytics = new UserAnalytics({ userId: currentUserId });
      await userAnalytics.save();
    }

    // Get the viewed profile IDs of the current user
    const viewedProfileIds = userAnalytics.viewedProfiles.map(profile => profile.userId);

    // Add the current user's ID to the exclusion list
    viewedProfileIds.push(currentUserId);

    // Fetch random users excluding viewed profiles and the current user
    const randomUsers = await User.aggregate([
      {
        $match: {
          'deleted.isDeleted': false,
          'basicInfo.gender': opositeGender,
          _id: { $nin: viewedProfileIds }
        }
      },
      { $sample: { size: totalUsersToFetch } }
    ]);

    res.json({ users: randomUsers });
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ message: 'Internal server error', error: error.message });
  }
});

router.get('/fetch-best-match/:currentUserId/:oppositeGender', authenticateAPIKey, async (req, res) => {
  try {
    const totalUsersToFetch = 5;
    const currentUserId = req.params.currentUserId;
    const oppositeGender = req.params.oppositeGender;

    // Find or create the UserAnalytics document for the current user
    let userAnalytics = await UserAnalytics.findOne({ userId: currentUserId });

    if (!userAnalytics) {
      userAnalytics = new UserAnalytics({ userId: currentUserId });
      await userAnalytics.save();
    }

    // Get the viewed profile IDs of the current user
    const viewedProfileIds = userAnalytics.viewedProfiles.map(profile => profile.userId);

    // Add the current user's ID to the exclusion list
    viewedProfileIds.push(currentUserId);

    // Fetch random users excluding viewed profiles and the current user
    const randomUsers = await User.aggregate([
      {
        $match: {
          'deleted.isDeleted': false,
          'basicInfo.gender': oppositeGender,
          _id: { $nin: viewedProfileIds }
        }
      },
      {
        $addFields: {
          randomField: { $rand: {} } // Add a random field for shuffling
        }
      },
      {
        $sort: { randomField: 1 } // Sort by the random field to shuffle
      },
      {
        $project: {
          randomField: 0 // Remove the random field from the final result
        }
      },
      { $sample: { size: totalUsersToFetch } }
    ]);

    res.json({ users: randomUsers });
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ message: 'Internal server error', error: error.message });
  }
});

router.post('/fetch-explore-users/:currentUserId/:oppositeGender', authenticateAPIKey, async (req, res) => {
  try {
    const totalUsersToFetch = 5;
    const currentUserId = req.params.currentUserId;
    const oppositeGender = req.params.oppositeGender;
    const typeOfDateList = req.body.typeOfDate; // Assuming typeOfDate is passed in the request body as a list

    // Find or create the UserAnalytics document for the current user
    let userAnalytics = await UserAnalytics.findOne({ userId: currentUserId });

    if (!userAnalytics) {
      userAnalytics = new UserAnalytics({ userId: currentUserId });
      await userAnalytics.save();
    }

    // Get the viewed profile IDs of the current user
    const viewedProfileIds = userAnalytics.viewedProfiles.map(profile => profile.userId);

    // Add the current user's ID to the exclusion list
    viewedProfileIds.push(currentUserId);

    // Fetch random users excluding viewed profiles, the current user, based on typeOfDate, and opposite gender
    const randomUsers = await User.aggregate([
      {
        $match: {
          'deleted.isDeleted': false,
          'basicInfo.gender': oppositeGender,
          'typeOfDate': { $in: typeOfDateList },
          _id: { $nin: viewedProfileIds }
        }
      },
      { $sample: { size: totalUsersToFetch } }
    ]);

    res.json({ users: randomUsers });
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ message: 'Internal server error', error: error.message });
  }
});


// // API to fetch 10 users based on specified criteria
// router.get('/fetch-users/:currentUserId', authenticateAPIKey, async (req, res) => {

//   try {
//     const totalUsersToFetch = 10;
//     const currentUserId = req.params.currentUserId;

//     const currentUser = await User.findById(currentUserId);

//     // Determine opposite gender

//     console.log(currentUser.basicInfo.gender);

//     const oppositeGender = currentUser.basicInfo.gender == 'Men' ? 'Women' : 'Men';

//     // Fetch new users within one week of signup
//     const threeDaysAge = new Date();
//     threeDaysAge.setDate(threeDaysAge.getDate() - 3);
//     const newUsers = await User.find({
//       _id: { $ne: currentUserId },
//       signupDateAndTime: { $gte: threeDaysAge },
//       'basicInfo.gender': oppositeGender,
//       'deleted.isDeleted': false
//     }).limit(Math.ceil(totalUsersToFetch * 0.2));


//     const aggregatedData = await UserAnalytics.aggregate([
//       { $sort: { gotRightSwipeCount: -1 } },
//       { $limit: Math.ceil(totalUsersToFetch * 0.3) },
//       { $group: { _id: "$gotRightSwipeCount", users: { $push: "$$ROOT" } } },
//       { $unwind: "$users" },
//       { $limit: 3 }
//     ]);

//     // Extracting unique userIds from aggregatedData
//     const userIds = aggregatedData.map(user => user.users.userId); // Assuming userId is a field in users object
//     // Querying the User model to fetch all users based on userIds
//     const popularUsers = await User.find({ _id: { $in: userIds } });
//     // Fetch spotlight activated users
//     const spotlightUsers = await User.find({
//       _id: { $ne: currentUserId },
//       'spotlight.isSpotlight': true,
//       'basicInfo.gender': oppositeGender
//     }).limit(Math.ceil(totalUsersToFetch * 0.3));

//     const currentUserDetails = currentUser;
//     // Query users based on multiple criteria
//     const potentialMatches = await User.find({
//       _id: { $ne: currentUserDetails._id }, // Exclude the current user
//       'basicInfo.gender': oppositeGender
//       // Add other criteria here, such as interests, food preferences, etc.
//     }).lean(); // Using lean() to get plain JavaScript objects

//     // Calculate Match for silikar Profiles
//     function calculateMatchScore(currentUser, potentialMatch) {
//       let matchScore = 0;

//       // Type of date match
//       if (currentUser.typeOfDate === potentialMatch.typeOfDate) {
//         matchScore += 30; // Weightage for matching type of date
//       }

//       // Food preferences match
//       const currentUserCuisines = currentUser.foodPreferences?.cuisinesILove || [];
//       const potentialMatchCuisines = potentialMatch.foodPreferences?.cuisinesILove || [];
//       const commonCuisines = currentUserCuisines.filter(pref =>
//         potentialMatchCuisines.includes(pref)
//       );
//       matchScore += commonCuisines.length * 10; // Weightage for matching cuisines

//       // Interests match
//       const currentUserInterests = currentUser.interests || [];
//       const potentialMatchInterests = potentialMatch.interests || [];
//       const commonInterests = currentUserInterests.filter(interest =>
//         potentialMatchInterests.includes(interest)
//       );
//       matchScore += commonInterests.length * 5; // Weightage for matching interests

//       return matchScore;
//     }

//     // Calculate match scores based on preferences
//     const matchedUsersWithScore = potentialMatches.map(user => {
//       // Calculate match score based on criteria and preferences
//       const matchScore = calculateMatchScore(currentUserDetails, user);
//       return { ...user, matchScore }; // Add match score to each user
//     });

//     // Sort users based on match score
//     const sortedMatches = matchedUsersWithScore.sort((a, b) => b.matchScore - a.matchScore);

//     // Get the top matched users
//     const topMatches = sortedMatches.slice(0, totalUsersToFetch * 0.2); // For example, get top 2 matches

//     // Combine all user categories and remove duplicates
//     let combinedUsers = [
//       ...newUsers,
//       ...popularUsers,
//       ...spotlightUsers,
//       ...topMatches,
//     ].filter((user, index, self) =>
//       user && index === self.findIndex(u => u?._id === user?._id)
//     );

//     // If the combined list has fewer than 10 users, fill the remaining slots with random users
//     if (combinedUsers.length < totalUsersToFetch) {
//       const remainingUsersCount = totalUsersToFetch - combinedUsers.length;

//       // Fetch random users excluding the current user
//       const randomUsers = await User.find({
//         _id: { $ne: currentUserId }, // Exclude the current user
//         'basicInfo.gender': oppositeGender,
//       }).limit(remainingUsersCount);

//       // Remove duplicates and exclude the current user from the randomUsers array
//       randomUsers.forEach(user => {
//         if (!combinedUsers.some(u => u?._id === user?._id) && user?._id !== currentUserId) {
//           combinedUsers.push(user);
//         }
//       });
//     }

//     // Ensure the final list contains exactly 10 users
//     combinedUsers = combinedUsers.slice(0, totalUsersToFetch);

//     res.json({ users: combinedUsers });
//   } catch (error) {
//     res.status(500).json({ message: error.message });
//   }
// });


// API to fetch 3 best match users based on specified criteria
router.get('/fetch-best-match-users/:currentUserId', authenticateAPIKey, async (req, res) => {
  try {
    const totalUsersToFetch = 10;
    const currentUserId = req.params.currentUserId;

    const currentUser = await User.findById(currentUserId);

    // Determine opposite gender
    const oppositeGender = currentUser.basicInfo.gender == 'Men' ? 'Women' : 'Men';

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
      ...topMatches,
    ].filter((user, index, self) =>
      user && index === self.findIndex(u => u?._id === user?._id)
    ).slice(0, totalUsersToFetch);

    res.json({ users: combinedUsers });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Route to fetch user data
router.get('/users', async (req, res) => {
  try {
    const users = await User.find({}); // Fetch all users from MongoDB
    res.json(users); // Send fetched user data as JSON response
  } catch (error) {
    res.status(500).json({ error: 'Error fetching user data' });
  }
});

// Define a route to serve uploaded images
router.get('/userImage/:filename', (req, res) => {
  const filename = req.params.filename;
  const imagePath = path.join(__dirname, '../uploads', filename);

  res.sendFile(imagePath);
});

// Define a route to serve uploaded images
router.get('/userMediaOfChat/:filename', (req, res) => {
  const filename = req.params.filename;
  const imagePath = path.join(__dirname, '../chatDocs', filename);

  res.sendFile(imagePath);
});

// Fetch match list with user details (name, media)
router.get('/match-list/:userId', authenticateAPIKey, async (req, res) => {
  const userId = req.params.userId;

  try {
    // Find user analytics by userId
    const analytics = await UserAnalytics.findOne({ userId });

    if (!analytics) {
      return res.status(404).json({ message: 'User analytics not found' });
    }

    // Get matched user IDs
    const matchedUserIds = analytics.matchWithUserIdList.map(match => match.userId);

    // Fetch details (name, media) for matched users from the User collection
    const matchedUsersDetails = await User.find(
      { _id: { $in: matchedUserIds } },
      'name media'
    );

    res.status(200).json({ matchedUsersDetails });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Fetch users who got right swipe details (name, media, message)
router.get('/got-right-swipe/:userId', authenticateAPIKey, async (req, res) => {
  const userId = req.params.userId;
  const onlineThreshold = 1 * 60 * 1000; // 1 minute in milliseconds

  console.log(userId);

  try {
    // Find user analytics by userId
    const userAnalytics = await UserAnalytics.findOne({ userId });

    if (!userAnalytics) {
      return res.status(404).json({ message: 'User analytics not found' });
    }

    // Extract the gotRightSwipeUserIdList
    const gotRightSwipeList = userAnalytics.gotRightSwipeUserIdList;

    if (!gotRightSwipeList || gotRightSwipeList.length === 0) {
      return res.status(200).json({ gotRightSwipeUsersDetails: [] }); // No users received right swipes
    }

    // Get IDs of users who received a right swipe
    const gotRightSwipeUserIds = gotRightSwipeList.map(swipe => swipe.userId);

    // Fetch details (name, media, message) for users who received right swipes from the User collection
    const gotRightSwipeUsersDetails = await User.find(
      { _id: { $in: gotRightSwipeUserIds } },
      'name media dob'
    );

    // Map user details with their corresponding messages, age, and online status
    const userDetailsWithMessage = await Promise.all(
      gotRightSwipeUsersDetails.map(async (user) => {
        const swipe = gotRightSwipeList.find(swipe => swipe.userId.equals(user._id));

        // Fetch online status for each right-swiped user
        const rightSwipedUserAnalytics = await UserAnalytics.findOne({ userId: user._id });

        // Calculate online status based on lastActive within the last 1 minute
        const lastActive = rightSwipedUserAnalytics?.onlineStatus?.lastActive || null;
        const isOnline = lastActive && Date.now() - lastActive.getTime() < onlineThreshold;

        return {
          _id: user._id,
          name: user.name,
          dob: user.dob,
          media: user.media,
          message: swipe ? swipe.message : null,
          isOnline: isOnline,
        };
      })
    );

    res.status(200).json({ gotRightSwipeUsersDetails: userDetailsWithMessage });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Fetch online status of a specific user or create UserAnalytics if not exists
router.get('/user-online-status/:userId', authenticateAPIKey, async (req, res) => {
  const userId = req.params.userId;
  const onlineThreshold = 1 * 60 * 1000; // 1 minute in milliseconds

  try {
    // Find user analytics by userId
    let userAnalytics = await UserAnalytics.findOne({ userId });

    // If UserAnalytics doesn't exist, create a new entry
    if (!userAnalytics) {
      userAnalytics = new UserAnalytics({ userId });
      await userAnalytics.save();
    }

    // Fetch online status for the specified user
    const lastActive = userAnalytics.onlineStatus?.lastActive || null;
    const isOnline = lastActive && Date.now() - lastActive.getTime() < onlineThreshold;

    res.status(200).json({ userId, isOnline });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Fetch last active status of a specific user
router.get('/last-active-status/:userId', authenticateAPIKey, async (req, res) => {
  const userId = req.params.userId;

  try {
    // Find user analytics by userId
    const userAnalytics = await UserAnalytics.findOne({ userId });

    if (!userAnalytics) {
      return res.status(404).json({ message: 'User analytics not found' });
    }

    // Fetch last active status for the specified user
    const lastActive = userAnalytics.onlineStatus?.lastActive || null;

    res.status(200).json({ userId, lastActive });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint to get matches and got likes count
router.get('/get-likes-and-matches', authenticateAPIKey, async (req, res) => {
  try {

    console.log('check ecccc:');

    var uid = req.query.userId;

    const userAnalytics = await UserAnalytics.findOne({ userId: uid });

    if (!userAnalytics) {
      return res.status(404).json({ error: 'User analytics not found' });
    }

    const matchesCount = userAnalytics.matchGotCount;
    const gotLikesCount = userAnalytics.gotRightSwipeCount;

    res.status(200).json({ matchesCount, gotLikesCount });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Endpoint to get spotlight information
router.get('/get-spotlight-info', authenticateAPIKey, async (req, res) => {
  try {
    const userId = req.query.userId; // Assuming you pass userId in the query parameters

    // Fetch the user by userId
    const user = await User.findOne({ _id: userId });

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    const spotlightInfo = {
      isSpotlight: user.spotlight.isSpotlight,
      startMilliseconds: user.spotlight.startMilliseconds,
      autoSpotlight: user.spotlight.autoSpotlight,
    };

    res.json(spotlightInfo);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});



module.exports = router;
