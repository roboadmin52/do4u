'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('errands', {
      id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV4,
        primaryKey: true,
      },
      errand_number: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
      },
      customer_id: {
        type: Sequelize.UUID,
        allowNull: false,
      },
      runner_id: {
        type: Sequelize.UUID,
        allowNull: true,
      },
      category: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      sub_type: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      status: {
        type: Sequelize.STRING,
        defaultValue: 'draft',
      },
      description: {
        type: Sequelize.TEXT,
      },
      pickup_address: {
        type: Sequelize.JSONB,
      },
      dropoff_address: {
        type: Sequelize.JSONB,
      },
      base_fee: {
        type: Sequelize.DECIMAL(10, 2),
      },
      item_cost: {
        type: Sequelize.DECIMAL(10, 2),
        defaultValue: 0,
      },
      total_price: {
        type: Sequelize.DECIMAL(10, 2),
      },
      is_express: {
        type: Sequelize.BOOLEAN,
        defaultValue: false,
      },
      payment_method: {
        type: Sequelize.STRING,
      },
      payment_status: {
        type: Sequelize.STRING,
        defaultValue: 'pending',
      },
      created_at: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP'),
      },
      updated_at: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP'),
      },
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('errands');
  }
};
