import 'package:flutter/material.dart';
import 'package:heart/screens/device_list.dart';
import 'package:heart/screens/setup_wifi.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;

  Widget getPage(int index) {
    if (index == 0) {
      return const DeviceList();
    } else {
      return const SetupWifi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("ECG Monitor"),
        elevation: 0,
      ),
      body: getPage(index),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.shade700,
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(
              color: Colors.white,
            ),
          ),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.blue,
          animationDuration: const Duration(milliseconds: 600),
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.device_hub),
              selectedIcon: Icon(Icons.device_hub_sharp),
              label: "Devices",
            ),
            NavigationDestination(
              icon: Icon(Icons.wifi),
              selectedIcon: Icon(Icons.wifi_find_rounded),
              label: "Setup WIFI",
            )
          ],
        ),
      ),
    );
  }
}
