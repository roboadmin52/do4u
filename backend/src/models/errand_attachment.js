const { DataTypes } = require('sequelize');
const sequelize = require('./index');

const ErrandAttachment = sequelize.define('ErrandAttachment', {
  id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4, primaryKey: true },
  errand_id: { type: DataTypes.UUID, allowNull: false },
  uploader_id: { type: DataTypes.UUID, allowNull: false },
  attachment_type: { type: DataTypes.STRING(50), allowNull: false },
  file_url: { type: DataTypes.TEXT, allowNull: false },
}, {
  tableName: 'errand_attachments',
  underscored: true,
  timestamps: true,
  updatedAt: false,
});

module.exports = ErrandAttachment;
