const express = require('express');
const router = express.Router();
const Product = require('../models/Product');

// Get All Products (with filters)
router.get('/', async (req, res) => {
    try {
        let query = {};

        // Filter by Category
        if (req.query.category) {
            query.category = { $regex: req.query.category, $options: 'i' };
        }

        // Filter by SubCategory
        if (req.query.subCategory) {
            query.subCategory = { $regex: req.query.subCategory, $options: 'i' };
        }

        // Search (Name or Brand)
        if (req.query.search) {
            query.$or = [
                { name: { $regex: req.query.search, $options: 'i' } },
                { brand: { $regex: req.query.search, $options: 'i' } }
            ];
        }

        const products = await Product.find(query);
        res.json(products);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

// Get Single Product by ID
router.get('/:id', async (req, res) => {
    try {
        const product = await Product.findOne({ id: req.params.id });
        if (!product) return res.status(404).json({ msg: 'Product not found' });
        res.json(product);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

// Create Product (Admin/Seed)
router.post('/', async (req, res) => {
    try {
        const newProduct = new Product(req.body);
        const product = await newProduct.save();
        res.json(product);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

// Seed Many Products
router.post('/seed', async (req, res) => {
    try {
        await Product.deleteMany({}); // Clear existing
        const products = await Product.insertMany(req.body);
        res.json(products);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

module.exports = router;
