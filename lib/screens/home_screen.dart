import 'package:flutter/material.dart';
import '../data/destinations.dart';
import '../models/destination.dart';
import '../widgets/destination_banner.dart';
import '../widgets/destination_card.dart';
import '../widgets/section_title.dart';
import 'destination_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  List<Destination> get _filteredDestinations {
    return destinations.where((destination) {
      final query = _query.toLowerCase();
      return destination.name.toLowerCase().contains(query) ||
          destination.location.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openDestination(Destination destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DestinationScreen(destination: destination),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredDestinations;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.travel_explore,
              color: Color(0xFF087F8C),
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Explore Mundo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _query = '';
              });
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Limpar pesquisa',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text(
            'Sua próxima aventura começa aqui.',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Descubra lugares incríveis pelo Brasil.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 22),
          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Para onde você quer viajar?',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 26),
          if (_query.isEmpty) ...[
            DestinationBanner(
              destination: destinations[1],
              onTap: () => _openDestination(destinations[1]),
            ),
            const SizedBox(height: 28),
          ],
          SectionTitle(
            title: _query.isEmpty
                ? 'Destinos populares'
                : 'Resultados da pesquisa',
            subtitle: '${filtered.length} destinos encontrados',
          ),
          const SizedBox(height: 16),
          if (filtered.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(Icons.search_off, size: 48),
                  SizedBox(height: 12),
                  Text('Nenhum destino encontrado.'),
                ],
              ),
            )
          else
            ...filtered.map(
              (destination) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DestinationCard(
                  destination: destination,
                  onTap: () => _openDestination(destination),
                ),
              ),
            ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F4F4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.support_agent,
                  color: Color(0xFF087F8C),
                  size: 34,
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Precisa de ajuda?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Consulte nossa equipe para planejar sua viagem.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
