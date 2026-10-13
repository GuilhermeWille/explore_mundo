import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sobre nós',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFF087F8C),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.travel_explore,
              color: Colors.white,
              size: 80,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Explore Mundo',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'A Explore Mundo é uma agência de viagens criada para '
            'ajudar pessoas a descobrir novos destinos e planejar '
            'experiências inesquecíveis.',
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 24),
          const ListTile(
            leading: Icon(
              Icons.public,
              color: Color(0xFF087F8C),
            ),
            title: Text('Nossa missão'),
            subtitle: Text(
              'Facilitar o planejamento de viagens e aproximar '
              'pessoas de lugares extraordinários.',
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.favorite_outline,
              color: Color(0xFF087F8C),
            ),
            title: Text('Nossa proposta'),
            subtitle: Text(
              'Apresentar destinos, informações e opções de pacotes '
              'em uma experiência simples e acessível.',
            ),
          ),
        ],
      ),
    );
  }
}
