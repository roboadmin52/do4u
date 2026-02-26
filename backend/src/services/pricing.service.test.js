const pricingService = require('./pricing.service');

function assert(condition, message) {
  if (!condition) {
    throw new Error(message || 'Assertion failed');
  }
}

function runTests() {
  console.log('Running Pricing Engine Tests...');

  // Test Case 1: Base price for shopping (Non-peak)
  const nonPeakTime = new Date('2026-02-23T12:00:00'); // Monday 12pm
  const p1 = pricingService.calculatePrice({ category: 'shopping', timestamp: nonPeakTime });
  assert(p1.total === 100, `Expected 100, got ${p1.total}`);
  console.log('Test 1 Passed: Base shopping price');

  // Test Case 2: Pickup/Dropoff with distance surcharge
  const p2 = pricingService.calculatePrice({ category: 'pickup_dropoff', distance: 10, timestamp: nonPeakTime });
  // Base 80 + (10-5)*5 = 80 + 25 = 105
  assert(p2.total === 105, `Expected 105, got ${p2.total}`);
  console.log('Test 2 Passed: Pickup distance surcharge');

  // Test Case 3: Express fee
  const p3 = pricingService.calculatePrice({ category: 'shopping', isExpress: true, timestamp: nonPeakTime });
  // Base 100 + 40% = 140
  assert(p3.total === 140, `Expected 140, got ${p3.total}`);
  console.log('Test 3 Passed: Express fee');

  // Test Case 4: Peak Fee
  const peakTime = new Date('2026-02-23T09:00:00'); // Monday 9am
  const p4 = pricingService.calculatePrice({ category: 'shopping', timestamp: peakTime });
  // Base 100 + 25% = 125
  assert(p4.total === 125, `Expected 125, got ${p4.total}`);
  console.log('Test 4 Passed: Peak fee');

  // Test Case 5: Membership discount
  const p5 = pricingService.calculatePrice({ category: 'shopping', hasMembership: true, timestamp: nonPeakTime });
  // Base 100 - 20% = 80
  assert(p5.total === 80, `Expected 80, got ${p5.total}`);
  console.log('Test 5 Passed: Membership discount');

  // Test Case 6: Combined everything
  const p6 = pricingService.calculatePrice({
    category: 'pickup_dropoff',
    distance: 10,
    isExpress: true,
    hasMembership: true,
    timestamp: peakTime
  });
  // Base 80
  // Distance Surcharge 25
  // Peak 80 * 0.25 = 20
  // Express 80 * 0.40 = 32
  // Subtotal = 80 + 25 + 20 + 32 = 157
  // Discount = 157 * 0.20 = 31.4
  // Total = 157 - 31.4 = 125.6
  assert(p6.total === 125.6, `Expected 125.6, got ${p6.total}`);
  console.log('Test 6 Passed: Combined calculation');

  console.log('All Pricing Engine Tests Passed!');
}

try {
  runTests();
} catch (error) {
  console.error('Test Failed:', error.message);
  process.exit(1);
}
