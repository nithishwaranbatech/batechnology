import 'package:flutter/material.dart';

class LoopSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateLoopScreen(),
    );
  }
}

class CreateLoopScreen extends StatefulWidget {
  @override
  _CreateLoopScreenState createState() => _CreateLoopScreenState();
}

class _CreateLoopScreenState extends State<CreateLoopScreen> {
  bool _isLoopActive = false;
  bool allDaysSelected = false;
  bool mondaySelected = false;
  bool tuesdaySelected = false;
  bool wednesdaySelected = false;
  bool thursdaySelected = false;
  bool fridaySelected = false;
  bool saturdaySelected = false;
  bool sundaySelected = false;

  TimeOfDay? allDaysStartTime, allDaysEndTime;
  TimeOfDay? mondayStartTime, mondayEndTime;
  TimeOfDay? tuesdayStartTime, tuesdayEndTime;
  TimeOfDay? wednesdayStartTime, wednesdayEndTime;
  TimeOfDay? thursdayStartTime, thursdayEndTime;
  TimeOfDay? fridayStartTime, fridayEndTime;
  TimeOfDay? saturdayStartTime, saturdayEndTime;
  TimeOfDay? sundayStartTime, sundayEndTime;

  // Function to handle selection of 'All Days'
  void _onAllDaysChanged(bool? value) {
    setState(() {
      allDaysSelected = value ?? false;
      if (value == true) {
        // If "All Days" is selected, select all individual days and set the same time
        allDaysSelected = true;
        mondaySelected = true;
        tuesdaySelected = true;
        wednesdaySelected = true;
        thursdaySelected = true;
        fridaySelected = true;
        saturdaySelected = true;
        sundaySelected = true;

        // Propagate the times to all days if Monday has a set time
        if (mondayStartTime != null && mondayEndTime != null) {
          allDaysStartTime = mondayStartTime;
          allDaysEndTime = mondayEndTime;

          tuesdayStartTime = mondayStartTime;
          tuesdayEndTime = mondayEndTime;
          wednesdayStartTime = mondayStartTime;
          wednesdayEndTime = mondayEndTime;
          thursdayStartTime = mondayStartTime;
          thursdayEndTime = mondayEndTime;
          fridayStartTime = mondayStartTime;
          fridayEndTime = mondayEndTime;
          saturdayStartTime = mondayStartTime;
          saturdayEndTime = mondayEndTime;
          sundayStartTime = mondayStartTime;
          sundayEndTime = mondayEndTime;
        }
      } else {
        // Deselect all days and reset their time
        allDaysSelected = false;
        mondaySelected = false;
        tuesdaySelected = false;
        wednesdaySelected = false;
        thursdaySelected = false;
        fridaySelected = false;
        saturdaySelected = false;
        sundaySelected = false;

        allDaysStartTime = allDaysEndTime = null;
        mondayStartTime = mondayEndTime = null;
        tuesdayStartTime = tuesdayEndTime = null;
        wednesdayStartTime = wednesdayEndTime = null;
        thursdayStartTime = thursdayEndTime = null;
        fridayStartTime = fridayEndTime = null;
        saturdayStartTime = saturdayEndTime = null;
        sundayStartTime = sundayEndTime = null;
      }
    });
  }

  // Function to handle selection of individual days
  void _onDayChanged(bool? value, String day) {
    setState(() {
      if (day == 'All Days') {
        allDaysSelected = false;
      }

      switch (day) {
        case 'All Days':
          allDaysSelected = value ?? false;
          break;
        case 'Monday':
          mondaySelected = value ?? false;
          break;
        case 'Tuesday':
          tuesdaySelected = value ?? false;
          break;
        case 'Wednesday':
          wednesdaySelected = value ?? false;
          break;
        case 'Thursday':
          thursdaySelected = value ?? false;
          break;
        case 'Friday':
          fridaySelected = value ?? false;
          break;
        case 'Saturday':
          saturdaySelected = value ?? false;
          break;
        case 'Sunday':
          sundaySelected = value ?? false;
          break;
      }
    });
  }

  Future<void> _pickTime(BuildContext context, bool isStartTime, String day) async {
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          switch (day) {
            case 'Monday':
              mondayStartTime = pickedTime;
              break;
            case 'Tuesday':
              tuesdayStartTime = pickedTime;
              break;
            case 'Wednesday':
              wednesdayStartTime = pickedTime;
              break;
            case 'Thursday':
              thursdayStartTime = pickedTime;
              break;
            case 'Friday':
              fridayStartTime = pickedTime;
              break;
            case 'Saturday':
              saturdayStartTime = pickedTime;
              break;
            case 'Sunday':
              sundayStartTime = pickedTime;
              break;
          }
        } else {
          switch (day) {
            case 'Monday':
              mondayEndTime = pickedTime;
              break;
            case 'Tuesday':
              tuesdayEndTime = pickedTime;
              break;
            case 'Wednesday':
              wednesdayEndTime = pickedTime;
              break;
            case 'Thursday':
              thursdayEndTime = pickedTime;
              break;
            case 'Friday':
              fridayEndTime = pickedTime;
              break;
            case 'Saturday':
              saturdayEndTime = pickedTime;
              break;
            case 'Sunday':
              sundayEndTime = pickedTime;
              break;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loop Setting'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Activate / Deactivate Loop',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Switch(
                value: _isLoopActive,
                onChanged: (bool value) {
                  setState(() {
                    _isLoopActive = value;
                  });
                },
                activeColor: Colors.green,
                inactiveThumbColor: Colors.grey,
              ),
              SizedBox(height: 16),
              _buildDayWithCheckbox('All Days', allDaysSelected, (value) => _onAllDaysChanged(value)),

              Align(
                alignment: Alignment.center,
                child: Text('(or)', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ),
              _buildDayWithCheckbox('Monday', mondaySelected, (value) => _onDayChanged(value, 'Monday')),
              _buildDayWithCheckbox('Tuesday', tuesdaySelected, (value) => _onDayChanged(value, 'Tuesday')),
              _buildDayWithCheckbox('Wednesday', wednesdaySelected, (value) => _onDayChanged(value, 'Wednesday')),
              _buildDayWithCheckbox('Thursday', thursdaySelected, (value) => _onDayChanged(value, 'Thursday')),
              _buildDayWithCheckbox('Friday', fridaySelected, (value) => _onDayChanged(value, 'Friday')),
              _buildDayWithCheckbox('Saturday', saturdaySelected, (value) => _onDayChanged(value, 'Saturday')),
              _buildDayWithCheckbox('Sunday', sundaySelected, (value) => _onDayChanged(value, 'Sunday')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayWithCheckbox(String day, bool isSelected, Function(bool?) onChanged) {
    bool isDaySelected = allDaysSelected || isSelected;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: isDaySelected,
            onChanged: onChanged,
          ),
          Expanded(
            child: Text(
              day,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                GestureDetector(
                  onTap: isDaySelected ? () => _pickTime(context, true, day) : null,
                  child: Container(
                    width: 90,
                    height: 30,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.alarm, size: 16, color: isDaySelected ? Colors.black : Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          _getTimeText(day, true),
                          style: TextStyle(fontSize: 12, color: isDaySelected ? Colors.black : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: isDaySelected ? () => _pickTime(context, false, day) : null,
                  child: Container(
                    width: 90,
                    height: 30,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.alarm, size: 16, color: isDaySelected ? Colors.black : Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          _getTimeText(day, false),
                          style: TextStyle(fontSize: 12, color: isDaySelected ? Colors.black : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeText(String day, bool isStartTime) {
    if (allDaysSelected) {
      // Use Monday's times if All Days are selected
      if (isStartTime) {
        return mondayStartTime?.format(context) ?? 'Opening';
      } else {
        return mondayEndTime?.format(context) ?? 'Closing';
      }
    } else {
      // Return specific day's time
      switch (day) {
        case 'All Days':
          return isStartTime ? allDaysStartTime?.format(context) ?? 'Opening' : allDaysEndTime?.format(context) ?? 'Closing';
        case 'Monday':
          return isStartTime ? mondayStartTime?.format(context) ?? 'Opening' : mondayEndTime?.format(context) ?? 'Closing';
        case 'Tuesday':
          return isStartTime ? tuesdayStartTime?.format(context) ?? 'Opening' : tuesdayEndTime?.format(context) ?? 'Closing';
        case 'Wednesday':
          return isStartTime ? wednesdayStartTime?.format(context) ?? 'Opening' : wednesdayEndTime?.format(context) ?? 'Closing';
        case 'Thursday':
          return isStartTime ? thursdayStartTime?.format(context) ?? 'Opening' : thursdayEndTime?.format(context) ?? 'Closing';
        case 'Friday':
          return isStartTime ? fridayStartTime?.format(context) ?? 'Opening' : fridayEndTime?.format(context) ?? 'Closing';
        case 'Saturday':
          return isStartTime ? saturdayStartTime?.format(context) ?? 'Opening' : saturdayEndTime?.format(context) ?? 'Closing';
        case 'Sunday':
          return isStartTime ? sundayStartTime?.format(context) ?? 'Opening' : sundayEndTime?.format(context) ?? 'Closing';
        default:
          return '';
      }
    }
  }
}