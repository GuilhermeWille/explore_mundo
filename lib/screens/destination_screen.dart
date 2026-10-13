import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../models/destination.dart';
import 'booking_screen.dart';

class DestinationScreen extends StatelessWidget {
  final Destination destination;

  const DestinationScreen({
    super.key,
    required this.destination,
  });

  Future<void> _callAgency(BuildContext context) async {
    final uri = Uri(
      scheme: 'tel',
      path: '+5541999999999',
    );

    if (!await launchUrl(uri)) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível abrir o aplicativo de telefone.'),
        ),
      );
    }
  }

  Future<void> _openRoute(BuildContext context) async {
    final query = Uri.encodeComponent(destination.location);
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível abrir o mapa.'),
        ),
      );
    }
  }

  Future<void> _shareDestination() async {
    await SharePlus.instance.share(
      ShareParams(
        text: 'Conheça ${destination.name}, em ${destination.location}!\n\n'
            '${destination.description}\n\n'
            'Pacote a partir de R\$ '
            '${destination.price.toStringAsFixed(2).replaceAll('.', ',')}.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.name),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Image.network(
            destination.imageUrl,
            height: 260,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 260,
                color: Colors.blueGrey.shade100,
                child: const Icon(Icons.landscape, size: 60),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF087F8C),
                    ),
                    const SizedBox(width: 5),
                    Expanded(child: Text(destination.location)),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFA000),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${destination.rating} (${destination.reviewCount} avaliações)',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Sobre o destino',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  destination.description,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _InfoTile(
                        icon: Icons.calendar_month,
                        label: 'Duração',
                        value: '${destination.days} dias',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoTile(
                        icon: Icons.star_outline,
                        label: 'Avaliação',
                        value: '${destination.rating}/5',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _callAgency(context),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.call_outlined),
                            SizedBox(height: 4),
                            Text('CALL'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _openRoute(context),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.directions_outlined),
                            SizedBox(height: 4),
                            Text('ROUTE'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _shareDestination,
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.share_outlined),
                            SizedBox(height: 4),
                            Text('SHARE'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                const Text(
                  'Pacote por pessoa',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'R\$ ${destination.price.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF087F8C),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingScreen(
                            destination: destination,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Reservar viagem'),
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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F4F4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF087F8C)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
