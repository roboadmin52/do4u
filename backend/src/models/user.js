const { DataTypes } = require('sequelize');
const sequelize = require('./index');

const User = sequelize.define('User', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  phone: {
    type: DataTypes.STRING(20),
    unique: true,
    allowNull: false,
  },
  email: {
    type: DataTypes.STRING(255),
    unique: true,
    allowNull: true,
  },
  full_name: {
    type: DataTypes.STRING(255),
    allowNull: false,
  },
  role: {
    type: DataTypes.ENUM('customer', 'runner', 'dispatch', 'admin'),
    defaultValue: 'customer',
  },
  membership_plan: {
    type: DataTypes.ENUM('none', 'basic', 'plus', 'elite'),
    defaultValue: 'none',
  },
  membership_expiry: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  wallet_balance: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0.00,
  },
  errands_remaining: {
    type: DataTypes.INTEGER,
    defaultValue: 0,
  },
  preferred_language: {
    type: DataTypes.STRING(5),
    defaultValue: 'ar',
  },
  profile_photo_url: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  is_active: {
    type: DataTypes.BOOLEAN,
    defaultValue: true,
  },
}, {
  tableName: 'users',
  underscored: true,
  timestamps: true,
});

module.exports = User;
