const express = require('express');
const authRoutes = require('./routes/auth');
const errandRoutes = require('./routes/errand');
const paymentRoutes = require('./routes/payment');
const membershipRoutes = require('./routes/membership');
const runnerRoutes = require('./routes/runner');
const dotenv = require('dotenv');

dotenv.config();

const app = express();

app.use(express.json());

app.use('/v1/auth', authRoutes);
app.use('/v1', errandRoutes);
app.use('/v1/payments', paymentRoutes);
app.use('/v1/memberships', membershipRoutes);
app.use('/v1/runner', runnerRoutes);

app.get('/health', (req, res) => {
  res.json({ status: 'OK' });
});

module.exports = app;
