const mongoose = require('mongoose');
const dotenv = require('dotenv');
const Product = require('./models/Product');

dotenv.config();

const connectDB = async () => {
    try {
        await mongoose.connect(process.env.MONGO_URI);
        console.log('MongoDB Connected...');
    } catch (err) {
        console.error(err.message);
        process.exit(1);
    }
};

const mapDummyJsonProduct = (item) => ({
    id: `dummyjson-${item.id}`,
    name: item.title,
    brand: item.brand,
    category: item.category,
    subCategory: item.category, // fallback
    price: item.price,
    originalPrice: item.price / (1 - (item.discountPercentage / 100)), // Reverse calc
    discount: `${Math.round(item.discountPercentage)}% Off`,
    rating: item.rating,
    reviews: Math.floor(Math.random() * 500) + 10,
    imageUrl: item.thumbnail,
    images: item.images,
    description: item.description,
    inStock: item.stock > 0,
    isBestSeller: item.rating > 4.5,
    isTrending: item.stock < 50
});

const mapFakeStoreProduct = (item) => ({
    id: `fakestore-${item.id}`,
    name: item.title,
    brand: 'Generic', // FakeStore doesn't have brand
    category: item.category,
    subCategory: item.category,
    price: item.price,
    originalPrice: item.price * 1.2, // Fake 20% markup
    discount: '20% Off',
    rating: item.rating.rate,
    reviews: item.rating.count,
    imageUrl: item.image,
    images: [item.image],
    description: item.description,
    inStock: true,
    isBestSeller: item.rating.rate > 4.0,
    isTrending: item.rating.count > 200
});

const fs = require('fs');
const path = require('path');

const mapFlipkartProduct = (item) => {
    // Helper to clean price strings "2,499" -> 2499
    const parsePrice = (str) => {
        if (!str) return 0;
        return parseFloat(str.toString().replace(/,/g, ''));
    };

    const sellingPrice = parsePrice(item.selling_price);
    const actualPrice = parsePrice(item.actual_price);

    let images = [];
    if (Array.isArray(item.images)) {
        images = item.images;
    } else if (typeof item.images === 'string') {
        try {
            // Sometimes python string repr getting in json? json string?
            // "['url1']" -> simple parse catch
            // Or just single url
            images = [item.images];
        } catch (e) { images = []; }
    }

    // Add a clamp method to Number.prototype if it doesn't exist
    if (!Number.prototype.clamp) {
        Number.prototype.clamp = function (min, max) {
            return Math.min(Math.max(this, min), max);
        };
    }

    return {
        id: `flipkart-${item.pid || Math.random().toString(36).substr(2, 9)}`,
        name: (item.title || 'Unknown Product').substring(0, 100), // Limit name length
        brand: item.brand || 'Generic',
        category: item.category || 'Fashion',
        subCategory: item.sub_category || '',
        price: sellingPrice > 0 ? sellingPrice : 999,
        originalPrice: actualPrice > 0 ? actualPrice : 1999,
        discount: item.discount || '0% Off',
        rating: (parseFloat(item.average_rating) || 0).clamp(0, 5),
        reviews: Math.floor(Math.random() * 100), // Random reviews count
        imageUrl: (images.length > 0 && images[0].startsWith('http')) ? images[0] : 'https://via.placeholder.com/150',
        images: images,
        description: (item.description || 'No description available').substring(0, 500),
        inStock: !item.out_of_stock,
        isBestSeller: (parseFloat(item.average_rating) || 0) > 4.2,
        isTrending: false
    };
};

const seedData = async () => {
    await connectDB();

    try {
        console.log('Fetching & Parsing data...');

        let allProducts = [];

        // 1. Fetch DummyJSON (Keep existing source)
        try {
            const dummyRes = await fetch('https://dummyjson.com/products?limit=200');
            const dummyData = await dummyRes.json();
            allProducts.push(...dummyData.products.map(mapDummyJsonProduct));
        } catch (e) {
            console.log('Failed to fetch DummyJSON (skipping):', e.message);
        }

        // 2. Fetch FakeStoreAPI (Keep existing source)
        try {
            const fakeStoreRes = await fetch('https://fakestoreapi.com/products');
            const fakeStoreData = await fakeStoreRes.json();
            allProducts.push(...fakeStoreData.map(mapFakeStoreProduct));
        } catch (e) {
            console.log('Failed to fetch FakeStoreAPI (skipping):', e.message);
        }

        // 3. Load Flipkart Dataset (Local)
        try {
            const flipkartPath = path.join(__dirname, '../assets/flipkart_fashion_products_dataset.json');
            if (fs.existsSync(flipkartPath)) {
                console.log('Reading Flipkart Dataset...');
                const rawData = fs.readFileSync(flipkartPath, 'utf8');
                const flipkartData = JSON.parse(rawData);

                // Limit to 500 items for now to avoid overwhelming basic UI/DB, or all if robust
                // Let's take a robust slice: 2000 items
                const slice = flipkartData.slice(0, 2000);
                const mappedFlipkart = slice.map(mapFlipkartProduct);

                console.log(`Loaded ${mappedFlipkart.length} Flipkart items.`);
                allProducts.push(...mappedFlipkart);
            } else {
                console.log('Flipkart dataset file not found at:', flipkartPath);
            }
        } catch (e) {
            console.error('Error parsing Flipkart dataset:', e.message);
        }

        console.log(`Total products to seed: ${allProducts.length}`);

        // Clear existing
        await Product.deleteMany({});
        console.log('Cleared existing products.');

        // Insert new (in chunks if necessary, but insertMany handles decently)
        try {
            await Product.insertMany(allProducts, { ordered: false });
        } catch (e) {
            // Ignore duplicate key errors (code 11000)
            if (e.code === 11000 || e.writeErrors) {
                console.log(`Inserted ${e.result ? e.result.nInserted : 'some'} products. (Some duplicates/errors ignored)`);
            } else {
                throw e;
            }
        }

        console.log('Data Imported Successfully!');
        process.exit();
    } catch (err) {
        console.error(err);
        process.exit(1);
    }
};

seedData();
