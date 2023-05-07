import 'package:flutter/material.dart';

import '../../core/env/env.dart';
import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showLoader();
          Future.delayed(const Duration(seconds: 3), () {
            hideLoader();

            showSuccess('Sucesso');
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: Text(
          context.screenWidth.toString(),
        ),
      ),
    );
  }
}
