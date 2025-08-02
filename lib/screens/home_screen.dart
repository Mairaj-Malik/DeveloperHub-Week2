import 'package:developers_hub_week2/screens/counter_screen.dart';
import 'package:developers_hub_week2/screens/to_do_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff272727),
      appBar: AppBar(
        backgroundColor: Color(0xff272727),
        title: Text(
          'Main Menu',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const CounterScreen())),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black45,
                minimumSize: Size(200, 48),
              ),
              child: Text('Counter', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const ToDoList())),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black45,
                minimumSize: Size(200, 48),
              ),
              child: Text('To - Do List', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
