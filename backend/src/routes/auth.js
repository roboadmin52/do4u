const express = require('express');
const router = express.Router();
const authService = require('../services/auth.service');
const Joi = require('joi');

// Validation schemas
const sendOtpSchema = Joi.object({
  phone: Joi.string().required().pattern(/^\+20\d{10}$/)
});

const verifyOtpSchema = Joi.object({
  phone: Joi.string().required().pattern(/^\+20\d{10}$/),
  otp: Joi.string().required().length(6)
});

const registerSchema = Joi.object({
  phone: Joi.string().required().pattern(/^\+20\d{10}$/),
  full_name: Joi.string().required().min(3),
  email: Joi.string().email().optional()
});

router.post('/send-otp', async (req, res) => {
  try {
    const { error } = sendOtpSchema.validate(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const { phone } = req.body;
    await authService.generateOTP(phone);

    res.json({ message: 'OTP sent successfully' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.post('/verify-otp', async (req, res) => {
  try {
    const { error } = verifyOtpSchema.validate(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const { phone, otp } = req.body;
    const isValid = await authService.verifyOTP(phone, otp);

    if (!isValid) {
      return res.status(401).json({ message: 'Invalid OTP' });
    }

    let user = await authService.getUserByPhone(phone);
    const isNewUser = !user;

    let token = null;
    if (user) {
      token = authService.generateToken(user);
    }

    res.json({
      message: 'OTP verified',
      isNewUser,
      token,
      user: user || null
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.post('/register', async (req, res) => {
  try {
    const { error } = registerSchema.validate(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const { phone, full_name, email } = req.body;

    let user = await authService.getUserByPhone(phone);
    if (user) {
      return res.status(400).json({ message: 'User already exists' });
    }

    user = await authService.createUser({
      phone,
      full_name,
      email,
      role: 'customer'
    });

    const token = authService.generateToken(user);

    res.status(201).json({
      message: 'User registered successfully',
      token,
      user
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
