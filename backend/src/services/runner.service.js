const RunnerProfile = require('../models/runner_profile');
const Errand = require('../models/errand');

class RunnerService {
  async toggleAvailability(runnerId, isAvailable) {
    const profile = await RunnerProfile.findByPk(runnerId);
    if (!profile) throw new Error('Runner profile not found');
    await profile.update({ is_available: isAvailable });
    return profile;
  }

  async getAssignedErrands(runnerId) {
    return await Errand.findAll({
      where: { runner_id: runnerId },
      order: [['created_at', 'DESC']]
    });
  }

  async updateLocation(runnerId, lat, lng) {
    // In a real app, this would update Firestore
    console.log(`Runner ${runnerId} location update: ${lat}, ${lng}`);
    return { success: true };
  }
}

module.exports = new RunnerService();
