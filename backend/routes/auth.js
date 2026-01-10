const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

// Register
router.post('/register', async (req, res) => {
    try {
        const { name, email, password, phone } = req.body;

        // Check if user exists
        let user = await User.findOne({ email });
        if (user) return res.status(400).json({ msg: 'User already exists' });

        // Hash Password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        user = new User({
            name,
            email,
            password: hashedPassword,
            phone
        });

        await user.save();

        // Create Token
        const payload = { userId: user.id };
        const token = jwt.sign(payload, process.env.JWT_SECRET || 'secret', { expiresIn: '1h' });

        res.json({ token, user: { id: user.id, name: user.name, email: user.email } });

    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server error');
    }
});

// Login
router.post('/login', async (req, res) => {
    try {
        const { email, password } = req.body;

        // Check User
        let user = await User.findOne({ email });
        if (!user) return res.status(400).json({ msg: 'Invalid Credentials' });

        // Validate Password
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({ msg: 'Invalid Credentials' });

        // Create Token
        const payload = { userId: user.id };
        const token = jwt.sign(payload, process.env.JWT_SECRET || 'secret', { expiresIn: '1h' });

        res.json({ token, user: { id: user.id, name: user.name, email: user.email } });

    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server error');
    }
});

// Sync User (Firebase -> MongoDB)
router.post('/sync', async (req, res) => {
    try {
        const { uid, email, name, phone } = req.body;

        let user = await User.findOne({ email });

        if (user) {
            // Update existing user
            user.name = name || user.name;
            user.phone = phone || user.phone;
            await user.save();
        } else {
            // Create new user
            user = new User({
                name: name || 'User',
                email,
                password: uid, // Temporary: Use UID as password for external auth
                phone: phone || '0000000000'
            });
            await user.save();
        }

        // Create Token
        const payload = { userId: user.id };
        const token = jwt.sign(payload, process.env.JWT_SECRET || 'secret', { expiresIn: '1h' });

        res.json({ token, user: { id: user.id, name: user.name, email: user.email } });

    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server error');
    }
});

module.exports = router;
