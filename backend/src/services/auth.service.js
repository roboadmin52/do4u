const jwt = require('jsonwebtoken');
const redisClient = require('../redis');
const User = require('../models/user');
const dotenv = require('dotenv');

dotenv.config();

const JWT_PRIVATE_KEY = process.env.JWT_PRIVATE_KEY || 'dummy_private_key';
const OTP_EXPIRY = 300; // 5 minutes

class AuthService {
  async generateOTP(phone) {
    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    // In a real scenario, we would connect to redis
    // await redisClient.set(`otp:${phone}`, otp, { EX: OTP_EXPIRY });
    console.log(`Generated OTP for ${phone}: ${otp}`); // Mocking SMS delivery
    return otp;
  }

  async verifyOTP(phone, otp) {
    // Mocking redis retrieval
    // const storedOTP = await redisClient.get(`otp:${phone}`);
    // return storedOTP === otp;
    return otp === '123456'; // Mocking for development
  }

  generateToken(user) {
    const payload = {
      id: user.id,
      phone: user.phone,
      role: user.role
    };

    // Using HS256 if RS256 keys are missing for simplicity in dev
    const algorithm = process.env.JWT_PRIVATE_KEY ? 'RS256' : 'HS256';

    return jwt.sign(payload, JWT_PRIVATE_KEY, {
      expiresIn: '1h',
      algorithm: algorithm
    });
  }

  async getUserByPhone(phone) {
    return await User.findOne({ where: { phone } });
  }

  async createUser(userData) {
    return await User.create(userData);
  }
}

module.exports = new AuthService();
