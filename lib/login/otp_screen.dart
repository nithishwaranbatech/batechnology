import 'package:flutter/material.dart';
import 'ChangePasswordScreen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  OtpScreen({required this.phoneNumber});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
  }

  void _onChanged(String value, FocusNode nextFocusNode,
      FocusNode currentFocusNode, FocusNode prevFocusNode) {
    if (value.isEmpty) {
      // If the user erased a digit, move focus to the previous field.
      FocusScope.of(context).requestFocus(prevFocusNode);
    } else if (value.length == 1) {
      // If the user typed a digit, move focus to the next field.
      FocusScope.of(context).requestFocus(nextFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              "Verification",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(width: 48),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Text(
              "Phone Verification",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 8),
            Text(
              "Code is sent to: ${widget.phoneNumber}",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOtpTextField(
                    _otpController1, _focusNode1, _focusNode2, _focusNode1),
                _buildOtpTextField(
                    _otpController2, _focusNode2, _focusNode3, _focusNode1),
                _buildOtpTextField(
                    _otpController3, _focusNode3, _focusNode4, _focusNode2),
                _buildOtpTextField(
                    _otpController4, _focusNode4, _focusNode4, _focusNode3),
              ],
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't receive code?",
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Request again",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0043B4),
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Verify",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpTextField(
      TextEditingController controller,
      FocusNode currentFocusNode,
      FocusNode nextFocusNode,
      FocusNode prevFocusNode) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        color: Color(0xFFF8F8F8),
        child: TextField(
          controller: controller,
          focusNode: currentFocusNode,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '',
            hintStyle: TextStyle(color: Colors.grey.shade400),
            counterText: "",
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          onChanged: (value) {
            _onChanged(value, nextFocusNode, currentFocusNode, prevFocusNode);
          },
        ),
      ),
    );
  }
}
