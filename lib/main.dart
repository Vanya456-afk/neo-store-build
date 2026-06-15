import 'package:flutter/material.dart';

void main() {
  runApp(const NeoTelegramStore());
}

class NeoTelegramStore extends StatelessWidget {
  const NeoTelegramStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neo Store TG',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF17212B), // Темная тема ТГ
        primaryColor: const Color(0xFF242F3D), // Цвет плашек ТГ
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F8CCF), // Фирменный синий ТГ
          brightness: Brightness.dark,
        ),
      ),
      home: const MainStoreScreen(),
    );
  }
}

class MainStoreScreen extends StatelessWidget {
  const MainStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Список наших неоновых товаров (как каналы в ТГ)
    final List<Map<String, String>> products = [
      {
        'title': '⚡ Смартфон Neo Phone X',
        'desc': 'Супер-амолед экран, неоновая подсветка корпуса...',
        'price': '990 \$',
        'time': '12:40'
      },
      {
        'title': '🎧 Наушники Cyber Pods',
        'desc': 'Идеальный звук, активное шумоподавление и басс...',
        'price': '150 \$',
        'time': '11:15'
      },
      {
        'title': '⌚ Смарт-часы Neon Watch',
        'desc': 'Пульс, шаги, уведомления из ТГ и лазерный дизайн...',
        'price': '220 \$',
        'time': 'Вчера'
      },
      {
        'title': '💻 Ноутбук Matrix Book',
        'desc': 'Мощный процессор для программирования ботов...',
        'price': '1499 \$',
        'time': 'Вчера'
      },
    ];

    return Scaffold(
      // Шапка в стиле Telegram
      appBar: AppBar(
        backgroundColor: const Color(0xFF242F3D),
        elevation: 1,
        title: const Text(
          'Neo Store',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),

      // Боковое меню (как в ТГ при свайпе слева)
      drawer: Drawer(
        backgroundColor: const Color(0xFF17212B),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF242F3D)),
              accountName: Text('Админ Магазина', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('@neo_store_admin'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xFF2F8CCF),
                child: Text('NS', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag, color: Color(0xFF2F8CCF)),
              title: const Text('Мои заказы'),
              onPressed: () {},
            ),
            ListTile(
              leading: const Icon(Icons.discount, color: Colors.orange),
              title: const Text('Промокоды'),
              onPressed: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.grey),
              title: const Text('Настройки'),
              onPressed: () {},
            ),
          ],
        ),
      ),

      // Список товаров в стиле списка чатов
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(
          color: Color(0xFF10171D),
          height: 1,
        ),
        itemBuilder: (context, index) {
          final item = products[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFF242F3D),
              child: const Icon(Icons.layers, color: Color(0xFF2F8CCF)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                Text(
                  item['time']!,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item['desc']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F8CCF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item['price']!,
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              // Логика при клике на товар
            },
          );
        },
      ),

      // Круглая кнопка корзины (как синий карандашик в ТГ)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2F8CCF),
        child: const Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () {
          // Открытие корзины
        },
      ),
    );
  }
}
