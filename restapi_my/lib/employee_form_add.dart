// flutter pub add intl
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'restapi.dart';

class EmployeeFormAdd extends StatefulWidget{
  const EmployeeFormAdd({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeFormAddState createState() => _EmployeeFormAddState();
}

  class _EmployeeFormAddState extends State<EmployeeFormAdd>{
    final name = TextEditingController();
    final phone = TextEditingController();
    final email = TextEditingController();
    final birthday = TextEditingController();
    final address = TextEditingController();
    String gender = 'Male';

    late Future<DateTime?> selectedDate;
    String date = "-";

    DataService ds = DataService();

    @override
    Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text("Employee Form Add"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            // Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: name,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Full Name',
                ),
              ),
            ),
            // gender
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  filled: false,
                  border: InputBorder.none,
                ),
                value: gender,
                onChanged: (String? newValue) {
                  if(kDebugMode){
                    print(newValue);
                  }

                  setState(() {
                    gender = newValue!;
                  });
                },
                items: <String> ['Male', 'Female']
                .map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList())),
                // birthday
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: birthday,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Birthday",
                    ),
                    onTap: (){
                      showDialogPicker(context);
                    },
                  ),
              ),
              // Phone
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "phone number",
                  ),
                ),
              ),
              // email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email address",
                  ),
                ),
              ),
              // Address
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: address,
                  maxLines: 4,
                  minLines: 3,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Address",
                  ),
                ),
              ),
              //submit button
              Padding(
                padding: 
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen, elevation: 0),
                      onPressed: () async {
                        String response = await ds.insertEmployee(
                          "63476ca599b6c11c094bd5d8",
                          name.text,
                          phone.text,
                          email.text,
                          birthday.text,
                          gender,
                          address.text,
                          "-");

                        if (kDebugMode) {
                          print(response);
                        }
                      },
                      child: const Text("SUBMIT"),
                        ),
                ))
          ],
        ));

}
    // date picker
    void showDialogPicker(BuildContext context){
      selectedDate = showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1980),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light(),
              child: child!,
            );
          },
        );

        selectedDate.then((value) {
          setState(() {
            // ignore: unnecessary_null_comparison
            if (value == null) return;

            final DateFormat formatter = DateFormat('dd-MMM-yyyy');
            final String formattedDate = formatter.format(value);
            birthday.text = formattedDate;
          });
        }, onError: (error) {
          if (kDebugMode) {
            print(error);
          }
        });
        }
     }