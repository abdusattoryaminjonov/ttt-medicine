import 'package:flutter/material.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi Abdusattor",style:TextStyle(
          fontFamily: 'Roboto',  // Specify the font family
          fontSize: 18.0,        // You can also specify other properties
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),),
        leading: Container(
          margin: EdgeInsets.only(left: 10,top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            border: Border.all(
              width: 1,
              color: const Color.fromRGBO(119, 50, 255, 1.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: const Image(
              image: AssetImage("assets/images/myphoto.jpg"),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            )
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10,top: 10),
            child: const Icon(
              Icons.notifications,
              color: Colors.deepPurple,
            ),
          )
        ],
      ),
    );
  }
}
