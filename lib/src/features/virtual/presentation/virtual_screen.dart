import 'package:flutter/material.dart';

class VirtualScreen extends StatefulWidget {
  static const route = r'/virtual';

  const VirtualScreen({super.key});

  @override
  State<VirtualScreen> createState() => _VirtualScreenState();
}

class _VirtualScreenState extends State<VirtualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Virtual Screen'),),
      body: const Center(child: Text('Virtual Screen'),),
    );
  }
}
