const express = require('express');
const router = express.Router();
const membershipService = require('../services/membership.service');

const MOCK_USER_ID = '00000000-0000-0000-0000-000000000000';

router.post('/subscribe', async (req, res) => {
  try {
    const { plan } = req.body;
    const membership = await membershipService.subscribe(MOCK_USER_ID, plan);
    res.json(membership);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.get('/me', async (req, res) => {
  try {
    const membership = await membershipService.getActiveMembership(MOCK_USER_ID);
    res.json(membership);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
