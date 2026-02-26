const { DataTypes } = require('sequelize');
const sequelize = require('./index');

const Errand = sequelize.define('Errand', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  errand_number: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
  },
  customer_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  runner_id: {
    type: DataTypes.UUID,
    allowNull: true,
  },
  category: {
    type: DataTypes.ENUM('government', 'shopping', 'pickup_dropoff', 'queueing', 'car', 'custom'),
    allowNull: false,
  },
  sub_type: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  status: {
    type: DataTypes.ENUM(
      'draft', 'pending_payment', 'confirmed', 'assigned', 'runner_en_route',
      'runner_arrived', 'in_progress', 'returning', 'completed', 'rated',
      'cancelled', 'issue_reported'
    ),
    defaultValue: 'draft',
  },
  description: {
    type: DataTypes.TEXT,
  },
  pickup_address: {
    type: DataTypes.JSONB,
  },
  dropoff_address: {
    type: DataTypes.JSONB,
  },
  base_fee: {
    type: DataTypes.DECIMAL(10, 2),
  },
  item_cost: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
  },
  total_price: {
    type: DataTypes.DECIMAL(10, 2),
  },
  is_express: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  payment_method: {
    type: DataTypes.ENUM('wallet', 'card', 'cash'),
  },
  payment_status: {
    type: DataTypes.ENUM('pending', 'paid', 'refunded'),
    defaultValue: 'pending',
  },
  category_details: {
    type: DataTypes.JSONB,
  }
}, {
  tableName: 'errands',
  underscored: true,
  timestamps: true,
});

module.exports = Errand;
