const Errand = require('../models/errand');
const notificationService = require('./notification.service');

const VALID_TRANSITIONS = {
  'draft': ['pending_payment', 'cancelled'],
  'pending_payment': ['confirmed', 'cancelled'],
  'confirmed': ['assigned', 'cancelled'],
  'assigned': ['runner_en_route', 'cancelled'],
  'runner_en_route': ['runner_arrived'],
  'runner_arrived': ['in_progress'],
  'in_progress': ['completed', 'returning', 'issue_reported'],
  'returning': ['completed'],
  'completed': ['rated'],
  'issue_reported': ['in_progress', 'cancelled']
};

class ErrandService {
  async updateStatus(errandId, newStatus, runnerId) {
    const errand = await Errand.findByPk(errandId);
    if (!errand) throw new Error('Errand not found');

    const currentStatus = errand.status;
    if (VALID_TRANSITIONS[currentStatus] && !VALID_TRANSITIONS[currentStatus].includes(newStatus)) {
      throw new Error(`Invalid status transition from ${currentStatus} to ${newStatus}`);
    }

    await errand.update({ status: newStatus });

    if (newStatus === 'runner_arrived') {
      await notificationService.notifyRunnerArrived(errand.customer_id, errand.id);
    }

    return errand;
  }

  async assignRunner(errandId, runnerId) {
    const errand = await Errand.findByPk(errandId);
    if (!errand) throw new Error('Errand not found');

    // Validate current status
    if (errand.status !== 'confirmed') throw new Error('Errand must be confirmed to be assigned');

    await errand.update({ runner_id: runnerId, status: 'assigned' });
    await notificationService.notifyRunnerAssigned(errand.id, errand.customer_id, 'Do4U Runner');

    return errand;
  }
}

module.exports = new ErrandService();
