
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final String button_text;
  Color? color;
  PrimaryButton(this.button_text,{this.color}) ;
  @override
  Widget build(BuildContext context) {
    return  Container(

      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical:12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          color: color!=null ? color : Colors.black
      ),
      child: Center(child:
        Text(button_text , style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Colors.white,

        ),
        )
      ),
    );
  }
}
