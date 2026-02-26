const express = require('express');
const authRoutes = require('./routes/auth');
const errandRoutes = require('./routes/errand');
const dotenv = require('dotenv');

dotenv.config();

const app = express();

app.use(express.json());

app.use('/v1/auth', authRoutes);
app.use('/v1', errandRoutes);

app.get('/health', (req, res) => {
  res.json({ status: 'OK' });
});

module.exports = app;
