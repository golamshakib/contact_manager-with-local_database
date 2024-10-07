import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerWidget extends StatefulWidget {
  const CustomDatePickerWidget({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  @override
  State<CustomDatePickerWidget> createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  late DateTime _selectedDate;
  bool _includeYear = true; // Toggle for including the year

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  void _onYearToggleChanged(bool value) {
    setState(() {
      _includeYear = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                DateFormat.yMMMMd().format(_selectedDate),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Month Selector
                DropdownButton<int>(
                  value: _selectedDate.month,
                  items: List.generate(12, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text(
                        DateFormat.MMMM().format(DateTime(0, index + 1)),
                      ),
                    );
                  }),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedDate = DateTime(
                          _selectedDate.year,
                          value,
                          _selectedDate.day,
                        );
                      });
                    }
                  },
                ),
                // Day Selector
                DropdownButton<int>(
                  value: _selectedDate.day,
                  items: List.generate(
                    DateUtils.getDaysInMonth(
                      _selectedDate.year,
                      _selectedDate.month,
                    ),
                    (index) {
                      return DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      );
                    },
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedDate = DateTime(
                          _selectedDate.year,
                          _selectedDate.month,
                          value,
                        );
                      });
                    }
                  },
                ),
                // Year Selector (only if _includeYear is true)
                if (_includeYear)
                  DropdownButton<int>(
                    value: _selectedDate.year,
                    items: List.generate(100, (index) {
                      int year = DateTime.now().year - 50 + index;
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text('$year'),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedDate = DateTime(
                            value,
                            _selectedDate.month,
                            _selectedDate.day,
                          );
                        });
                      }
                    },
                  ),
              ],
            ),
            Divider(),
            // Include Year Switch
            SwitchListTile(
              title: Text('Include year'),
              value: _includeYear,
              onChanged: _onYearToggleChanged,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    widget.onDateSelected(_selectedDate);
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Method to trigger the custom date picker
void showCustomDatePicker(BuildContext context, DateTime initialDate,
    Function(DateTime) onDateSelected) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomDatePickerWidget(
        initialDate: initialDate,
        onDateSelected: onDateSelected,
      );
    },
  );
}
