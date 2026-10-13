import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (!_formKey.currentState!.validate()) return;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Mensagem registrada'),
          content: const Text(
            'Sua mensagem foi validada nesta demonstração. Nenhum e-mail foi enviado.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _formKey.currentState!.reset();
                _nameController.clear();
                _emailController.clear();
                _messageController.clear();
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
          'Fale conosco',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF087F8C),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.support_agent,
                  size: 44,
                  color: Colors.white,
                ),
                SizedBox(height: 14),
                Text(
                  'Vamos planejar sua viagem?',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Envie suas dúvidas e conte o que você procura para sua próxima aventura.',
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Envie uma mensagem',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 3) {
                      return 'Informe seu nome.';
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
                TextFormField(
                  controller: _messageController,
                  minLines: 4,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Mensagem',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.message_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 10) {
                      return 'Escreva uma mensagem com pelo menos 10 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                    label: const Text('Enviar mensagem'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const ListTile(
            leading: Icon(
              Icons.email_outlined,
              color: Color(0xFF087F8C),
            ),
            title: Text('E-mail'),
            subtitle: Text('contato@exploremundo.com.br'),
          ),
          const ListTile(
            leading: Icon(
              Icons.access_time,
              color: Color(0xFF087F8C),
            ),
            title: Text('Atendimento'),
            subtitle: Text('Segunda a sexta, das 9h às 18h'),
          ),
        ],
      ),
    );
  }
}
