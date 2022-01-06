import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class BasicInputWidgets {
  static bool _showPassword = true;

  ///This is Text Used to show
  ///[Note] this contain a [validatorFunctions] which are the list of validator for this
  ///input box beside there is prefix Icon
  static Widget formInputBox(
    TextEditingController Controler,
    TextLable, {
    TextInputType TypeOFKeyBorad = TextInputType.text,
    bool Enabl = true,
    List<Function(String value)>? validatorFunctions,
    IconData? myIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: Enabl,
        keyboardType: TypeOFKeyBorad,
        controller: Controler,
        validator: (Text) {
          if (TypeOFKeyBorad == TextInputType.emailAddress) {
            bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(Text!);
            if (!emailValid) {
              return S.current.notValideText;
            }
          }
          if (Text!.isEmpty || 60 < Text.length) {
            return S.current.notValideText;
          }
          try {
            if (validatorFunctions!.length > 0) {
              for (Function val in validatorFunctions) {
                if (val(Text) != null) return val(Text);
              }
            }
          } catch (e) {
            // print(e);
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            labelText: TextLable,
            prefixIcon: myIcon != null ? Icon(myIcon) : null,
            errorStyle: TextStyle(color: Colors.redAccent)),
      ),
    );
  }

  ///This is Text Used to OPT
  ///[Note] the second password is for testing if two passwords are matched
  static Widget formPasswordBox(Controler, TextLable,
      {TextEditingController? secondPassword}) {
    return StatefulBuilder(builder: (BuildContext context, Stater) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          obscureText: _showPassword,
          controller: Controler,
          validator: (Text) {
            if (12 < Text!.length || Text.length < 6) {
              return S.current.textError1;
            }
            if (Text.isEmpty) {
              return S.current.notValideText;
            }
            if (secondPassword != null) {
              if (secondPassword.text != Text) {
                return S.current.passwordsError;
              }
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            labelText: TextLable,
            errorStyle: TextStyle(color: Colors.redAccent),
            prefixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  Stater(() {
                    _showPassword = !_showPassword;
                  });
                }),
          ),
        ),
      );
    });
  }
}
