import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:flutter/material.dart';

/// Creates a [BookitDropdownDatePicker] widget instance
///
/// Displays year, month and day [DropdownButton] widgets in a [Row]
// ignore: must_be_immutable
class BookitDropdownDatePicker extends StatefulWidget {
  /// Stores the date format how [DropdownButton] widgets should be build.
  final DateFormat dateFormat;

  /// Mimimum date value that [DropdownButton] widgets can have.
  final ValidDate firstDate;

  /// Maximum date value that [DropdownButton] widgets can have.
  final ValidDate lastDate;

  /// Text style of the dropdown button and it's menu items
  final TextStyle textStyle;

  /// The widget to use for drawing the drop-down button's underline.
  ///
  /// Defaults to a 2.0 height bottom container with Theme.of(context).primaryColor
  final Widget underLine;

  /// The background color of the dropdown.
  ///
  /// If it is not provided, the theme's [ThemeData.canvasColor] will be used instead.
  final Color dropdownColor;

  /// If true [DropdownMenuItem]s will be built in ascending order
  final bool ascending;

  /// Contains year, month and day DropdownButton's hint texts
  ///
  /// Default is: 'yyyy', 'mm', 'dd'
  final DateHint dateHint;

  Date _currentDate;

  /// Holds the currently selected date
  Date get currentDate => _currentDate;

  /// Returns currently selected day
  int get day {
    return _currentDate?.day;
  }

  /// Returns currently selected month
  int get month {
    return _currentDate?.month;
  }

  /// Returns currently selected year
  int get year {
    return _currentDate?.year;
  }

  /// Returns date as String by a [separator]
  /// based on [dateFormat]
  String getDate([String separator = '-']) {
    String date;
    var year = _currentDate?.year;
    var month = Date.toStringWithLeadingZeroIfLengthIsOne(_currentDate?.month);
    var day = Date.toStringWithLeadingZeroIfLengthIsOne(_currentDate?.day);

    switch (dateFormat) {
      case DateFormat.ymd:
        date = '$year$separator$month$separator$day';
        break;
      case DateFormat.dmy:
        date = '$day$separator$month$separator$year';
        break;
      case DateFormat.mdy:
        date = '$month$separator$day$separator$year';
        break;
    }
    return date;
  }

  /// Creates an instance of [BookitDropdownDatePicker].
  ///
  /// [firstDate] must be before [lastDate]
  /// and [initialDate] must be between their range
  ///
  /// [initialDate] is optional, if not provided a hintText
  /// will be shown in their [DropDownButton]'s
  ///
  /// By default [dateFormat] is [DateFormat.ymd].
  BookitDropdownDatePicker({
    @required this.firstDate,
    @required this.lastDate,
    Date initialDate = const NullableValidDate.nullDate(),
    this.dateFormat = DateFormat.ymd,
    this.dateHint = const DateHint(),
    this.dropdownColor,
    this.textStyle,
    this.underLine,
    this.ascending = true,
    final Key key,
  })  : assert(firstDate < lastDate, 'First date must be before last date.'),
        assert(_isValidInitialDate(initialDate, firstDate, lastDate),
            'Initial date must be null or between first and last date.'),
        _currentDate = initialDate,
        super(key: key);

  static bool _isValidInitialDate(Date date, Date firstDate, Date lastDate) {
    if (date?.year == null) return true;
    if (date.year < firstDate.year) return false;
    if (date.year > lastDate.year) return false;
    if (date?.month == null) return true;
    if (date.month < firstDate.month) return false;
    if (date.month > lastDate.month) return false;
    if (date?.day == null) return true;
    if (date.day < firstDate.day) return false;
    if (date.day > lastDate.day) return false;

    return true;
  }

  @override
  _BookitDropdownDatePickerState createState() => _BookitDropdownDatePickerState();
}

class _BookitDropdownDatePickerState extends State<BookitDropdownDatePicker> {
  List<DropdownMenuItem<int>> _buildDropdownMenuItemList(int min, int max) {
    return _intGenerator(min, max, widget.ascending)
        .map(
          (i) => DropdownMenuItem<int>(
            value: i,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                Date.toStringWithLeadingZeroIfLengthIsOne(i),
                textAlign: TextAlign.start,
                style: widget.textStyle,
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildDropdownButton({
    @required final int initialValue,
    @required final String hint,
    @required final Function onChanged,
    @required final List<DropdownMenuItem<int>> items,
  }) {
    return Expanded(
      child: DropdownButton<int>(
        dropdownColor: widget.dropdownColor,
        icon: Icon(Icons.keyboard_arrow_down,
          color: Colors.black12,),
        underline: widget.underLine ??
            Container(
              color: Colors.black12,
              // color: Theme.of(context).primaryColor,
              height: 0.8,
              margin: EdgeInsets.only(right: 8),
            ),

        value: initialValue,

        hint: Container(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:40.0),
                child: Text(
                  hint,
                  textAlign: TextAlign.center,// dd, mm, yyyy
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 16.5,
                      wordSpacing: 0.1
                  ),
                ),
              ),
            ],
          ),
        ),
        onChanged: (val) => Function.apply(onChanged, [val]),
        items: items,
      ),
    );
  }

  Iterable<int> _intGenerator(int start, int end, bool ascending) sync* {
    if (ascending) {
      for (var i = start; i <= end; i++) {
        yield i;
      }
    } else {
      for (var i = end; i >= start; i--) {
        yield i;
      }
    }
  }

  Widget _buildYearDropdownButton() {
    return _buildDropdownButton(
      items: _buildDropdownMenuItemList(
        widget.firstDate.year,
        widget.lastDate.year,
      ),
      initialValue: widget._currentDate?.year,
      hint: widget.dateHint.year,
      onChanged: (final year) => setState(
          () => widget._currentDate = widget._currentDate.copyWith(year: year)),
    );
  }

  Widget _buildMonthDropdownButton() {
    var minMonth = 1;
    var maxMonth = 12;

    if (widget._currentDate?.year != null) {
      if (widget.firstDate.year == widget._currentDate?.year) {
        minMonth = widget.firstDate.month;
        if (widget._currentDate?.month != null &&
            widget._currentDate.month < widget.firstDate.month) {
          widget._currentDate = widget._currentDate.copyWith(month: minMonth);
        }
      }
      if (widget.lastDate.year == widget._currentDate?.year) {
        maxMonth = widget.lastDate.month;
        if (widget._currentDate?.month != null &&
            widget._currentDate.month > widget.lastDate.month) {
          widget._currentDate = widget._currentDate.copyWith(month: maxMonth);
        }
      }
    } else {
      widget._currentDate =
          widget._currentDate.copyWith(month: widget._currentDate?.month);
    }
    return _buildDropdownButton(
      items: _buildDropdownMenuItemList(
        minMonth,
        maxMonth,
      ),
      initialValue: widget._currentDate?.month,
      hint: widget.dateHint.month,
      onChanged: (final month) => setState(() =>
          widget._currentDate = widget._currentDate.copyWith(month: month)),
    );
  }

  Widget _buildDayDropdownButton() {
    var minDay = 1;
    var maxDay = DateUtil.daysInDate(
      month: widget._currentDate?.month,
      year: widget._currentDate?.year,
    );

    if (widget._currentDate?.month != null) {
      if (widget._currentDate?.year != null) {
        if (widget.firstDate.year == widget._currentDate?.year &&
            widget.firstDate.month >= widget._currentDate?.month) {
          minDay = widget.firstDate.day;
          if (widget._currentDate.day != null &&
              widget.firstDate.day >= widget._currentDate?.day) {
            widget._currentDate = widget._currentDate.copyWith(day: minDay);
          }
        }
        if (widget.lastDate.year == widget._currentDate?.year &&
            widget.lastDate.month <= widget._currentDate?.month) {
          maxDay = widget.lastDate.day;
          if (widget._currentDate.day != null &&
              widget.lastDate.day <= widget._currentDate?.day) {
            widget._currentDate = widget._currentDate.copyWith(day: maxDay);
          }
        }
      }
    }

    return _buildDropdownButton(
      items: _buildDropdownMenuItemList(minDay, maxDay),
      initialValue: widget._currentDate?.day,
      hint: widget.dateHint.day,
      onChanged: (final day) => setState(
          () => widget._currentDate = widget._currentDate.copyWith(day: day)),
    );
  }

  List<Widget> _buildDropdownButtonsByDateFormat() {
    final dropdownButtonList = <Widget>[];

    switch (widget.dateFormat) {
      case DateFormat.dmy:
        dropdownButtonList
          ..add(_buildDayDropdownButton())
          ..add(_buildMonthDropdownButton())
          ..add(_buildYearDropdownButton());
        break;
      case DateFormat.ymd:
        dropdownButtonList
          ..add(_buildYearDropdownButton())
          ..add(_buildMonthDropdownButton())
          ..add(_buildDayDropdownButton());
        break;
      case DateFormat.mdy:
        dropdownButtonList
          ..add(_buildMonthDropdownButton())
          ..add(_buildDayDropdownButton())
          ..add(_buildYearDropdownButton());
        break;
    }
    return dropdownButtonList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _buildDropdownButtonsByDateFormat(),
    );
  }
}
