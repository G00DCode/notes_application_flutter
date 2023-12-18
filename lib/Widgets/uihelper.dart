import 'package:flutter/material.dart';

import '../Database/dbhelper.dart';
import '../Models/notesmodel.dart';

class UiHelper{


  static CustomTextField(TextEditingController controller, String text, IconData iconData){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: TextField(
        controller:  controller,
        decoration: InputDecoration(
            hintText:  text,
            suffixIcon: Icon(iconData),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
      ),
    );
  }

}
