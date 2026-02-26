const express = require('express');
const router = express.Router();
const pricingService = require('../services/pricing.service');
const Joi = require('joi');

const estimateSchema = Joi.object({
  category: Joi.string().required(),
  sub_type: Joi.string().required(),
  pickup_address: Joi.object().required(),
  dropoff_address: Joi.object().optional(),
  is_express: Joi.boolean().default(false),
});

const createErrandSchema = Joi.object({
  category: Joi.string().required(),
  sub_type: Joi.string().required(),
  description: Joi.string().required(),
  pickup_address: Joi.object().required(),
  dropoff_address: Joi.object().optional(),
  is_express: Joi.boolean().default(false),
  payment_method: Joi.string().required(),
});

router.post('/pricing/estimate', async (req, res) => {
  try {
    const { error } = estimateSchema.validate(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const estimate = pricingService.calculatePrice({
      category: req.body.category,
      isExpress: req.body.is_express,
      // distance calculation omitted for simplicity in MVP
    });

    res.json(estimate);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.post('/errands', async (req, res) => {
  try {
    const { error } = createErrandSchema.validate(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const estimate = pricingService.calculatePrice({
      category: req.body.category,
      isExpress: req.body.is_express,
    });

    const errand = {
      id: 'mock-uuid-' + Date.now(),
      errand_number: Math.floor(Math.random() * 10000),
      customer_id: 'mock-customer-id', // Would come from JWT
      ...req.body,
      base_fee: estimate.baseFee,
      total_price: estimate.total,
      status: 'pending_payment',
      payment_status: 'pending',
    };

    // In a real app, save to DB: await Errand.create(errand);

    res.status(201).json(errand);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.get('/errands', async (req, res) => {
  // Mocking list of errands
  res.json([]);
});

module.exports = router;
