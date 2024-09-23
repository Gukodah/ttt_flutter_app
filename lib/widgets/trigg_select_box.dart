import 'package:flutter/material.dart';

class SelectBoxItem<IdType> {
  final IdType? id;
  final String? value;

  SelectBoxItem({this.id, this.value});
}

class TriggSelectBox extends StatefulWidget {
  final List<SelectBoxItem> itemCollection;
  final int? defaultSelectedItemId;
  final Function? onChangeItem;

  const TriggSelectBox(
      {Key? key,
      required this.itemCollection,
      this.onChangeItem,
      this.defaultSelectedItemId})
      : super(key: key);

  @override
  _TriggSelectBoxState createState() => _TriggSelectBoxState();
}

class _TriggSelectBoxState extends State<TriggSelectBox> {
  List<DropdownMenuItem<SelectBoxItem>>? dropdownMenuItems;
  SelectBoxItem? selectedItem;

  @override
  void initState() {
    dropdownMenuItems = buildDropdownMenuItems(widget.itemCollection);
    if (widget.defaultSelectedItemId != null) {
      selectedItem = widget.itemCollection[widget.defaultSelectedItemId!];
    }
    super.initState();
  }

  List<DropdownMenuItem<SelectBoxItem>> buildDropdownMenuItems(
      List selectBoxItems) {
    List<DropdownMenuItem<SelectBoxItem>> items = [];
    for (SelectBoxItem element in widget.itemCollection) {
      items.add(
        DropdownMenuItem(
          value: element,
          child: Text(element.value!),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(SelectBoxItem? item) {
    if (widget.onChangeItem != null) {
      widget.onChangeItem!(
        item,
      );
    }
    setState(() {
      selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: dropdownMenuItems,
      value: selectedItem,
      onChanged: onChangeDropdownItem,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1),
        ),
        label: Column(
          children: [
            Text(
              'Estado cívil',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
