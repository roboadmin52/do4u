class PricingService {
  constructor() {
    this.baseFees = {
      'government': 150,
      'shopping': 100,
      'pickup_dropoff': 80,
      'queueing': 100,
      'car': 200,
      'custom': 0 // Manual quoting
    };
  }

  calculatePrice({
    category,
    distance = 0,
    isExpress = false,
    hasMembership = false,
    timestamp = new Date()
  }) {
    if (category === 'custom') return { total: 0, isManual: true };

    let baseFee = this.baseFees[category] || 100;

    // Distance Surcharge
    let distanceSurcharge = 0;
    if (category === 'pickup_dropoff' && distance > 5) {
      distanceSurcharge = (distance - 5) * 5;
    }

    // Peak Fee (+25%)
    let peakFee = 0;
    const hour = timestamp.getHours();
    const day = timestamp.getDay(); // 0 is Sunday, 6 is Saturday
    const isWeekday = day >= 1 && day <= 5;
    const isPeakTime = (hour >= 8 && hour < 10) || (hour >= 17 && hour < 20);

    if (isWeekday && isPeakTime) {
      peakFee = baseFee * 0.25;
    }

    // Express Fee (+40%)
    let expressFee = 0;
    if (isExpress) {
      expressFee = baseFee * 0.40;
    }

    // Subtotal before discount
    let subtotal = baseFee + distanceSurcharge + peakFee + expressFee;

    // Membership Discount (20%)
    let discount = 0;
    if (hasMembership) {
      discount = subtotal * 0.20;
    }

    let total = subtotal - discount;

    return {
      baseFee,
      distanceSurcharge,
      peakFee,
      expressFee,
      discount,
      total: Math.round(total * 100) / 100
    };
  }
}

module.exports = new PricingService();
