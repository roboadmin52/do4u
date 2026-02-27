const { DataTypes } = require('sequelize');
const sequelize = require('./index');

const RunnerProfile = sequelize.define('RunnerProfile', {
  id: { type: DataTypes.UUID, primaryKey: true, allowNull: false },
  national_id: { type: DataTypes.STRING(20), unique: true, allowNull: false },
  vehicle_type: { type: DataTypes.ENUM('motorcycle', 'car', 'on_foot'), allowNull: false },
  license_number: { type: DataTypes.STRING(50), allowNull: true },
  specializations: { type: DataTypes.ARRAY(DataTypes.TEXT), defaultValue: [] },
  is_available: { type: DataTypes.BOOLEAN, defaultValue: false },
  total_errands_completed: { type: DataTypes.INTEGER, defaultValue: 0 },
  average_rating: { type: DataTypes.DECIMAL(3, 2), defaultValue: 0.00 },
}, {
  tableName: 'runner_profiles',
  underscored: true,
  timestamps: true,
});

module.exports = RunnerProfile;
