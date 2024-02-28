
const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  phoneNumber: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  name: {
    type: String,
    required: true,
  },
  dob: {
    type: String,
    required: true,
  },
  media: [{
    type: String,
    required: true,
  }],
  typeOfDate: {
    type: String,
    required: true,
  },
  interests: [{
    type: String,
    required: true,
  }],
  signupDateAndTime: {
    type: Date,
    default: Date.now,
  },
  bio: {
    type: String,
    default: null
  },
  languages: {
    type: [String],
    maxlength: 5,
    default: null,
  },
  foodPreferences: {
    cuisinesILove: {
      type: [String],
      maxlength: 3,
      default: null,
    },
    favouriteDishes: {
      type: [String],
      maxlength: 3,
      default: null,
    },
    cookingAdventure: {
      type: [String],
      maxlength: 3,
      default: null,
    },
  },
  verification: {
    verifiedProfile: {
      type: Boolean,
      default: false,
    },
  },
  basicInfo: {
    work: [{
      jobTitle: {
        type: String
      },
      organization: {
        type: String
      },
    }],
    education: [{
      educationTitle: {
        type: String
      },
      institute: {
        type: String
      },
    }],
    gender: {
      type: String,
      enum: ['Men', 'Women', 'Nonbinary'],
      default: null,
    },
    location: {
      type: String,
      default: null,
    },
    hometown: {
      type: String,
      default: null,
    },
  },
  moreAboutUser: {
    height: {
      type: String,
      default: null,
    },
    doYouWorkout: {
      type: String,
      default: null,
    },
    educationLevel: {
      type: String,
      default: null,
    },
    doYouDrink: {
      type: String,
      default: null,
    },
    smoke: {
      type: String,
      default: null,
    },
    havingKids: {
      type: String,
      default: null,
    },
    starSign: {
      type: String,
      default: null,
    },
    politicalLearning: {
      type: String,
      default: null,
    },
    religiousBelief: {
      type: String,
      default: null,
    },
  },
  writtenPrompts: [{
    prompt: {
      type: String
    },
    answer: {
      type: String
    },
  }],
  openingQuestions: [{
    type: String
  }],
  instagram: {
    isConnected: {
      type: Boolean,
      default: null
    },
    username: {
      type: String,
      default: null
    },
    code: {
      type: String,
      default: null
    },
  },
  spotify: {
    isConnected: {
      type: Boolean,
      default: null
    },
    username: {
      type: String,
      default: null
    },
    model: {
      type: String,
      default: null
    },
  },
  spotlight: {
    isSpotlight: {
      type: Boolean,
      default: false
    },
    startMilliseconds: {
      type: String,
      default: null
    },
    autoSpotlight: {
      type: Boolean,
      default: true,
      required: false,
    },
  },
  realtimeUserLocation: {
    latitude: {
      type: String,
      default: null
    },
    longitude: {
      type: String,
      default: null
    }
  },
  incognitoMode: {
    type: Boolean,
    default: false,
    required: false,
  },
  snooze: {
    isSnoozeEnabled: {
      type: Boolean,
      default: false,
      required: false,
    },
    snoozeMilliSeconds: {
      type: String,
      default: null,
      required: false,
    },
  },
  deleted: {
    isDeleted: {
      type: Boolean,
      default: false,
      required: false
    },
    dateAndTime: {
      type: Date,
      default: null
    }
  }
});

const User = mongoose.model('User', userSchema);

module.exports = User;


