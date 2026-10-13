import 'package:flutter/material.dart';
import '../data/destinations.dart';
import '../models/destination.dart';

class BookingScreen extends StatefulWidget {
  final Destination? destination;

  const BookingScreen({
    super.key,
    this.destination,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _peopleController = TextEditingController(text: '2');

  late Destination _selectedDestination;
  DateTime? _departureDate;

  @override
  void initState() {
    super.initState();
    _selectedDestination = widget.destination ?? destinations.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _peopleController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _departureDate ?? now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (date != null) {
      setState(() {
        _departureDate = date;
      });
    }
  }

  void _submitBooking() {
    if (!_formKey.currentState!.validate()) return;

    if (_departureDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione a data da viagem.'),
        ),
      );
      return;
    }

    final people = int.parse(_peopleController.text);
    final total = _selectedDestination.price * people;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Solicitação registrada'),
          content: Text(
            'Olá, ${_nameController.text}!\n\n'
            'Destino: ${_selectedDestination.name}\n'
            'Data: ${_departureDate!.day.toString().padLeft(2, '0')}/'
            '${_departureDate!.month.toString().padLeft(2, '0')}/'
            '${_departureDate!.year}\n'
            'Viajantes: $people\n'
            'Valor estimado: R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}\n\n'
            'Esta é uma simulação acadêmica. Nenhuma reserva ou pagamento foi efetuado.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reservar viagem',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Planeje sua próxima aventura',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Preencha os dados para simular sua reserva.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 26),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome completo',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.trim().length < 3) {
                  return 'Informe seu nome completo.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value == null ||
                    !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(value.trim())) {
                  return 'Informe um e-mail válido.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Destination>(
              initialValue: _selectedDestination,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Destino',
                prefixIcon: Icon(Icons.place_outlined),
              ),
              items: destinations.map((destination) {
                return DropdownMenuItem(
                  value: destination,
                  child: Text(
                    destination.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (destination) {
                if (destination != null) {
                  setState(() {
                    _selectedDestination = destination;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _peopleController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número de viajantes',
                prefixIcon: Icon(Icons.groups_outlined),
              ),
              validator: (value) {
                final people = int.tryParse(value ?? '');
                if (people == null || people < 1 || people > 20) {
                  return 'Informe de 1 a 20 viajantes.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _selectDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                _departureDate == null
                    ? 'Selecionar data de partida'
                    : 'Partida: ${_departureDate!.day.toString().padLeft(2, '0')}/'
                        '${_departureDate!.month.toString().padLeft(2, '0')}/'
                        '${_departureDate!.year}',
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(18),
              ),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE7F4F4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Valor estimado por pessoa'),
                  const SizedBox(height: 6),
                  Text(
                    'R\$ ${_selectedDestination.price.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: const TextStyle(
                      color: Color(0xFF087F8C),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _submitBooking,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Solicitar reserva'),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'A reserva é apenas demonstrativa e não possui integração com pagamentos.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
