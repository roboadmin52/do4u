'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('payments', {
      id: { type: Sequelize.UUID, defaultValue: Sequelize.UUIDV4, primaryKey: true },
      user_id: { type: Sequelize.UUID, allowNull: false },
      errand_id: { type: Sequelize.UUID, allowNull: true },
      amount: { type: Sequelize.DECIMAL(10, 2), allowNull: false },
      currency: { type: Sequelize.STRING(5), defaultValue: 'EGP' },
      method: { type: Sequelize.ENUM('wallet', 'card', 'cash'), allowNull: false },
      status: { type: Sequelize.ENUM('pending', 'success', 'failed', 'refunded'), defaultValue: 'pending' },
      paymob_order_id: { type: Sequelize.STRING(100), allowNull: true },
      paymob_transaction_id: { type: Sequelize.STRING(100), allowNull: true },
      created_at: { type: Sequelize.DATE, defaultValue: Sequelize.literal('CURRENT_TIMESTAMP') },
      updated_at: { type: Sequelize.DATE, defaultValue: Sequelize.literal('CURRENT_TIMESTAMP') }
    });

    await queryInterface.createTable('memberships', {
      id: { type: Sequelize.UUID, defaultValue: Sequelize.UUIDV4, primaryKey: true },
      user_id: { type: Sequelize.UUID, allowNull: false },
      plan: { type: Sequelize.ENUM('basic', 'plus', 'elite'), allowNull: false },
      started_at: { type: Sequelize.DATE, allowNull: false },
      expires_at: { type: Sequelize.DATE, allowNull: false },
      errands_total: { type: Sequelize.INTEGER, allowNull: false },
      errands_used: { type: Sequelize.INTEGER, defaultValue: 0 },
      monthly_cost_egp: { type: Sequelize.DECIMAL(10, 2), allowNull: false },
      auto_renew: { type: Sequelize.BOOLEAN, defaultValue: true },
      status: { type: Sequelize.ENUM('active', 'expired', 'cancelled'), defaultValue: 'active' },
      created_at: { type: Sequelize.DATE, defaultValue: Sequelize.literal('CURRENT_TIMESTAMP') },
      updated_at: { type: Sequelize.DATE, defaultValue: Sequelize.literal('CURRENT_TIMESTAMP') }
    });

    await queryInterface.createTable('wallet_transactions', {
      id: { type: Sequelize.UUID, defaultValue: Sequelize.UUIDV4, primaryKey: true },
      user_id: { type: Sequelize.UUID, allowNull: false },
      amount: { type: Sequelize.DECIMAL(10, 2), allowNull: false },
      type: { type: Sequelize.STRING(10), allowNull: false }, // credit or debit
      description: { type: Sequelize.STRING(255), allowNull: false },
      created_at: { type: Sequelize.DATE, defaultValue: Sequelize.literal('CURRENT_TIMESTAMP') }
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('payments');
    await queryInterface.dropTable('memberships');
    await queryInterface.dropTable('wallet_transactions');
  }
};
