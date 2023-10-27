import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _username = TextEditingController();

  final ValueNotifier<DateTime> _selectedDate = ValueNotifier(DateTime.now());

  DateTime? ddt;

  void pickDate(DateTime value) {
    setState(() {
      ddt = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    ChildPage cp = ChildPage(_selectedDate, pickDate);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "${ddt}",
              style: TextStyle(fontSize: 30),
            ),
            cp,
            TextField(
              controller: _username,
            ),
            TextButton(
                onPressed: () {
                  print("유저네임 : ${_username.text}");
                  print("날짜 : ${_selectedDate.value}");
                  print("날짜 : ${cp.ddd}");
                  print("날짜 : ${ChildPage.d}");
                  print("ddt 날짜 : ${ddt}");
                },
                child: Text("버튼")),
          ],
        ),
      ),
    );
  }
}

class ChildPage extends StatelessWidget {
  final ValueNotifier<DateTime> selectedDate;

  static DateTime? d;
  DateTime? ddd;
  final pickDate;

  ChildPage(
    this.selectedDate,
    this.pickDate, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoDatePicker(
        onDateTimeChanged: (value) {
          print(value);
          selectedDate.value = value;
          d = value;
          ddd = value;

          pickDate(value);
        },
      ),
    );
  }
}
