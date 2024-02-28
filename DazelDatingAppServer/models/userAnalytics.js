const mongoose = require('mongoose');

const userAnalyticsSchema = new mongoose.Schema({
  // current active status
  onlineStatus: {
    lastActive: {
      type: Date,
      default: Date.now,
      required: false
    },
  },
  viewedProfiles: [{
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
    },
    currentTime: {
      type: Date,
      default: Date.now,
    },
  }],
  // current user id
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
    unique: true,
  },
  // Got swipes
  gotLeftSwipeUserIdList: [{
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
    },
    currentTime: {
      type: Date,
      default: Date.now,
    },
  }],
  gotRightSwipeUserIdList: [{
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
    },
    currentTime: {
      type: Date,
      default: Date.now,
    },
    accepted: {
      type: Boolean,
      default: null,
    },
    message: {
      type: String,
      default: null,
    },
  }],
  gotRightSwipeCount: {
    type: Number,
    default: 0,
  },
  gotLeftSwipeCount: {
    type: Number,
    default: 0,
  },

  // Swiped
  tillRightSwipedCount: {
    type: Number,
    default: 0,
  },
  tillLeftSwipedCount: {
    type: Number,
    default: 0,
  },
  tillRightSwipedUserIdList: [{
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
    },
    currentTime: {
      type: Date,
      default: Date.now,
    },
    message: {
      type: String,
      default: null,
    },
  }],
  tillLeftSwipedUserIdList: [{
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
    },
    currentTime: {
      type: Date,
      default: Date.now,
    },
  }],
  // Matches
  matchGotCount: {
    type: Number,
    default: 0,
  },
  matchWithUserIdList: [{
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
    },
    currentTime: {
      type: Date,
      default: Date.now,
    },
  }]
});

const UserAnalytics = mongoose.model('UserAnalytics', userAnalyticsSchema);

module.exports = UserAnalytics;
