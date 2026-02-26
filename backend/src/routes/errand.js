const express = require('express');
const router = express.Router();
const pricingService = require('../services/pricing.service');
const Errand = require('../models/errand');
const Joi = require('joi');

const estimateSchema = Joi.object({
  category: Joi.string().required(),
  sub_type: Joi.string().required(),
  pickup_address: Joi.object().required(),
  dropoff_address: Joi.object().optional(),
  is_express: Joi.boolean().default(false),
  category_details: Joi.object().optional(),
});

const createErrandSchema = Joi.object({
  category: Joi.string().required(),
  sub_type: Joi.string().required(),
  description: Joi.string().required(),
  pickup_address: Joi.object().required(),
  dropoff_address: Joi.object().optional(),
  is_express: Joi.boolean().default(false),
  payment_method: Joi.string().required(),
  category_details: Joi.object().optional(),
});

router.post('/pricing/estimate', async (req, res) => {
  try {
    const { error } = estimateSchema.validate(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });

    const estimate = pricingService.calculatePrice({
      category: req.body.category,
      isExpress: req.body.is_express,
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

    // Mocking customer_id from a supposed auth middleware
    const USER_ID_MOCK = '00000000-0000-0000-0000-000000000000';

    const errand = await Errand.create({
      customer_id: USER_ID_MOCK,
      ...req.body,
      base_fee: estimate.baseFee,
      total_price: estimate.total,
      status: 'pending_payment',
      payment_status: 'pending',
    });

    res.status(201).json(errand);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.get('/errands', async (req, res) => {
  try {
    const errands = await Errand.findAll({
      order: [['created_at', 'DESC']]
    });
    res.json(errands);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.get('/errands/:id', async (req, res) => {
  try {
    const errand = await Errand.findByPk(req.params.id);
    if (!errand) return res.status(404).json({ message: 'Errand not found' });
    res.json(errand);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
