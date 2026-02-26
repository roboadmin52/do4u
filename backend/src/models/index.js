const { Sequelize, DataTypes } = require('sequelize');
const dotenv = require('dotenv');

dotenv.config();

const sequelize = new Sequelize(process.env.DATABASE_URL || 'postgres://localhost:5432/do4u', {
  logging: false,
});

module.exports = sequelize;
