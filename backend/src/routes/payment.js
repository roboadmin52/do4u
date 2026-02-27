const express = require('express');
const router = express.Router();
const paymentService = require('../services/payment.service');

// MOCK USER ID for now
const MOCK_USER_ID = '00000000-0000-0000-0000-000000000000';

router.get('/me/wallet', async (req, res) => {
  try {
    const balance = await paymentService.getWalletBalance(MOCK_USER_ID);
    res.json({ balance });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.post('/me/wallet/topup', async (req, res) => {
  try {
    const { amount } = req.body;
    const newBalance = await paymentService.topUpWallet(MOCK_USER_ID, amount);
    res.json({ balance: newBalance });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.post('/initiate', async (req, res) => {
  try {
    const { errand_id, amount } = req.body;
    const result = await paymentService.initiatePayMobPayment(MOCK_USER_ID, errand_id, amount);
    res.json(result);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.post('/webhook', async (req, res) => {
  try {
    await paymentService.handlePayMobWebhook(req.body);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.get('/me/transactions', async (req, res) => {
  try {
    const history = await paymentService.getTransactionHistory(MOCK_USER_ID);
    res.json(history);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
