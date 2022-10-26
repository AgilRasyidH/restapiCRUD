import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:restapi_my/employee_model.dart';

import 'restapi.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  EmployeeListState createState() => EmployeeListState();
}

class EmployeeListState extends State<EmployeeList>{
  DataService ds = DataService();

  List data = [];
  List<EmployeeModel> employee = [];

  selectAllEmployee() async {
    data = jsonDecode(await ds.selectAll('63476cea99b6c11c094bd5ea', 'office',
    'employee', '63476ca599b6c11c094bd5d8'));
    employee = data.map((e) => EmployeeModel.fromJson(e)).toList();

    setState(() {
      employee = employee;
    });

    if(kDebugMode) {
      print(employee.length);
      print(data);
    }
  }

  @override
  void initState(){
    selectAllEmployee();

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'employee_form_add');
              },
              child: const Icon(
                Icons.add,
                size: 26.0,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        // let the listview know how many items it needs to build
        itemCount: employee.length,
        // Provide a builder function. This is where the magic happens.
        // convert each item into a widget based on the ype of item it is.
        itemBuilder: (context, index) {
          final item = employee[index];

          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.birthday),
          );
        },
      ),
    );
  }
}