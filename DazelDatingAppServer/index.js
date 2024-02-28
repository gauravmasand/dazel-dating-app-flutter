const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const authRouter = require('./routes/auth');
const fetchRouter = require('./routes/fetch');
const chatRoutes = require('./routes/chatRoutes');
const swipeAPI = require('./routes/swipeAPI');
const notifications = require('./routes/notifications');
const contact = require('./routes/contact');
const analytics = require('./routes/analytics');
const userdata = require('./routes/UserData');
const operations = require('./routes/operations');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Body parser middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// MongoDB connection
mongoose.connect('mongodb://localhost/DazelDatingAppDataBase', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.log('MongoDB connection error:', err));


app.use('/api/auth', authRouter);

app.use('/api/fetch', fetchRouter);

app.use('/api/chat', chatRoutes);

app.use('/api/swipe', swipeAPI);

app.use('/api/notification', notifications);

app.use('/api/contact', contact);

app.use('/api/analytics', analytics);

app.use('/api/userdata', userdata);

app.use('/api/operations', operations);

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
