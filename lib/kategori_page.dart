import 'package:flutter/material.dart';
import 'home_page.dart';

class KategoriPage extends StatefulWidget {
  final List<Product> products;
  final bool Function(Product) isFavorite;
  final ValueChanged<Product> onFavorite;
  final ValueChanged<Product> onAddToCart;

  const KategoriPage({
    super.key,
    required this.products,
    required this.isFavorite,
    required this.onFavorite,
    required this.onAddToCart,
  });

  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  String selectedCategory = 'Semua';
  String searchText = '';

  final List<String> categories = [
    'Semua',
    'Pakaian',
    'Sepatu',
    'Tas',
    'Aksesori',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = widget.products.where((product) {
      final matchCategory = selectedCategory == 'Semua' ||
          product.category == selectedCategory;

      final matchSearch =
          product.name.toLowerCase().contains(searchText.toLowerCase());

      return matchCategory && matchSearch;
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Jelajahi Produk',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 7),
        const Text(
          'Temukan item fashion favoritmu.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),

        TextField(
          decoration: InputDecoration(
            hintText: 'Cari produk fashion...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),

        const SizedBox(height: 18),

        const Text(
          'Kategori',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              final selected = selectedCategory == category;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  selectedColor: const Color(0xFFE9DED1),
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 18),

        Text(
          '${filteredProducts.length} produk ditemukan',
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 12),

        if (filteredProducts.isEmpty)
          const Padding(
            padding: EdgeInsets.all(30),
            child: Center(
              child: Text('Produk tidak ditemukan.'),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.57,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final product = filteredProducts[index];

              return ProductCard(
                product: product,
                favorite: widget.isFavorite(product),
                onFavorite: () => widget.onFavorite(product),
                onAddToCart: () => widget.onAddToCart(product),
              );
            },
          ),
      ],
    );
  }
}