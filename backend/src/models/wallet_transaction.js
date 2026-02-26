const { DataTypes } = require('sequelize');
const sequelize = require('./index');

const WalletTransaction = sequelize.define('WalletTransaction', {
  id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
  user_id: { type: DataTypes.UUID, allowNull: false },
  amount: { type: DataTypes.DECIMAL(10, 2), allowNull: false },
  type: { type: DataTypes.STRING(10), allowNull: false },
  description: { type: DataTypes.STRING(255), allowNull: false },
}, {
  tableName: 'wallet_transactions',
  underscored: true,
  timestamps: true,
  updatedAt: false,
});

module.exports = WalletTransaction;
