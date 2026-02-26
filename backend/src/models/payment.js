const { DataTypes } = require('sequelize');
const sequelize = require('./index');

const Payment = sequelize.define('Payment', {
  id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
  user_id: { type: DataTypes.UUID, allowNull: false },
  errand_id: { type: DataTypes.UUID, allowNull: true },
  amount: { type: DataTypes.DECIMAL(10, 2), allowNull: false },
  currency: { type: DataTypes.STRING(5), defaultValue: 'EGP' },
  method: { type: DataTypes.ENUM('wallet', 'card', 'cash'), allowNull: false },
  status: { type: DataTypes.ENUM('pending', 'success', 'failed', 'refunded'), defaultValue: 'pending' },
  paymob_order_id: { type: DataTypes.STRING(100), allowNull: true },
  paymob_transaction_id: { type: DataTypes.STRING(100), allowNull: true },
}, {
  tableName: 'payments',
  underscored: true,
  timestamps: true,
});

module.exports = Payment;
