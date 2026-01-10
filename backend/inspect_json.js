const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '../assets/flipkart_fashion_products_dataset.json');

try {
    const rawData = fs.readFileSync(filePath, 'utf-8');
    const data = JSON.parse(rawData);

    if (Array.isArray(data) && data.length > 0) {
        console.log('Total Records:', data.length);
        console.log('Sample Record Keys:', Object.keys(data[0]));
        console.log('Sample Record:', JSON.stringify(data[0], null, 2));
    } else {
        console.log('Data is not an array or is empty.');
    }
} catch (err) {
    console.error('Error reading file:', err.message);
}
