import 'package:flutter/material.dart';

void main() {
  runApp(const NeoStoreApp());
}

class NeoStoreApp extends StatelessWidget {
  const NeoStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
        fontFamily: 'Roboto',
      ),
      home: const StoreMainScreen(),
    );
  }
}

class StoreMainScreen extends StatefulWidget {
  const StoreMainScreen({super.key});

  @override
  State<StoreMainScreen> createState() => _StoreMainScreenState();
}

class _StoreMainScreenState extends State<StoreMainScreen> {
  int balance = 1250;
  int cartCount = 0;

  // Список футуристичных товаров
  final List<Map<String, dynamic>> products = [
    {'name': 'NEO-Phone X', 'price': 850, 'icon': '📱', 'color': const Color(0xFFDEFF9A)},
    {'name': 'Cyber-Watch', 'price': 250, 'icon': '⌚', 'color': Colors.blueAccent},
    {'name': 'VR-Goggles', 'price': 500, 'icon': '🥽', 'color': Colors.purpleAccent},
    {'name': 'Aero-Pod Pro', 'price': 150, 'icon': '🎧', 'color': Colors.orangeAccent},
  ];

  void addToCart(Map<String, dynamic> product) {
    // Явно приводим цену к int, чтобы FlutLab не ругался
    final int productPrice = product['price'] as int;

    if (balance >= productPrice) {
      setState(() {
        balance -= productPrice;
        cartCount++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product['name']} добавлен в корзину! 🚀'), 
          backgroundColor: const Color(0xFFDEFF9A), 
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Недостаточно STARS! ❌'), 
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Верхняя панель: Название и Баланс звёзд
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'NEO-STORE', 
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDEFF9A).withOpacity(0.1), 
                      borderRadius: BorderRadius.circular(20), 
                      border: Border.all(color: const Color(0xFFDEFF9A)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFDEFF9A), size: 18),
                        const SizedBox(width: 5),
                        Text(
                          '$balance', 
                          style: const TextStyle(color: Color(0xFFDEFF9A), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Поле поиска (декоративное)
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05), 
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Text('Поиск гаджетов...', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Популярное', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              // Сетка товаров в стиле Bento Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];
                    final Color accentColor = p['color'] as Color;
                    return Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(p['icon'] as String, style: const TextStyle(fontSize: 50)),
                          const SizedBox(height: 10),
                          Text(
                            p['name'] as String, 
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${p['price']} STARS', 
                            style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              minimumSize: const Size(double.infinity, 35),
                            ),
                            onPressed: () => addToCart(p),
                            child: const Text('Купить', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // Плавающая кнопка корзины внизу экрана
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFDEFF9A),
        onPressed: () {},
        label: Text(
          'Корзина ($cartCount)', 
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
      ),
    );
  }
}
