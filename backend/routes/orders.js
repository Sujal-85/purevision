const express = require('express');
const router = express.Router();
const Order = require('../models/Order');
const auth = require('../middleware/auth'); // Need to create middleware

// Create Order
router.post('/', async (req, res) => {
    try {
        // In a real app, validate user from token
        // const userId = req.user.id; 

        const { user, products, totalAmount, paymentMethod, shippingAddress } = req.body;

        const newOrder = new Order({
            user, // Should come from auth token ideally
            products,
            totalAmount,
            paymentMethod,
            shippingAddress
        });

        const order = await newOrder.save();
        res.json(order);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

// Get User Orders
router.get('/:userId', async (req, res) => {
    try {
        const orders = await Order.find({ user: req.params.userId }).sort({ createdAt: -1 });
        res.json(orders);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

module.exports = router;
