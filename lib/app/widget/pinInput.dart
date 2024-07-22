import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';
import 'package:flutter/services.dart';
class PinInput extends StatelessWidget {
   final bool isFirst;
   final TextEditingController controller;
   final bool autoFocus;
   const PinInput( {Key? key,required this.controller, required this.autoFocus,this.isFirst=false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return SizedBox(
      height: ScreenAdapter.height(180),
      width:  ScreenAdapter.height(120),
      child: TextField(        
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,        
         cursorColor: Theme.of(context).primaryColor,
        decoration:  InputDecoration(
            border: const OutlineInputBorder(),
            counterText: '',  //位于右下方显示的文本，常用于显示输入的字符数量
            hintStyle: TextStyle(color: Colors.black, fontSize: ScreenAdapter.fontSize(40))),
           onChanged: (value) {
              print(value);
              print(Clipboard.getData(Clipboard.kTextPlain));
              if (value.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }      
              if (value.isEmpty&&!isFirst) {
                FocusScope.of(context).previousFocus();
              }            
           },
        
      ),
    );
  }
}