const { DataTypes } = require('sequelize');
const sequelize = require('./index');

const Membership = sequelize.define('Membership', {
  id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
  user_id: { type: DataTypes.UUID, allowNull: false },
  plan: { type: DataTypes.ENUM('basic', 'plus', 'elite'), allowNull: false },
  started_at: { type: DataTypes.DATE, allowNull: false },
  expires_at: { type: DataTypes.DATE, allowNull: false },
  errands_total: { type: DataTypes.INTEGER, allowNull: false },
  errands_used: { type: DataTypes.INTEGER, defaultValue: 0 },
  monthly_cost_egp: { type: DataTypes.DECIMAL(10, 2), allowNull: false },
  auto_renew: { type: DataTypes.BOOLEAN, defaultValue: true },
  status: { type: DataTypes.ENUM('active', 'expired', 'cancelled'), defaultValue: 'active' },
}, {
  tableName: 'memberships',
  underscored: true,
  timestamps: true,
});

module.exports = Membership;
