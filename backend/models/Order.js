const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
    user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    products: [{
        productId: { type: String, required: true }, // Ideally ref to Product model
        title: String,
        price: Number,
        quantity: { type: Number, default: 1 },
        image: String
    }],
    totalAmount: { type: Number, required: true },
    status: {
        type: String,
        enum: ['Ordered', 'Packed', 'Shipped', 'Delivered', 'Cancelled'],
        default: 'Ordered'
    },
    paymentMethod: { type: String, enum: ['COD', 'UPI', 'Card'], required: true },
    transactionId: { type: String }, // For UPI/Card
    shippingAddress: {
        name: String,
        address: String,
        city: String,
        zip: String
    },
    createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Order', orderSchema);
