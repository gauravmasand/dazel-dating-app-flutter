const express = require('express');
const router = express.Router();
const Contact = require('../models/contactModel');
const authenticateAPIKey = require('../authMiddleware'); // Adjust the path based on your directory structure

// Create a new contact entry
router.post('/', authenticateAPIKey, async (req, res) => {
  const { userId, title, description } = req.body;

  try {
    const contact = await Contact.create({ userId, title, description });
    res.json({ message: 'Contact created successfully', contact });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

module.exports = router;
