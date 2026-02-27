'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('runner_profiles', {
      id: { type: Sequelize.UUID, primaryKey: true, allowNull: false }, // user_id
      national_id: { type: Sequelize.STRING(20), unique: true, allowNull: false },
      vehicle_type: { type: Sequelize.ENUM('motorcycle', 'car', 'on_foot'), allowNull: false },
      license_number: { type: Sequelize.STRING(50), allowNull: true },
      specializations: { type: Sequelize.ARRAY(Sequelize.TEXT), defaultValue: [] },
      is_available: { type: Sequelize.BOOLEAN, defaultValue: false },
      total_errands_completed: { type: Sequelize.INTEGER, defaultValue: 0 },
      average_rating: { type: Sequelize.DECIMAL(3, 2), defaultValue: 0.00 },
      created_at: { type: Sequelize.DATE, defaultValue: Sequelize.literal('CURRENT_TIMESTAMP') },
      updated_at: { type: Sequelize.DATE, defaultValue: Sequelize.literal('CURRENT_TIMESTAMP') }
    });

    await queryInterface.createTable('errand_attachments', {
      id: { type: Sequelize.UUID, defaultValue: Sequelize.UUIDV4, primaryKey: true },
      errand_id: { type: Sequelize.UUID, allowNull: false },
      uploader_id: { type: Sequelize.UUID, allowNull: false },
      attachment_type: { type: Sequelize.STRING(50), allowNull: false },
      file_url: { type: Sequelize.TEXT, allowNull: false },
      uploaded_at: { type: Sequelize.DATE, defaultValue: Sequelize.literal('CURRENT_TIMESTAMP') }
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('runner_profiles');
    await queryInterface.dropTable('errand_attachments');
  }
};
