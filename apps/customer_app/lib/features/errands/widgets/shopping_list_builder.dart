import 'package:flutter/material.dart';
import 'package:models/models.dart';

class ShoppingListBuilder extends StatefulWidget {
  final Function(List<ShoppingItem>) onChanged;
  final List<ShoppingItem> initialItems;

  const ShoppingListBuilder({
    super.key,
    required this.onChanged,
    this.initialItems = const [],
  });

  @override
  State<ShoppingListBuilder> createState() => _ShoppingListBuilderState();
}

class _ShoppingListBuilderState extends State<ShoppingListBuilder> {
  late List<ShoppingItem> _items;
  final _itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.initialItems);
  }

  void _addItem() {
    if (_itemController.text.isNotEmpty) {
      setState(() {
        _items.add(ShoppingItem(name: _itemController.text));
        _itemController.clear();
      });
      widget.onChanged(_items);
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    widget.onChanged(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Shopping List', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _itemController,
                decoration: const InputDecoration(
                  hintText: 'Add item (e.g. Milk, Bread)',
                  isDense: true,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.teal),
              onPressed: _addItem,
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_items[index].name),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                onPressed: () => _removeItem(index),
              ),
            );
          },
        ),
      ],
    );
  }
}
