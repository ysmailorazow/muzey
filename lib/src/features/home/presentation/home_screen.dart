import 'package:flutter/material.dart';

import '../../../widgets/custom_search_input_widget.dart';

class HomeScreen extends StatefulWidget {
  static const route = r'/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen'),),
      body: const Center(child: Text('Home Screen'),),

    );
  }
}

