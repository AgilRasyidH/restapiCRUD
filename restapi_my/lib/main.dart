import 'package:flutter/material.dart';

import 'package:restapi_my/employee_form_add.dart';
import 'package:restapi_my/employee_list.dart';

void main(){
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp ({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'learn flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const EmployeeList(),
      routes: {
        'employee_list': (context) => const EmployeeList(),
        'employee_form_add': (context) => const EmployeeFormAdd()  
      },
    );
  }
}