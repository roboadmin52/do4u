const Payment = require('../models/payment');
const WalletTransaction = require('../models/wallet_transaction');
const User = require('../models/user');
const sequelize = require('../models/index');

class PaymentService {
  async getWalletBalance(userId) {
    const user = await User.findByPk(userId);
    return parseFloat(user.wallet_balance);
  }

  async topUpWallet(userId, amount) {
    const transaction = await sequelize.transaction();
    try {
      const user = await User.findByPk(userId, { transaction });
      const newBalance = parseFloat(user.wallet_balance) + parseFloat(amount);
      await user.update({ wallet_balance: newBalance }, { transaction });

      await WalletTransaction.create({
        user_id: userId,
        amount,
        type: 'credit',
        description: 'Wallet Top-up'
      }, { transaction });

      await transaction.commit();
      return newBalance;
    } catch (err) {
      await transaction.rollback();
      throw err;
    }
  }

  async payWithWallet(userId, amount, errandId) {
    const transaction = await sequelize.transaction();
    try {
      const user = await User.findByPk(userId, { transaction });
      if (parseFloat(user.wallet_balance) < amount) {
        throw new Error('Insufficient wallet balance');
      }

      const newBalance = parseFloat(user.wallet_balance) - parseFloat(amount);
      await user.update({ wallet_balance: newBalance }, { transaction });

      await WalletTransaction.create({
        user_id: userId,
        amount,
        type: 'debit',
        description: `Payment for errand #${errandId}`
      }, { transaction });

      const payment = await Payment.create({
        user_id: userId,
        errand_id: errandId,
        amount,
        method: 'wallet',
        status: 'success'
      }, { transaction });

      await transaction.commit();
      return payment;
    } catch (err) {
      await transaction.rollback();
      throw err;
    }
  }

  async initiatePayMobPayment(userId, errandId, amount) {
    // Mock PayMob integration
    const payment = await Payment.create({
      user_id: userId,
      errand_id: errandId,
      amount,
      method: 'card',
      status: 'pending',
      paymob_order_id: `mock-paymob-${Date.now()}`
    });
    return {
      payment_url: `https://paymob.mock/iframe/${payment.paymob_order_id}`,
      payment_id: payment.id
    };
  }
}

module.exports = new PaymentService();
