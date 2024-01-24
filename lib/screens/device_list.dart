import 'package:flutter/material.dart';
import 'package:heart/screens/ecg_details.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key});

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return _mainLayout();
  }

  // main layout
  Widget _mainLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: screenWidth,
          child: Column(
            children: [
              _noDeviceAvailable(),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  children: [
                    _deviceCard("Heart007", "2024/01/24"),
                    _deviceCard("Heart008", "2024/01/24"),
                  ],
                ),
              ),
              _addDevice()
            ],
          ),
        ),
      ),
    );
  }

  // add device button
  Widget _addDevice() {
    return SizedBox(
      height: 42,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.blue.shade700),
        ),
        onPressed: () {
          _showLoginDialog(context);
        },
        child: const Text(
          'Add Device',
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  // no device available
  Widget _noDeviceAvailable() {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        side: BorderSide(color: Colors.black54, width: 0.15),
      ),
      shadowColor: Colors.black38,
      elevation: 10,
      margin: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // title text
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "No device connected!",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent.shade700,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // details text
              const Text(
                "Please connect at least one ECG device",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          // right side
        ),
      ),
    );
  }

  // device card
  Widget _deviceCard(String device, String lastActive) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        side: BorderSide(color: Colors.black54, width: 0.15),
      ),
      shadowColor: Colors.black38,
      elevation: 10,
      margin: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top
              Text(
                "Device : $device",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // middle
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                child: Text(
                  "Last active : $lastActive",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // bottom
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Delete button
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SizedBox(
                      height: 35,
                      width: (screenWidth - 70) / 2,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent.shade700,
                          side: const BorderSide(
                              color: Colors.red), // Border color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            // Adjust the border radius as needed
                          ),
                        ),
                        onPressed: () {
                          _showYesNoDialog(context, device);
                        },
                        child: const Text("Delete"),
                      ),
                    ),
                  ),

                  // View Button
                  SizedBox(
                    height: 35,
                    width: (screenWidth - 70) / 2,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: const BorderSide(
                          color: Colors.blue,
                        ), // Border color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ECGDetails(
                              deviceId: device,
                            ),
                          ),
                        );
                      },
                      //
                      child: const Text("View"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // right side
        ),
      ),
    );
  }

  // show yes no dialog for delete device
  void _showYesNoDialog(BuildContext context, String device) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text("Do you want to delete '$device'?"),
          actions: [
            TextButton(
              onPressed: () {
                // Handle 'Yes' button press
                Navigator.pop(context, true); // Pass true back to the caller
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Handle 'No' button press
                Navigator.pop(context, false); // Pass false back to the caller
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    ).then(
      (result) {
        // Handle the result after the dialog is closed
        if (result != null && result is bool) {
          if (result) {
            // Handle 'Yes' action
          }
        }
      },
    );
  }

  // show login dialog
  void _showLoginDialog(BuildContext context) {
    TextEditingController deviceIDController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new device'),
          content: SizedBox(
            height: 120,
            width: screenWidth,
            child: Column(
              children: [
                TextField(
                  controller: deviceIDController,
                  decoration: const InputDecoration(labelText: 'DeviceID'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle adding logic here
                Navigator.pop(context, true); // Close the dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    ).then(
      (result) {
        // Handle the result after the dialog is closed
        if (result != null && result is bool) {
          if (result) {
            // Handle 'Yes' action
            String username = deviceIDController.text;
            String password = passwordController.text;
            print('Username: $username, Password: $password');
          }
        }
      },
    );
  }
}
