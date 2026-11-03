import 'package:flutter/material.dart';
import 'home_page.dart';

class KeranjangPage extends StatelessWidget {
  final Map<Product, int> cart;
  final ValueChanged<Product> onIncrease;
  final ValueChanged<Product> onDecrease;
  final ValueChanged<Product> onRemove;
  final VoidCallback onCheckout;

  const KeranjangPage({
    super.key,
    required this.cart,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    int total = 0;

    for (final entry in cart.entries) {
      final price = int.tryParse(entry.key.price) ?? 0;
      total += price * entry.value;
    }

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Keranjang Belanja',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 7),
        const Text(
          'Periksa kembali produk pilihanmu.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 22),

        if (cart.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(35),
              child: Column(
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 75,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Keranjang masih kosong.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Yuk, pilih produk fashion favoritmu!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        else ...[
          ...cart.entries.map((entry) {
            final product = entry.key;
            final quantity = entry.value;

            return Card(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 13),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.image,
                        width: 85,
                        height: 105,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 85,
                            height: 105,
                            color: const Color(0xFFEDE2D5),
                            child: const Icon(Icons.image),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            rupiah(product.price),
                            style: const TextStyle(
                              color: Color(0xFF8B6F52),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 9),
                          Row(
                            children: [
                              _quantityButton(
                                icon: Icons.remove,
                                onTap: () => onDecrease(product),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _quantityButton(
                                icon: Icons.add,
                                onTap: () => onIncrease(product),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => onRemove(product),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 12),

          Card(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(child: Text('Subtotal')),
                      Text('Dihitung otomatis'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Total Belanja',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        rupiah(total.toString()),
                        style: const TextStyle(
                          fontSize: 19,
                          color: Color(0xFF8B6F52),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF8B6F52),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: onCheckout,
                      child: const Text('Checkout Sekarang'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}