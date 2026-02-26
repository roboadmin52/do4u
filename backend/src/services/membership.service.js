const Membership = require('../models/membership');
const User = require('../models/user');
const sequelize = require('../models/index');

class MembershipService {
  constructor() {
    this.plans = {
      basic: { cost: 150, errands: 6 },
      plus: { cost: 350, errands: 15 },
      elite: { cost: 700, errands: 35 }
    };
  }

  async subscribe(userId, planType) {
    const plan = this.plans[planType];
    if (!plan) throw new Error('Invalid plan type');

    const transaction = await sequelize.transaction();
    try {
      const startedAt = new Date();
      const expiresAt = new Date();
      expiresAt.setMonth(expiresAt.getMonth() + 1);

      const membership = await Membership.create({
        user_id: userId,
        plan: planType,
        started_at: startedAt,
        expires_at: expiresAt,
        errands_total: plan.errands,
        monthly_cost_egp: plan.cost,
        status: 'active'
      }, { transaction });

      await User.update({
        membership_plan: planType,
        membership_expiry: expiresAt,
        errands_remaining: plan.errands
      }, { where: { id: userId }, transaction });

      await transaction.commit();
      return membership;
    } catch (err) {
      await transaction.rollback();
      throw err;
    }
  }

  async getActiveMembership(userId) {
    return await Membership.findOne({
      where: { user_id: userId, status: 'active' },
      order: [['created_at', 'DESC']]
    });
  }
}

module.exports = new MembershipService();
