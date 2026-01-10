import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String title;
  final String? iconUrl; // URL or Asset path
  final IconData? iconData; // Fallback Flutter Icon
  final List<SubCategory> subCategories;

  const CategoryModel({
    required this.id,
    required this.title,
    this.iconUrl,
    this.iconData,
    this.subCategories = const [],
  });
}

class SubCategory {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> childCategories; // Level 3 (optional)
  final String? filterKey; // Key to filter products by

  const SubCategory({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.childCategories = const [],
    this.filterKey,
  });
}

// Static Data for Flipkart-like Hierarchy
class CategoryData {
  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'grocery',
      title: 'Grocery',
      iconUrl:
          'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=200&auto=format&fit=crop',
      subCategories: [
        SubCategory(
          id: 'fruits_veg',
          title: 'Fruits & Vegetables',
          imageUrl:
              'https://images.unsplash.com/photo-1610832958506-aa56368176cf?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Fruits & Vegetables',
        ),
        SubCategory(
          id: 'foodgrains',
          title: 'Rice, Wheat & Grains',
          imageUrl:
              'https://images.unsplash.com/photo-1586201375761-83865001e31c?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Foodgrains',
        ),
        SubCategory(
          id: 'pulses',
          title: 'Pulses & Lentils',
          imageUrl:
              'https://images.unsplash.com/photo-1515543904379-3d757afe72e3?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Pulses',
        ),
        SubCategory(
          id: 'spices',
          title: 'Spices & Masalas',
          imageUrl:
              'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Spices',
        ),
        SubCategory(
          id: 'oils',
          title: 'Cooking Oils & Ghee',
          imageUrl:
              'https://images.unsplash.com/photo-1474979266404-7eaacbcdcc41?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Oil',
        ),
        SubCategory(
          id: 'sugar_salt',
          title: 'Sugar, Salt & Jaggery',
          imageUrl:
              'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Sugar',
        ),
        SubCategory(
          id: 'atta',
          title: 'Atta & Flour',
          imageUrl:
              'https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Atta',
        ),
        SubCategory(
          id: 'dry_fruits',
          title: 'Dry Fruits & Nuts',
          imageUrl:
              'https://images.unsplash.com/photo-1596591606975-97ee5cef3a1e?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Dry Fruits',
        ),
        SubCategory(
          id: 'dairy',
          title: 'Dairy Products',
          imageUrl:
              'https://images.unsplash.com/photo-1628088062854-d1870b4553da?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Dairy',
        ),
        SubCategory(
          id: 'bakery',
          title: 'Bakery & Bread',
          imageUrl:
              'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Bakery',
        ),
        SubCategory(
          id: 'snacks',
          title: 'Snacks & Namkeen',
          imageUrl:
              'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Snacks',
        ),
        SubCategory(
          id: 'beverages',
          title: 'Beverages',
          imageUrl:
              'https://images.unsplash.com/photo-1544145945-f90425340c7e?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Beverages',
        ),
        SubCategory(
          id: 'instant_food',
          title: 'Instant & Ready-to-Eat',
          imageUrl:
              'https://images.unsplash.com/photo-1596797038530-2c107229654b?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Instant',
        ),
        SubCategory(
          id: 'organic',
          title: 'Organic & Healthy',
          imageUrl:
              'https://images.unsplash.com/photo-1540420773420-3366772f4999?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Organic',
        ),
      ],
    ),
    CategoryModel(
      id: 'appliances',
      title: 'Appliances',
      iconUrl:
          'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?q=80&w=200&auto=format&fit=crop',
      subCategories: [
        SubCategory(
          id: 'refrigerators',
          title: 'Refrigerators',
          imageUrl:
              'https://images.unsplash.com/photo-1571175443880-49e1d58b794a?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Refrigerator',
        ),
        SubCategory(
          id: 'washing_machines',
          title: 'Washing Machines',
          imageUrl:
              'https://images.unsplash.com/photo-1626806819282-2c1dc01a5e0c?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Washing Machine',
        ),
        SubCategory(
          id: 'ac',
          title: 'Air Conditioners',
          imageUrl:
              'https://images.unsplash.com/photo-1616664853652-5095b9786a66?q=80&w=200&auto=format&fit=crop',
          filterKey: 'AC',
        ),
        SubCategory(
          id: 'microwave',
          title: 'Microwave Ovens',
          imageUrl:
              'https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Microwave',
        ),
        SubCategory(
          id: 'dishwashers',
          title: 'Dishwashers',
          imageUrl:
              'https://images.unsplash.com/photo-1581622558663-b2e33377dfb2?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Dishwasher',
        ),
        SubCategory(
          id: 'water_purifiers',
          title: 'Water Purifiers',
          imageUrl:
              'https://plus.unsplash.com/premium_photo-1663126298656-33616be83c32?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Purifier',
        ),
        SubCategory(
          id: 'geysers',
          title: 'Geysers / Heaters',
          imageUrl:
              'https://images.unsplash.com/photo-1563453392212-326f5e854473?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Geyser',
        ),
        SubCategory(
          id: 'vacuum',
          title: 'Vacuum Cleaners',
          imageUrl:
              'https://images.unsplash.com/photo-1558317374-a35498f3cc6a?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Vacuum',
        ),
        SubCategory(
          id: 'fans_coolers',
          title: 'Fans & Air Coolers',
          imageUrl:
              'https://images.unsplash.com/photo-1618941716939-553df9c62e23?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Fan',
        ),
        SubCategory(
          id: 'irons',
          title: 'Irons',
          imageUrl:
              'https://images.unsplash.com/photo-1585659722983-3a675dabf194?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Iron',
        ),
        SubCategory(
          id: 'mixers',
          title: 'Mixer Grinders',
          imageUrl:
              'https://images.unsplash.com/photo-1570222094114-284a441dd846?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Mixer',
        ),
      ],
    ),
    CategoryModel(
      id: 'fashion',
      title: 'Fashion',
      iconUrl:
          'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=200&auto=format&fit=crop',
      subCategories: [
        SubCategory(
          id: 'mens_clothing',
          title: 'Men\'s Clothing',
          imageUrl:
              'https://images.unsplash.com/photo-1490114538077-0a7f8cb49891?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Men',
        ),
        SubCategory(
          id: 'womens_clothing',
          title: 'Women\'s Clothing',
          imageUrl:
              'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Women',
        ),
        SubCategory(
          id: 'kids_clothing',
          title: 'Kids\' Clothing',
          imageUrl:
              'https://images.unsplash.com/photo-1622290291314-88e3c4a47bc7?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Kids',
        ),
        SubCategory(
          id: 'ethnic_wear',
          title: 'Ethnic Wear',
          imageUrl:
              'https://images.unsplash.com/photo-1610030469983-98e550d6193c?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Ethnic',
        ),
        SubCategory(
          id: 'western_wear',
          title: 'Western Wear',
          imageUrl:
              'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Western',
        ),
        SubCategory(
          id: 'footwear',
          title: 'Footwear',
          imageUrl:
              'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Footwear',
        ),
        SubCategory(
          id: 'watches',
          title: 'Watches',
          imageUrl:
              'https://images.unsplash.com/photo-1524592094714-0f0654e20314?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Watch',
        ),
        SubCategory(
          id: 'sunglasses',
          title: 'Sunglasses',
          imageUrl:
              'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Sunglasses',
        ),
        SubCategory(
          id: 'jewelry',
          title: 'Jewelry & Accessories',
          imageUrl:
              'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Jewelry',
        ),
        SubCategory(
          id: 'bags_wallets',
          title: 'Bags & Wallets',
          imageUrl:
              'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Bag',
        ),
        SubCategory(
          id: 'innerwear',
          title: 'Innerwear & Sleepwear',
          imageUrl:
              'https://images.unsplash.com/photo-1596482319082-84dc567308dc?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Innerwear',
        ),
      ],
    ),
    CategoryModel(
      id: 'mobiles',
      title: 'Mobiles',
      iconUrl:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=200&auto=format&fit=crop',
      subCategories: [
        SubCategory(
          id: 'smartphones',
          title: 'Smartphones',
          imageUrl:
              'https://images.unsplash.com/photo-1598327105666-5b89351aff23?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Smartphone',
        ),
        SubCategory(
          id: 'feature_phones',
          title: 'Feature Phones',
          imageUrl:
              'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Feature Phone',
        ),
        SubCategory(
          id: 'mobile_covers',
          title: 'Mobile Covers & Cases',
          imageUrl:
              'https://images.unsplash.com/photo-1586953229671-e2a5f66387e5?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Cover',
        ),
        SubCategory(
          id: 'screen_protectors',
          title: 'Screen Protectors',
          imageUrl:
              'https://images.unsplash.com/photo-1592318621487-d5f0e3860bb6?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Protector',
        ),
        SubCategory(
          id: 'chargers',
          title: 'Chargers & Cables',
          imageUrl:
              'https://images.unsplash.com/photo-1583863788434-e58a36330cf0?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Charger',
        ),
        SubCategory(
          id: 'power_banks',
          title: 'Power Banks',
          imageUrl:
              'https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Power Bank',
        ),
        SubCategory(
          id: 'earphones',
          title: 'Earphones & Headphones',
          imageUrl:
              'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Earphone',
        ),
        SubCategory(
          id: 'smartwatches_mob',
          title: 'Smartwatches',
          imageUrl:
              'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Smartwatch',
        ),
        SubCategory(
          id: 'mobile_stands',
          title: 'Mobile Stands',
          imageUrl:
              'https://images.unsplash.com/photo-1586771107445-d3ca888129ff?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Stand',
        ),
        SubCategory(
          id: 'mobile_parts',
          title: 'Replacement Parts',
          imageUrl:
              'https://images.unsplash.com/photo-1597740985671-2a8a3b80502e?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Parts',
        ),
      ],
    ),
    CategoryModel(
      id: 'kitchen',
      title: 'Kitchen',
      iconUrl:
          'https://images.unsplash.com/photo-1590794056226-79ef3a8147e1?q=80&w=200&auto=format&fit=crop',
      subCategories: [
        SubCategory(
          id: 'cookware',
          title: 'Cookware',
          imageUrl:
              'https://images.unsplash.com/photo-1584990347449-a0846b137632?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Cookware',
        ),
        SubCategory(
          id: 'pressure_cookers',
          title: 'Pressure Cookers',
          imageUrl:
              'https://images.unsplash.com/photo-1593121925328-369cc802e345?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Cooker',
        ),
        SubCategory(
          id: 'kitchen_app',
          title: 'Kitchen Appliances',
          imageUrl:
              'https://images.unsplash.com/photo-1570222094114-284a441dd846?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Kitchen Appliance',
        ),
        SubCategory(
          id: 'cutlery',
          title: 'Cutlery & Knives',
          imageUrl:
              'https://images.unsplash.com/photo-1593642532400-2682810df593?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Cutlery',
        ),
        SubCategory(
          id: 'dinner_sets',
          title: 'Dinner Sets',
          imageUrl:
              'https://images.unsplash.com/photo-1603190287605-e6ade32fa852?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Dinner Set',
        ),
        SubCategory(
          id: 'storage',
          title: 'Storage Containers',
          imageUrl:
              'https://images.unsplash.com/photo-1584990347449-a0846b137632?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Storage',
        ),
        SubCategory(
          id: 'gas_stoves',
          title: 'Gas Stoves',
          imageUrl:
              'https://images.unsplash.com/photo-1626143541742-9f8352513c91?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Stove',
        ),
        SubCategory(
          id: 'kitchen_tools',
          title: 'Kitchen Tools',
          imageUrl:
              'https://images.unsplash.com/photo-1590794056226-79ef3a8147e1?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Tools',
        ),
        SubCategory(
          id: 'bottles',
          title: 'Water Bottles',
          imageUrl:
              'https://images.unsplash.com/photo-1602143407151-011141920038?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Bottle',
        ),
        SubCategory(
          id: 'baking',
          title: 'Baking Tools',
          imageUrl:
              'https://images.unsplash.com/photo-1594631252845-29fc4cc8cde9?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Baking',
        ),
      ],
    ),
    CategoryModel(
      id: 'beauty',
      title: 'Beauty',
      iconUrl:
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=200&auto=format&fit=crop',
      subCategories: [
        SubCategory(
          id: 'face_care',
          title: 'Face Care',
          imageUrl:
              'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Face',
        ),
        SubCategory(
          id: 'skin_care',
          title: 'Skin Care',
          imageUrl:
              'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Skin',
        ),
        SubCategory(
          id: 'hair_care',
          title: 'Hair Care',
          imageUrl:
              'https://images.unsplash.com/photo-1522337660859-02fbefca4702?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Hair',
        ),
        SubCategory(
          id: 'makeup',
          title: 'Makeup',
          imageUrl:
              'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Makeup',
        ),
        SubCategory(
          id: 'personal_care_beauty',
          title: 'Personal Care',
          imageUrl:
              'https://images.unsplash.com/photo-1556228720-1987bad2195f?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Personal',
        ),
        SubCategory(
          id: 'mens_grooming',
          title: 'Men\'s Grooming',
          imageUrl:
              'https://images.unsplash.com/photo-1621607512214-68297480165e?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Grooming',
        ),
        SubCategory(
          id: 'womens_hygiene',
          title: 'Women\'s Hygiene',
          imageUrl:
              'https://images.unsplash.com/photo-1608248597279-f99d160bfbc8?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Hygiene',
        ),
        SubCategory(
          id: 'beauty_tools',
          title: 'Beauty Tools',
          imageUrl:
              'https://images.unsplash.com/photo-1596462502278-27bfdd403348?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Tool',
        ),
        SubCategory(
          id: 'perfumes',
          title: 'Perfumes',
          imageUrl:
              'https://images.unsplash.com/photo-1594035910387-fea47794261f?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Perfume',
        ),
        SubCategory(
          id: 'herbal',
          title: 'Organic & Herbal',
          imageUrl:
              'https://images.unsplash.com/photo-1616683693504-3ea7e9ad6fec?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Herbal',
        ),
      ],
    ),
    CategoryModel(
      id: 'gadgets',
      title: 'Smart Gadgets',
      iconUrl:
          'https://images.unsplash.com/photo-1546868871-7041f2a55e12?q=80&w=200&auto=format&fit=crop',
      subCategories: [
        SubCategory(
          id: 'smartwatches_gad',
          title: 'Smartwatches',
          imageUrl:
              'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Smartwatch',
        ),
        SubCategory(
          id: 'fitness_bands',
          title: 'Fitness Bands',
          imageUrl:
              'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Band',
        ),
        SubCategory(
          id: 'smart_home',
          title: 'Smart Home Devices',
          imageUrl:
              'https://images.unsplash.com/photo-1558211583-d26f610c1eb1?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Smart Home',
        ),
        SubCategory(
          id: 'smart_lights',
          title: 'Smart Lights',
          imageUrl:
              'https://images.unsplash.com/photo-1565814329452-e1efa11c5b89?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Light',
        ),
        SubCategory(
          id: 'smart_plugs',
          title: 'Smart Plugs',
          imageUrl:
              'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Plug',
        ),
        SubCategory(
          id: 'smart_speakers',
          title: 'Smart Speakers',
          imageUrl:
              'https://images.unsplash.com/photo-1589492477829-5e65395b66cc?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Speaker',
        ),
        SubCategory(
          id: 'security_cams',
          title: 'Security Cameras',
          imageUrl:
              'https://images.unsplash.com/photo-1557324232-b8917d3c3d63?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Camera',
        ),
        SubCategory(
          id: 'smart_locks',
          title: 'Smart Door Locks',
          imageUrl:
              'https://images.unsplash.com/photo-1558002038-1091a1661116?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Lock',
        ),
        SubCategory(
          id: 'gps',
          title: 'GPS Trackers',
          imageUrl:
              'https://images.unsplash.com/photo-1569317002860-11c753a54b1f?q=80&w=200&auto=format&fit=crop',
          filterKey: 'GPS',
        ),
      ],
    ),
    CategoryModel(
      id: 'electronics',
      title: 'Electronics',
      iconUrl:
          'https://images.unsplash.com/photo-1498049860654-af1a5c5668ba?q=80&w=200&auto=format&fit=crop',
      subCategories: [
        SubCategory(
          id: 'laptops',
          title: 'Laptops',
          imageUrl:
              'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Laptop',
        ),
        SubCategory(
          id: 'tablets',
          title: 'Tablets',
          imageUrl:
              'https://images.unsplash.com/photo-1544816155-12df9643f363?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Tablet',
        ),
        SubCategory(
          id: 'desktops',
          title: 'Desktops',
          imageUrl:
              'https://images.unsplash.com/photo-1593640408182-31c70c8268f5?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Desktop',
        ),
        SubCategory(
          id: 'monitors',
          title: 'Monitors',
          imageUrl:
              'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Monitor',
        ),
        SubCategory(
          id: 'printers',
          title: 'Printers & Scanners',
          imageUrl:
              'https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Printer',
        ),
        SubCategory(
          id: 'computer_acc',
          title: 'Computer Accessories',
          imageUrl:
              'https://images.unsplash.com/photo-1523790016206-67d50dd39c81?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Accessory',
        ),
        SubCategory(
          id: 'networking',
          title: 'Networking Devices',
          imageUrl:
              'https://images.unsplash.com/photo-1544197150-b99a580bbcbf?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Router',
        ),
        SubCategory(
          id: 'storage_dev',
          title: 'Storage Devices',
          imageUrl:
              'https://images.unsplash.com/photo-1628135891394-bb9e5ce6c413?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Storage',
        ),
        SubCategory(
          id: 'speakers_elec',
          title: 'Speakers',
          imageUrl:
              'https://images.unsplash.com/photo-1545459720-aac3e5cdfadc?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Speaker',
        ),
        SubCategory(
          id: 'gaming_acc',
          title: 'Gaming Accessories',
          imageUrl:
              'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Gaming',
        ),
      ],
    ),
    CategoryModel(
      id: 'toys',
      title: 'Toys & Baby Care',
      iconUrl:
          'https://images.unsplash.com/photo-1566576912902-1b91f1a5c601?q=80&w=200&auto=format&fit=crop',
      subCategories: [
        SubCategory(
          id: 'soft_toys',
          title: 'Soft Toys',
          imageUrl:
              'https://images.unsplash.com/photo-1533038590840-1cde6e668a91?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Soft Toy',
        ),
        SubCategory(
          id: 'edu_toys',
          title: 'Educational Toys',
          imageUrl:
              'https://images.unsplash.com/photo-1587654780291-39c940483713?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Educational',
        ),
        SubCategory(
          id: 'action_figures',
          title: 'Action Figures',
          imageUrl:
              'https://images.unsplash.com/photo-1608889175123-8ee362201f81?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Figure',
        ),
        SubCategory(
          id: 'board_games',
          title: 'Board Games',
          imageUrl:
              'https://images.unsplash.com/photo-1632501641765-e568d28b0015?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Game',
        ),
        SubCategory(
          id: 'rc_toys',
          title: 'Remote Control Toys',
          imageUrl:
              'https://images.unsplash.com/photo-1594787318286-3d835c1d207f?q=80&w=200&auto=format&fit=crop',
          filterKey: 'RC',
        ),
        SubCategory(
          id: 'baby_food',
          title: 'Baby Food',
          imageUrl:
              'https://images.unsplash.com/photo-1584736686259-f2305607b36f?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Baby Food',
        ),
        SubCategory(
          id: 'diapers',
          title: 'Diapers & Wipes',
          imageUrl:
              'https://images.unsplash.com/photo-1519689680058-324335c77eba?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Diaper',
        ),
        SubCategory(
          id: 'baby_clothing',
          title: 'Baby Clothing',
          imageUrl:
              'https://images.unsplash.com/photo-1522771930-78848d9293e8?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Baby Cloth',
        ),
        SubCategory(
          id: 'baby_skincare',
          title: 'Baby Skincare',
          imageUrl:
              'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Baby Skin',
        ),
        SubCategory(
          id: 'baby_acc',
          title: 'Baby Care Accessories',
          imageUrl:
              'https://images.unsplash.com/photo-1555252333-9f8e92e65df9?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Baby Acc',
        ),
      ],
    ),
    CategoryModel(
      id: 'household',
      title: 'Household Care',
      iconUrl:
          'https://images.unsplash.com/photo-1563453392212-326f5e854473?q=80&w=200&auto=format&fit=crop',
      subCategories: [
        SubCategory(
          id: 'cleaning',
          title: 'Cleaning Supplies',
          imageUrl:
              'https://images.unsplash.com/photo-1585421514738-01798e1642d3?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Cleaning',
        ),
        SubCategory(
          id: 'detergents',
          title: 'Detergents',
          imageUrl:
              'https://images.unsplash.com/photo-1610557890948-243e69645801?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Detergent',
        ),
        SubCategory(
          id: 'dishwashing',
          title: 'Dishwashing',
          imageUrl:
              'https://images.unsplash.com/photo-1585885570586-ee8d28e08d2d?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Dishwashing',
        ),
        SubCategory(
          id: 'bathroom',
          title: 'Bathroom Cleaners',
          imageUrl:
              'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Bathroom',
        ),
        SubCategory(
          id: 'fresheners',
          title: 'Air Fresheners',
          imageUrl:
              'https://images.unsplash.com/photo-1572490122747-3968d75c6c54?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Freshener',
        ),
        SubCategory(
          id: 'pest_control',
          title: 'Pest Control',
          imageUrl:
              'https://images.unsplash.com/photo-1617163836267-34c89e13d943?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Pest',
        ),
        SubCategory(
          id: 'organization',
          title: 'Home Organization',
          imageUrl:
              'https://images.unsplash.com/photo-1521575865230-689360cc2d17?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Organization',
        ),
        SubCategory(
          id: 'laundry_acc',
          title: 'Laundry Accessories',
          imageUrl:
              'https://images.unsplash.com/photo-1610557890948-243e69645801?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Laundry',
        ),
        SubCategory(
          id: 'paper_products',
          title: 'Paper Products',
          imageUrl:
              'https://images.unsplash.com/photo-1583947215259-38e31be8751f?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Paper',
        ),
        SubCategory(
          id: 'garbage_bags',
          title: 'Garbage Bags',
          imageUrl:
              'https://images.unsplash.com/photo-1606771032551-93c66299b669?q=80&w=200&auto=format&fit=crop',
          filterKey: 'Garbage',
        ),
      ],
    ),
  ];
}
