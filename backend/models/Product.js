const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
    id: { type: String, required: true, unique: true }, // CSV/Frontend ID
    name: { type: String, required: true },
    brand: { type: String },
    category: { type: String },
    subCategory: { type: String },
    price: { type: Number, required: true },
    originalPrice: { type: Number },
    discount: { type: String },
    rating: { type: Number, default: 0 },
    reviews: { type: Number, default: 0 },
    imageUrl: { type: String },
    images: [String],
    description: { type: String },
    isBestSeller: { type: Boolean, default: false },
    isTrending: { type: Boolean, default: false },
    inStock: { type: Boolean, default: true },
    createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Product', productSchema);
