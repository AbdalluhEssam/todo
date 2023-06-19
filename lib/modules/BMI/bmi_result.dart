import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  final bool isMale ;
  final int result ;
  final int age ;
  const BMIResultScreen({Key? key, required this.isMale, required this.result, required this.age}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("BMI RESULT"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Gender : ${isMale? 'Male' : 'Female'}",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Text("Result : $result",style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Text("AGE : $age",style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
