const Errand = require('../models/errand');

class ErrandService {
  async updateStatus(errandId, newStatus, runnerId) {
    const errand = await Errand.findByPk(errandId);
    if (!errand) throw new Error('Errand not found');

    // Basic state machine validation could be added here
    await errand.update({ status: newStatus });
    return errand;
  }

  async assignRunner(errandId, runnerId) {
    const errand = await Errand.findByPk(errandId);
    if (!errand) throw new Error('Errand not found');
    await errand.update({ runner_id: runnerId, status: 'assigned' });
    return errand;
  }
}

module.exports = new ErrandService();
