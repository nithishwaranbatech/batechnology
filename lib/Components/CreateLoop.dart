import 'dart:math';
import 'package:flutter/material.dart';
import 'LoopSetting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _selectedPlace = 'Place 1'; // Default selected place
  RangeValues _rangeValues = RangeValues(0, 100); // Default range values
  List<int> _selectedDoctors = []; // Track selected doctors

List<String> _doctorStatuses = List.generate(6, (_) => Random().nextBool() ? "Online" : "Offline");

List<String> _doctorNames = [
    'Doctor 1', 'Doctor 2', 'Doctor 3', 'Doctor 4', 
    'Doctor 5', 'Doctor 6'
  ];  // List of doctor names for demonstration

List<String> _filteredDoctors = [];  // List for filtered doctors based on search query

  @override
  void initState() {
    super.initState();
    _filteredDoctors = _doctorNames; // Initially, show all doctors

    // Add listener to search field to update filtered doctors
    _searchController.addListener(() {
      setState(() {
        _filteredDoctors = _doctorNames
            .where((doctor) => doctor.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

void _showProfile(BuildContext context, int doctorIndex) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Get screen size
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      // Set width and height to be a fraction of the screen size
      final dialogWidth = screenWidth * 1.0; // 80% of screen width
      final dialogHeight = screenHeight * 1.0; // 60% of screen height

      return Dialog(
insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Removes the border radius
          ),
          child: Container(
            width: dialogWidth,
            height: dialogHeight,
            padding: EdgeInsets.all(20.0), // Content padding inside the dialog
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'View Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/doctor_placeholder.png'),
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileRow('Name', 'Doctor ${doctorIndex + 1}'),
                      _buildProfileRow('Qualification', 'MBBS'),
                      _buildProfileRow('Role', 'Pediatrician'),
                      _buildProfileRow('Location', 'Chennai'),
                      _buildProfileRow('Consulting fees', '500 rupees'),
                      _buildProfileRow('Hours Available', 'All days (4pm - 8 pm)'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


// Function to build each profile row with evenly spaced text
Widget _buildProfileRow(String label, String data) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal:10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Evenly space label and data
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        Text(
          ':',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
    Expanded(
  flex: 5,
  child: Padding(
    padding: const EdgeInsets.only(left: 30), // Apply padding to the right
    child: Text(
      data,
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.left,
    ),
  ),
),

      ],
    ),
  );
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Loop'),
        backgroundColor: Colors.white, // Header color set to white
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
          child: Divider(color: Colors.black), // Line below header
        ),
      ),
      backgroundColor: Colors.white,  // Set background color of the whole screen to white
      body: SingleChildScrollView(  // Wrap the whole body in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upload Section
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFEBEBEB), // Set container background color to #EBEBEB
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Upload',
                      textAlign: TextAlign.center,  // Center the "Upload" text
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,  // Center the icons
                      children: [
                        IconButton(
                          icon: Icon(Icons.videocam),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.music_note),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Title Section (Removed borders)
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFEBEBEB), // Set container background color to #EBEBEB
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: InputBorder.none,  // No border
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Description Section (Removed borders)
        Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFEBEBEB), // Set container background color to #EBEBEB
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        controller: _descriptionController,
        decoration: InputDecoration(
          labelText: 'Description',
          border: InputBorder.none, // No border
        ),
        maxLines: 3,
      ),
    ),
    SizedBox(height: 8.0), // Space between TextField and description text
    Align(
      alignment: Alignment.centerLeft, // Align the text to the left
      child: Text(
        'A brief summary of your page. The limit is 255 characters.',
        style: TextStyle(
          fontSize: 8,
          color: Colors.grey[700], // Optional: text color for readability
        ),
      ),
    ),
    SizedBox(height: 16.0), // Additional spacing below the description text if needed
  ],
),

              // Search Doctors section
              Column(
                children: [
                  // Centered Person Icon and Search Doctors label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 8),
                      Text(
                        'Search Doctors',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Input field with dropdown and search button
                  Container(
                    decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), 
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                      height:40,

                    child: Row(
                      children: [
                        // Dropdown with places on the left
                        Expanded(
                          flex: 2, // Adjust the width of the dropdown
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0) ,
                            child: DropdownButton<String>(
                              value: _selectedPlace,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedPlace = newValue!;
                                });
                              },
                              items: <String>['Place 1', 'Place 2', 'Place 3', 'Place 4']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(value: value, child: Text(value));
                              }).toList(),
                            ),
                          ),
                        ),
                        
                        // Vertical line divider
                        Container(
                          width: 1,
                          height: 40, // Adjust the height as needed
                          color: Colors.grey, // Vertical line color
                        ),
                        
                        // Center: "Search query" hint text
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search query',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        
                        // Search button with "Search" text instead of icon
                        Container(
                          width: 70,  // Adjust the width as needed
                          height: 40, // Adjust the height to fit the input container
                          decoration: BoxDecoration(
                            color: Color(0xFF3754A2),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              'Search',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),

                  // Range Slider Section
                  RangeSlider(
                    values: _rangeValues,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    labels: RangeLabels(
                      _rangeValues.start.round().toString(),
                      _rangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _rangeValues = values;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),

              // Selected doctors tags section (below the range slider)
Wrap(
  spacing: 8.0, // Adjust space between tags
  runSpacing: 4.0, // Adjust space between rows of tags
  children: _selectedDoctors.map((index) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Customize padding
          decoration: BoxDecoration(
            color: Colors.grey[300], // Background color for the tag
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: Text(
            'Doctor ${index + 1}',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Positioned(
          top: -3, // Positioning the icon at the top-right corner with an offset
          right: -3,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedDoctors.remove(index); // Remove the tag when X is clicked
              });
            },
            child: Container(
              padding: EdgeInsets.all(2), // Optional padding for the icon
              decoration: BoxDecoration(
                color: Colors.black, // Background color of the "X" icon
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 16,
                color: Colors.white, // Customize icon color
              ),
            ),
          ),
        ),
      ],
    );
  }).toList(),
),
                  SizedBox(height: 16.0),

                  // Doctor list section
  ListView.builder(
  shrinkWrap: true,
  itemCount: 6, // Replace with your actual doctor list length
  itemBuilder: (context, index) {
    return ListTile(
      leading: CircleAvatar(
         radius: 10.0, 
        child: Text('${index + 1}'),
      ),
     title: Row(
  children: [
    Text(
      'Doctor ${index + 1}',  // Doctor name
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.04, // Responsive font size
      ),
    ),
    SizedBox(width: 8),
  ],
),
     trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    // Online/Offline status
    Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Smaller padding
      decoration: BoxDecoration(
        color: _doctorStatuses[index] == "Online" ? Colors.green : Colors.grey,  // Green for online, grey for offline
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        _doctorStatuses[index],  // Use the stored status
        style: TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.bold, 
          fontSize: MediaQuery.of(context).size.width * 0.02,
        ),
      ),
    ),
    SizedBox(width: 8),  // Gap between status and View Profile button
    // View Profile button
    GestureDetector(
      onTap: () {
        _showProfile(context, index); // Open the profile
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'View Profile',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold, 
            fontSize: MediaQuery.of(context).size.width * 0.02
          ),
        ),
      ),
    ),

          // Checkbox for selecting doctor
         Checkbox(
  value: _selectedDoctors.contains(index),
  onChanged: (value) {
    setState(() {
      if (value == true) {
        _selectedDoctors.add(index);
      } else {
        _selectedDoctors.remove(index);
      }
    });
  },
  checkColor: Colors.white, // Color of the check inside the box
  activeColor: Colors.blue,  // Color of the checkbox when it's checked
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4), // Customize border radius for a rounded checkbox
  ),
  side: BorderSide(
    color: Colors.grey, // Border color of the checkbox when unchecked
    width: 1.5,         // Border width
  ),
),

        ],
      ),
    );
  },
),


                  SizedBox(height: 16.0),

                 Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the LoopSetting screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoopSetting()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3754A2),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Create Loop',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
  ),
),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
