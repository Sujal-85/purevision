const express = require('express');
const router = express.Router();
const Feedback = require('../models/Feedback');
const Complaint = require('../models/Complaint');

// Submit Feedback
router.post('/feedback', async (req, res) => {
    try {
        const { user, rating, improvementAreas, comment } = req.body;

        const newFeedback = new Feedback({
            user,
            rating,
            improvementAreas,
            comment
        });

        await newFeedback.save();
        res.json({ msg: 'Feedback submitted successfully' });
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

// Submit Complaint
router.post('/complaint', async (req, res) => {
    try {
        const { user, orderId, issueType, description } = req.body;

        const newComplaint = new Complaint({
            user,
            orderId,
            issueType,
            description
        });

        await newComplaint.save();
        res.json({ msg: 'Complaint registered successfully' });
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

module.exports = router;
