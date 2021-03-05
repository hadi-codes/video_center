import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateTimePicker extends StatefulWidget {
  DateTimePicker({Key key, this.onChanged, this.isInvalid}) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
  final ValueChanged<String> onChanged;
  final bool isInvalid;
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime _selectedDate =
      DateTime.now().add(const Duration(hours: 1, minutes: 5));
  String _date;

  TimeOfDay _timeOfDay;
  String _time;

  @override
  void initState() {
    _timeOfDay =
        TimeOfDay(hour: _selectedDate.hour, minute: _selectedDate.minute);
    widget.onChanged(_selectedDate.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _date = _selectedDate.toLocal().toString().split(' ')[0];
    _time = _timeOfDay.format(context).toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0.r),
              color: Colors.grey.shade100,
            ),
            child: InkWell(
              onTap: () => _selectDate(context),
              borderRadius: BorderRadius.circular(10.0.r),
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_date),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.calendar_today),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ),
        widget.isInvalid
            ? const Icon(
                Icons.error,
                color: Colors.red,
              )
            : Container(),
        Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0.r),
              color: Colors.grey.shade100,
            ),
            child: InkWell(
              onTap: () => _selecTime(context),
              borderRadius: BorderRadius.circular(10.0.r),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(_time),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(Icons.alarm),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  // combine DateTime and TimeOfDay and return it in One DateTime
  String _convertToDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute)
        .toString();
  }

  Future _selecTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    ));
    if (picked != null && picked != _timeOfDay)
      setState(() {
        _timeOfDay = picked;
        _time = _timeOfDay.format(context).toString();
        widget.onChanged(_convertToDateTime(_selectedDate, _timeOfDay));
      });
  }

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2031));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _date = _selectedDate.toLocal().toString().split(' ')[0];
        widget.onChanged(_convertToDateTime(_selectedDate, _timeOfDay));
      });
  }
}
