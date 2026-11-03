
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'kategori_page.dart';
import 'favorit_page.dart';
import 'keranjang_page.dart';
import 'profil_page.dart';

void main() {
  runApp(const StyleUpApp());
}

class StyleUpApp extends StatelessWidget {
  const StyleUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StyleUp',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF8F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B6F52),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFAF8F5),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Product> products = Product.sampleProducts;

  final List<Product> favorites = [];
  final Map<Product, int> cart = {};

  // Menyimpan pesanan yang berhasil checkout
  final List<Map<String, String>> orders = [];

  void toggleFavorite(Product product) {
    setState(() {
      if (favorites.contains(product)) {
        favorites.remove(product);
      } else {
        favorites.add(product);
      }
    });
  }

  bool isFavorite(Product product) {
    return favorites.contains(product);
  }

  void addToCart(Product product) {
    setState(() {
      cart[product] = (cart[product] ?? 0) + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ditambahkan ke keranjang.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void increaseQuantity(Product product) {
    setState(() {
      cart[product] = (cart[product] ?? 0) + 1;
    });
  }

  void decreaseQuantity(Product product) {
    setState(() {
      final quantity = cart[product] ?? 0;

      if (quantity <= 1) {
        cart.remove(product);
      } else {
        cart[product] = quantity - 1;
      }
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      cart.remove(product);
    });
  }

  // Proses checkout dan menyimpan pesanan
  void checkout() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang masih kosong.'),
        ),
      );
      return;
    }

    setState(() {
      for (final entry in cart.entries) {
        orders.add({
          'nama': entry.key.name,
          'harga': 'Jumlah: ${entry.value} item',
          'status': 'Dikemas',
          'kode': 'ORD${(orders.length + 1).toString().padLeft(3, '0')}',
        });
      }

      // Kosongkan keranjang setelah checkout
      cart.clear();

      // Kembali ke halaman beranda
      selectedIndex = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Pesanan berhasil dibuat! Cek Pesanan Saya.',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        products: products,
        isFavorite: isFavorite,
        onFavorite: toggleFavorite,
        onAddToCart: addToCart,
        onSeeAll: () {
          setState(() => selectedIndex = 1);
        },
      ),

      KategoriPage(
        products: products,
        isFavorite: isFavorite,
        onFavorite: toggleFavorite,
        onAddToCart: addToCart,
      ),

      FavoritPage(
        products: favorites,
        isFavorite: isFavorite,
        onFavorite: toggleFavorite,
        onAddToCart: addToCart,
      ),

      KeranjangPage(
        cart: cart,
        onIncrease: increaseQuantity,
        onDecrease: decreaseQuantity,
        onRemove: removeFromCart,
        onCheckout: checkout,
      ),

      // Mengirim data pesanan ke halaman Profil
      ProfilePage(
        orders: orders,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
      ),

      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: selectedIndex,
        indicatorColor: const Color(0xFFEDE2D5),
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),

          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Kategori',
          ),

          const NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorit',
          ),

          NavigationDestination(
            icon: const Icon(Icons.shopping_bag_outlined),
            selectedIcon: const Icon(Icons.shopping_bag),
            label: cart.isEmpty
                ? 'Keranjang'
                : 'Keranjang (${cart.length})',
          ),

          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
