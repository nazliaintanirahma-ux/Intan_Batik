import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final String price;
  final String oldPrice;
  final String image;
  final String description;
  final double rating;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.oldPrice,
    required this.image,
    required this.description,
    required this.rating,
  });
  
  static const List<Product> sampleProducts = [
    Product(
      id: '1',
      name: 'Classic Skirt',
      category: 'Pakaian',
      price: '189000',
      oldPrice: '249000',
      image: 'assets/images/rok lv.jpg',
      description: 'Kemeja oversized dengan bahan nyaman untuk gaya kasual.',
      rating: 4.9,
    ),
    
    Product(
      id: '2',
      name: 'Classic Trousers',
      category: 'Pakaian',
      price: '329000',
      oldPrice: '399000',
      image: 'assets/images/celana.jpg',
      description: 'Celana Pria untuk tampilan formal dan elegan.',
      rating: 4.8,
    ),
    Product(
      id: '3',
      name: 'Casual Sneakers',
      category: 'Sepatu',
      price: '279000',
      oldPrice: '350000',
      image: 'assets/images/sepatu.jpg',
      description: 'Sneakers kasual yang nyaman untuk aktivitas sehari-hari.',
      rating: 4.9,
    ),
    Product(
      id: '4',
      name: 'Elegant Shoulder Bag',
      category: 'Tas',
      price: '219000',
      oldPrice: '289000',
      image: 'assets/images/tas hermes.jpg',
      description: 'Tas elegan dengan desain simpel dan mudah dipadukan.',
      rating: 4.7,
    ),
    Product(
      id: '5',
      name: 'Basic grey T-Shirt',
      category: 'Pakaian',
      price: '99000',
      oldPrice: '129000',
      image: 'assets/images/kaos.jpg',
      description: 'Kaos basic berbahan lembut untuk gaya sehari-hari.',
      rating: 4.8,
    ),
    Product(
      id: '6',
      name: 'Classic Sunglasses',
      category: 'Aksesoris',
      price: '119000',
      oldPrice: '159000',
      image: 'assets/images/kacamata.jpg',
      description: 'Kacamata dengan desain klasik dan modern.',
      rating: 4.6,
    ),
    Product(
      id: '7',
      name: 'Classic Jacket',
      category: 'Pakaian',
      price: '299000',
      oldPrice: '369000',
      image: 'assets/images/jaket wanita.jpg',
      description: 'Jaket hangat untuk tampilan santai dan stylish.',
      rating: 4.8,
    ),
  ];
}

String rupiah(String value) {
  final number = int.tryParse(value) ?? 0;
  final text = number.toString();
  final result = StringBuffer();

  for (int i = 0; i < text.length; i++) {
    result.write(text[i]);

    final remaining = text.length - i - 1;
    if (remaining > 0 && remaining % 3 == 0) {
      result.write('.');
    }
  }

  return 'Rp$result';
}

class ProductCard extends StatelessWidget {
  final Product product;
  final bool favorite;
  final VoidCallback onFavorite;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.favorite,
    required this.onFavorite,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 0.85,
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Color(0xFFECE7E1),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: onFavorite,
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      color: favorite ? Colors.red : Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 1,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  rupiah(product.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B6F52),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 15),
                    const SizedBox(width: 3),
                    Text(
                      product.rating.toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: onAddToCart,
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xFF8B6F52),
                        child: Icon(
                          Icons.add,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Product> products;
  final bool Function(Product) isFavorite;
  final ValueChanged<Product> onFavorite;
  final ValueChanged<Product> onAddToCart;
  final VoidCallback onSeeAll;

  const HomePage({
    super.key,
    required this.products,
    required this.isFavorite,
    required this.onFavorite,
    required this.onAddToCart,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 25),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'STYLEUP',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      color: Color(0xFF8B6F52),
                    ),
                  ),
                  Text(
                    'Pilih Style Kesukaan Mu.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const CircleAvatar(
              backgroundColor: Color(0xFFEDE2D5),
              child: Icon(Icons.person_outline, color: Color(0xFF8B6F52)),
            ),
          ],
        ),

        const SizedBox(height: 22),

        // BANNER PROMO
        Container(
          height: 190,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFE9DED1),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=1000',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color(0x66000000),
                BlendMode.darken,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'NEW COLLECTION',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Discover Your\nPersonal Style',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: onSeeAll,
                child: const Text('Belanja Sekarang'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Kategori Pilihan',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 13),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _CategoryIcon(icon: Icons.checkroom, label: 'Pakaian'),
            _CategoryIcon(icon: Icons.directions_walk, label: 'Sepatu'),
            _CategoryIcon(icon: Icons.shopping_bag, label: 'Tas'),
            _CategoryIcon(icon: Icons.watch, label: 'Aksesori'),
          ],
        ),

        const SizedBox(height: 25),

        Row(
          children: [
            const Expanded(
              child: Text(
                'Produk Pilihan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: onSeeAll,
              child: const Text('Lihat semua'),
            ),
          ],
        ),

        const SizedBox(height: 8),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.57,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return ProductCard(
              product: product,
              favorite: isFavorite(product),
              onFavorite: () => onFavorite(product),
              onAddToCart: () => onAddToCart(product),
            );
          },
        ),
      ],
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CategoryIcon({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 27,
          backgroundColor: const Color(0xFFEDE2D5),
          child: Icon(icon, color: const Color(0xFF8B6F52)),
        ),
        const SizedBox(height: 7),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}