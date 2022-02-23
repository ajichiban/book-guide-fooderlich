import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fooderlich/models/fooderlich_pages.dart';
import 'package:fooderlich/models/grocery_item.dart';
import 'package:fooderlich/widgets/grocery_tile.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemScreen extends StatefulWidget {

  static MaterialPage page({
    GroceryItem? item,
    int? index,
    Function(GroceryItem)? onCreate,
    Function(GroceryItem)? onUpdate,
  }){
    return MaterialPage(
      name: FooderlichPages.groceryItemDetails,
      key: ValueKey(FooderlichPages.groceryItemDetails),
      child: GroceryItemScreen(
        orinalItem: item,
        onCreate: onCreate,
        onUpdate: onUpdate,
      )
    );
  }

  final Function(GroceryItem)? onCreate;
  final Function(GroceryItem)? onUpdate;

  final GroceryItem? orinalItem;

  final bool isUpdating;

  const GroceryItemScreen(
      {Key? key, this.onCreate, this.onUpdate, this.orinalItem})
      : isUpdating = (orinalItem != null),
        super(key: key);

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    if (widget.orinalItem != null) {
      _nameController.text = widget.orinalItem!.name;
      _name = widget.orinalItem!.name;
      _currentSliderValue = widget.orinalItem!.quantity;
      _importance = widget.orinalItem!.importance;
      _currentColor = widget.orinalItem!.color;

      final date = widget.orinalItem!.date;
      _timeOfDay = TimeOfDay(
        hour: date.hour,
        minute: date.minute,
      );

      _dueDate = date;
    }

    _nameController.addListener(() {
      setState(() => _name = _nameController.text);
    });

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final groceyItem = GroceryItem(
                  id: widget.orinalItem?.id ?? const Uuid().v1(),
                  name: _name,
                  importance: _importance,
                  color: _currentColor,
                  quantity: _currentSliderValue,
                  date: DateTime(
                    _dueDate.year,
                    _dueDate.month,
                    _dueDate.day,
                    _timeOfDay.hour,
                    _timeOfDay.minute,
                  ));
              if(widget.isUpdating){
                widget.onUpdate!(groceyItem);
              }else{
                widget.onCreate!(groceyItem);
              }
            },
          )
        ],
        // 3
        elevation: 0.0,
        // 4
        title: const Text(
          'Grocery Item',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      // 5
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            buildColorPicker(context),
            buidQuantityField(),
            GroceryTile(
              item: GroceryItem(
                  name: _name,
                  importance: _importance,
                  color: _currentColor,
                  quantity: _currentSliderValue,
                  date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                      _dueDate.hour, _dueDate.minute)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Item Name', style: TextStyle(fontSize: 28.0)),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
              hintText: 'E.g. Apples, Banana, 1 Bag of salt',
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _currentColor)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: _currentColor))),
        )
      ],
    );
  }

  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Importance', style: TextStyle(fontSize: 28.0)),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.low,
              label: const Text('low', style: TextStyle(color: Colors.white)),
              onSelected: (selected) {
                setState(() => _importance = Importance.low);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.medium,
              label:
                  const Text('medium', style: TextStyle(color: Colors.white)),
              onSelected: (selected) {
                _importance = Importance.medium;
                setState(() {});
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.high,
              label: const Text('high', style: TextStyle(color: Colors.white)),
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.high;
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Date', style: TextStyle(fontSize: 28.8)),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final currentDate = DateTime.now();

                final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: currentDate,
                    lastDate: DateTime(currentDate.year + 5));

                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            )
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Time of Day', style: TextStyle(fontSize: 28.0)),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());

                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
            )
          ],
        ),
        Text(_timeOfDay.format(context)),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(height: 50.0, width: 10.0, color: _currentColor),
            const SizedBox(
              width: 8.0,
            ),
            const Text('Color', style: TextStyle(fontSize: 28.0))
          ],
        ),
        TextButton(
          child: const Text('Select'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (color) {
                      setState(() => _currentColor = color);
                    },
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Save'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }

  Widget buidQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text('Quatity', style: TextStyle(fontSize: 28.0)),
            const SizedBox(
              width: 16.0,
            ),
            Text(_currentSliderValue.toInt().toString(),
                style: const TextStyle(fontSize: 28.0))
          ],
        ),
        Slider(
            inactiveColor: _currentColor.withOpacity(0.5),
            activeColor: _currentColor,
            value: _currentSliderValue.toDouble(),
            min: 0.0,
            max: 100.0,
            label: _currentSliderValue.toInt().toString(),
            onChanged: (double value) =>
                setState(() => _currentSliderValue = value.toInt()))
      ],
    );
  }
}
