import 'package:flutter/material.dart';
import 'home_page.dart';

class FavoritPage extends StatelessWidget {
  final List<Product> products;
  final bool Function(Product) isFavorite;
  final ValueChanged<Product> onFavorite;
  final ValueChanged<Product> onAddToCart;

  const FavoritPage({
    super.key,
    required this.products,
    required this.isFavorite,
    required this.onFavorite,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Produk Favorit',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 7),
        const Text(
          'Kumpulan produk yang kamu sukai.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 22),

        if (products.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(35),
              child: Column(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 70,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Belum ada produk favorit.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tekan ikon hati pada produk untuk menyimpannya.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        else
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