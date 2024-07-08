import 'package:flutter/material.dart';

class ArchiveSearchBar extends StatelessWidget {
  const ArchiveSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Please enter a keyword description image',
        prefixIcon: const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
