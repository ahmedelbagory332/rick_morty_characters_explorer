import 'package:flutter/material.dart';

class TextEditSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onSearch;
  final void Function(String)? onChanged;

  const TextEditSearchBar({super.key, required this.controller, this.onSearch, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onSubmitted: onSearch,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Write name to search",
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
          ),
        ),
      ),
    );
  }
}