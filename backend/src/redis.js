const { createClient } = require('redis');
const dotenv = require('dotenv');

dotenv.config();

const redisClient = createClient({
  url: process.env.REDIS_URL || 'redis://localhost:6379'
});

redisClient.on('error', (err) => console.log('Redis Client Error', err));

(async () => {
  // await redisClient.connect(); // Commented out because we don't have redis running in sandbox usually
})();

module.exports = redisClient;
