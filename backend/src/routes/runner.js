const express = require('express');
const router = express.Router();
const runnerService = require('../services/runner.service');
const errandService = require('../services/errand.service');

// MOCK RUNNER ID
const MOCK_RUNNER_ID = '00000000-0000-0000-0000-000000000001';

router.patch('/availability', async (req, res) => {
  try {
    const { is_available } = req.body;
    const profile = await runnerService.toggleAvailability(MOCK_RUNNER_ID, is_available);
    res.json(profile);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.get('/assignments', async (req, res) => {
  try {
    const assignments = await runnerService.getAssignedErrands(MOCK_RUNNER_ID);
    res.json(assignments);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.patch('/assignments/:id/status', async (req, res) => {
  try {
    const { status } = req.body;
    const errand = await errandService.updateStatus(req.params.id, status, MOCK_RUNNER_ID);
    res.json(errand);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.post('/location', async (req, res) => {
  try {
    const { lat, lng } = req.body;
    await runnerService.updateLocation(MOCK_RUNNER_ID, lat, lng);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
