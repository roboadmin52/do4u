'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('users', {
      id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV4,
        primaryKey: true,
        allowNull: false
      },
      phone: {
        type: Sequelize.STRING(20),
        unique: true,
        allowNull: false
      },
      email: {
        type: Sequelize.STRING(255),
        unique: true,
        allowNull: true
      },
      full_name: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      role: {
        type: Sequelize.ENUM('customer', 'runner', 'dispatch', 'admin'),
        defaultValue: 'customer',
        allowNull: false
      },
      membership_plan: {
        type: Sequelize.ENUM('none', 'basic', 'plus', 'elite'),
        defaultValue: 'none',
        allowNull: false
      },
      membership_expiry: {
        type: Sequelize.DATE,
        allowNull: true
      },
      wallet_balance: {
        type: Sequelize.DECIMAL(10, 2),
        defaultValue: 0.00,
        allowNull: false
      },
      errands_remaining: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
        allowNull: false
      },
      preferred_language: {
        type: Sequelize.STRING(5),
        defaultValue: 'ar',
        allowNull: false
      },
      profile_photo_url: {
        type: Sequelize.TEXT,
        allowNull: true
      },
      is_active: {
        type: Sequelize.BOOLEAN,
        defaultValue: true,
        allowNull: false
      },
      created_at: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      },
      updated_at: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      }
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('users');
  }
};
