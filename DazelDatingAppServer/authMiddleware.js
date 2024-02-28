const constants = require('./constants')

const authenticateAPIKey = (req, res, next) => {
    const apiKey = req.headers['x-api-key']; // Extract the API key from the request headers

    // Check if the API key matches the expected key
    if (apiKey === constants.apiKey) {
        // API key is valid, proceed to the next middleware/route handler
        next();
    } else {
        // Invalid API key, return unauthorized status
        return res.status(401).json({ message: 'Unauthorized' });
    }
};

module.exports = authenticateAPIKey;
