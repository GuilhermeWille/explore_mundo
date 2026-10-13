import 'package:flutter/material.dart';
import '../data/destinations.dart';
import '../widgets/destination_card.dart';
import '../widgets/section_title.dart';
import 'destination_screen.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pacotes de viagem',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionTitle(
            title: 'Encontre seu pacote',
            subtitle: 'Opções para conhecer lugares extraordinários',
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF087F8C),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.flight_takeoff,
                  color: Colors.white,
                  size: 36,
                ),
                SizedBox(height: 12),
                Text(
                  'Sua próxima viagem está aqui!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Explore os pacotes disponíveis e escolha seu próximo destino.',
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          const SectionTitle(title: 'Todos os pacotes'),
          const SizedBox(height: 16),
          ...destinations.map(
            (destination) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DestinationCard(
                destination: destination,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DestinationScreen(
                        destination: destination,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
