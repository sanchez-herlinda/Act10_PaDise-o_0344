import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Georgia',
        scaffoldBackgroundColor: const Color(0xFFFAF9F6),
      ),
      home: const PizzaMenu(),
    );
  }
}

class Platillo {
  final String imageUrl;
  final String titulo;
  final String precio;

  const Platillo({required this.imageUrl, required this.titulo, required this.precio});
}

class PizzaMenu extends StatelessWidget {
  const PizzaMenu({super.key});

  // --- Catálogo Ampliado ---
  final List<Platillo> menuPrincipal = const [
    Platillo(imageUrl: 'https://png.pngtree.com/png-clipart/20241121/original/pngtree-italy-pizza-png-image_17278247.png', titulo: 'Margherita', precio: '\$12.00'),
    Platillo(imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500', titulo: 'Pepperoni', precio: '\$14.50'),
    Platillo(imageUrl: 'https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?w=500', titulo: 'Diavola', precio: '\$14.00'),
  ];

  final List<Platillo> especialidades = const [
    Platillo(imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=500', titulo: 'Salmone Grill', precio: '\$24.00'),
    Platillo(imageUrl: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=500', titulo: 'Lasagna Roma', precio: '\$19.00'),
    Platillo(imageUrl: 'https://images.unsplash.com/photo-1533622597524-a1215e26c0a2?w=500', titulo: 'Ossobuco', precio: '\$28.00'),
  ];

  final List<Platillo> bebidas = const [
    Platillo(imageUrl: 'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=500', titulo: 'Chianti', precio: '\$45.00'),
    Platillo(imageUrl: 'https://images.unsplash.com/photo-1547595628-c61a29f496f0?w=500', titulo: 'Aperol Spritz', precio: '\$12.00'),
    Platillo(imageUrl: 'https://images.unsplash.com/photo-1560512823-829485b8bf24?w=500', titulo: 'Limoncello', precio: '\$10.00'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Imagen
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://centrosantafe.com.mx/cdn/shop/articles/comida_italiana.jpg?v=1538518314'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Center(
                  child: Text('LA ROMA', 
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, letterSpacing: 10, color: Color(0xFF1B261A))
                  )
                ),
                
                // Secciones de la Carta
                _buildSection('Nuestros Clásicos', menuPrincipal, false),
                _buildSection('Especialidades Chef', especialidades, true),
                _buildSection('Bebidas y Cavas', bebidas, false),
                
                const SizedBox(height: 120), // Margen para la barra inferior
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Platillo> items, bool isSpecial) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 25, 30, 10),
          child: Text(title, 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isSpecial ? const Color(0xFF2D5A27) : Colors.black87)
          ),
        ),
        SizedBox(
          height: 190, // Altura ajustada para mantener proporción 1:1 de la imagen
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final p = items[index];
              return Container(
                width: 150, // Ancho fijo para cuadrícula horizontal
                margin: const EdgeInsets.only(right: 15, bottom: 5),
                decoration: BoxDecoration(
                  color: isSpecial ? const Color(0xFF1B261A) : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  children: [
                    // Imagen Cuadrada
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                      child: Image.network(p.imageUrl, height: 110, width: double.infinity, fit: BoxFit.cover),
                    ),
                    // Texto
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(p.titulo, 
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: 13, 
                                color: isSpecial ? Colors.white : Colors.black87
                              ),
                              textAlign: TextAlign.center, maxLines: 1),
                            const SizedBox(height: 2),
                            Text(p.precio, 
                              style: TextStyle(
                                fontSize: 13,
                                color: isSpecial ? const Color(0xFFF5F5DC) : const Color(0xFFBC412B), 
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Positioned(
      bottom: 25,
      left: 40,
      right: 40,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xFF1B261A),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: const Icon(Icons.home_filled, color: Colors.white, size: 26), onPressed: () {}),
            const VerticalDivider(color: Colors.white10, indent: 20, endIndent: 20, width: 1),
            IconButton(icon: const Icon(Icons.restaurant_menu, color: Colors.white70, size: 26), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}