const express = require('express');
const multer = require('multer');
const bodyParser = require('body-parser');
const User = require('../models/user');
const AuthData = require('../models/AuthModel');
const { DOMAIN } = require('../constants'); // Import the constant
const authenticateAPIKey = require('../authMiddleware'); // Adjust the path based on your directory structure
const Verification = require('../models/ProfileVerificationModel'); // Import your Verification model
const axios = require('axios');
const { stringify } = require('qs');


const router = express.Router();
router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.json());

// Multer configuration for handling media uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // Specify the directory to store the uploaded files
  },
  filename: function (req, file, cb) {
    const uniqueFilename = `${Date.now()}-${file.originalname}`;
    cb(null, uniqueFilename);
  },
});

const upload = multer({ storage: storage });

router.get('/instagram-connect', async (req, res) => {
  const { code, user_id } = req.query.code;

  try {

    console.log(code);
    console.log(user_id);

  } catch (error) {
    
  }
});

// Add this route to your existing router
router.post('/upload-media/:userId', authenticateAPIKey, upload.array('media', 6), async (req, res) => {
  const userId = req.params.userId;

  console.log(userId);

  try {
    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Delete old media files from the uploads directory
    // user.media.forEach(oldMediaFile => {
    //   const filePath = `uploads/${oldMediaFile}`;
    //   fs.unlinkSync(filePath);
    // });

    // Empty the current list of media data
    user.media = [];

    const newMediaFiles = req.files.map(file => file.filename);
    user.media.push(...newMediaFiles);

    // Save the updated user with new media
    const updatedUser = await user.save();

    res.status(200).json(updatedUser.media);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// User Signup API
router.post('/signup', authenticateAPIKey, upload.array('media', 6), async (req, res) => {
  const {
    phoneNumber,
    email,
    password,
    name,
    dob,
    gender,
    typeOfDate,
    interestsRaw,
    accountSignupType
  } = req.body;

  try {

    const interests = interestsRaw.split(',');
    const mediaFiles = req.files.map(file => file.filename);

    const newUser = new User({
      phoneNumber,
      email,
      name,
      dob,
      media: mediaFiles,
      typeOfDate,
      interests,
      // Add default or null values for the new fields in the schema
      bio: null,
      languages: null,
      foodPreferences: {
        cuisinesILove: null,
        favouriteDishes: null,
        cookingAdventure: null,
      },
      verification: {
        verifiedProfile: false
      },
      basicInfo: {
        work: [],
        education: [],
        gender: gender,
        location: null,
        hometown: null,
      },
      moreAboutUser: {
        height: null,
        doYouWorkout: null,
        educationLevel: null,
        doYouDrink: null,
        smoke: null,
        havingKids: null,
        starSign: null,
        politicalLearning: null,
        religiousBelief: null,
      },
      writtenPrompts: [],
      openingQuestions: [],
      instagram: {
        isConnected: false,
        username: null,
        model: null,
      },
      spotify: {
        isConnected: false,
        username: null,
        model: null,
      },
      spotlight: {
        isSpotlight: false,
        spotlightStartDateAndTime: "",
        autoSpotlight: true,
      },
      realtimeUserLocation: { latitude: "", longitude: "" },
      incognitoMode: false,
      snooze: {
        isSnoozeEnabled: false,
        snoozeMilliSeconds: "",
      }
    });

    const savedUser = await newUser.save();

    const authData = new AuthData({
      email,
      password,
      userId: savedUser._id,
      accountSignupType
    });

    await authData.save();

    res.status(200).json(savedUser);

  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// User Login API
router.post('/login', authenticateAPIKey, async (req, res) => {
  const { email, password } = req.body;
  console.log(req.body); // Log the request body

  try {
    const user = await AuthData.findOne({ email: email }); // Find user by email in MongoDB

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Compare passwords (assuming password hashing is implemented)
    if (user.password !== password) {
      return res.status(401).json({ message: 'Invalid password' });
    }

    const userData = await User.findById(user.userId); // Find user by id in MongoDB

    // If authentication succeeds, return user data (you might want to exclude sensitive info like password)
    res.json(userData);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// User Edit Profile API
router.post('/editprofile/:userId', authenticateAPIKey, async (req, res) => {
  const userId = req.params.userId; // Extract user ID from the request parameters

  try {
    const user = await User.findById(userId); // Find the user by ID

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Update user fields with the provided data
    for (const key in req.body) {
      if (Object.prototype.hasOwnProperty.call(req.body, key)) {
        // Check if the key exists in the user object and update if it does
        if (user[key] !== undefined) {
          user[key] = req.body[key];
        }
      }
    }

    // Save the updated user data
    const updatedUser = await user.save();
    res.json(updatedUser);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Check email exist in database
router.post('/check-email', authenticateAPIKey, async (req, res) => {
  const { email } = req.body;
  console.log(req.body);

  try {
    const user = await User.findOne({ email: email });

    if (!user) {
      return res.status(404).send(false);
    }

    res.status(200).send(true);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// API endpoint for profile verification
router.post('/verify-profile', authenticateAPIKey, upload.single('verificationImage'), async (req, res) => {
  try {
    const { userId } = req.body;
    const verificationImage = req.file; // Assuming the image is sent as 'verificationImage' in the form data

    // Check if the image and user ID are provided
    if (!verificationImage || !userId) {
      return res.status(400).json({ message: 'Please provide both user ID and verification image.' });
    }

    // Save the verification data to the database
    const verificationData = {
      userId,
      imagePath: verificationImage.path, // Store the path to the image file
      // Add more fields if needed
    };

    // Create a new Verification document using your model
    const verification = await Verification.create(verificationData);

    res.json({ message: 'Profile verification data saved successfully.', verification });
  } catch (err) {
    res.status(500).json({ message: 'Failed to save profile verification data.', error: err.message });
  }
});

// Calculate profile completion percentage
router.get('/profileCompletionScore/:userId', authenticateAPIKey, async (req, res) => {
  const userId = req.params.userId;

  try {
    const userDetails = await User.findById(userId);

    if (!userDetails) {
      return res.status(404).json({ message: 'User not found' });
    }

    let completedFields = 0;
    const totalFields = 25; // Total number of fields

    // Check each field to determine if it's completed
    if (userDetails.typeOfDate) completedFields++;
    if (userDetails.bio) completedFields++;
    if (userDetails.interests.length >= 5) completedFields++;
    if (userDetails.languages && userDetails.languages.length > 0) completedFields++;
    if (userDetails.verification.verifiedProfile) completedFields++;
    if (userDetails.basicInfo && Object.keys(userDetails.basicInfo).length > 0) completedFields++;
    if (userDetails.moreAboutUser && Object.keys(userDetails.moreAboutUser).length > 0) completedFields++;
    if (userDetails.media && userDetails.media.length > 0) completedFields++;
    if (userDetails.foodPreferences && Object.values(userDetails.foodPreferences).some(pref => pref && pref.length > 0)) completedFields++;
    if (userDetails.writtenPrompts && userDetails.writtenPrompts.length > 0) completedFields++;
    if (userDetails.openingQuestions && userDetails.openingQuestions.length > 0) completedFields++;
    if (userDetails.instagram && userDetails.instagram.isConnected !== null) completedFields++;
    if (userDetails.spotify && userDetails.spotify.isConnected !== null) completedFields++;

    const profileCompletionPercentage = Math.round((completedFields / totalFields) * 100);

    res.json({ profileCompletionPercentage });

  } catch (err) {
    res.status(500).json({ message: 'Failed to calculate profile completion', error: err.message });
  }
});

// Change Password API
router.post('/change-password', authenticateAPIKey, async (req, res) => {
  const { email, currentPassword, newPassword } = req.body;

  try {
    // Find the user by userId
    const user = await AuthData.findOne({ email: email });

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Check if the current password matches the stored hashed password

    if (currentPassword !== user.password) {
      return res.status(401).json({ message: 'Incorrect current password' });
    }

    // Update the user's password with the new hashed password
    user.password = newPassword;

    // Save the updated user object with the new password
    await user.save();

    res.json({ message: 'Password updated successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Forgot Password API
router.post('/forgot-password', async (req, res) => {
  const { email } = req.body;

  try {
    // Find the user by their email
    const user = await AuthData.findOne({ email: email });

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Generate a unique reset token using crypto
    const resetToken = crypto.randomBytes(20).toString('hex');

    // Set the reset token and expiry time in the user object
    user.resetPasswordToken = resetToken;
    user.resetPasswordExpires = Date.now() + 3600000; // 1 hour for token expiry

    // Save the updated user object with reset token and expiry time
    await user.save();

    // Create a nodemailer transporter for sending emails (configure as needed)
    const transporter = nodemailer.createTransport({
      // Your email service configuration (SMTP, etc.)
    });

    // Send email with the reset password link containing the resetToken
    const mailOptions = {
      from: 'your@email.com',
      to: email,
      subject: 'Reset Your Password',
      text: `To reset your password, click on this link: ${process.env.CLIENT_URL}/reset-password/${resetToken}`,
    };

    await transporter.sendMail(mailOptions);

    res.json({ message: 'Password reset email sent successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Delete User Profile API
router.delete('/delete-profile/:userId', authenticateAPIKey, async (req, res) => {
  const userId = req.params.userId;

  try {
    // Find the user by userId and update the 'deleted' field
    const deletedUser = await User.findByIdAndUpdate(userId, {
      'deleted.isDeleted': true,
      'deleted.dateAndTime': Date.now(),
    }, { new: true });

    if (!deletedUser) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.json({ message: 'User profile deleted successfully', deletedUser });
  } catch (error) {
    res.status(500).json({ error: 'Internal server error' });
  }
});



module.exports = router;
