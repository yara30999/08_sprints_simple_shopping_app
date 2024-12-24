import 'package:flutter/material.dart';
import '../../../resources/type_def.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.textEditingController,
      required this.label,
      required this.validatorFunction,
      this.showSuffixIcon = false});

  final TextEditingController textEditingController;
  final String label;
  final ValidatorFunction validatorFunction;
  final bool showSuffixIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obsecure;
  bool hasError = false;
  String? errorText;

  @override
  void initState() {
    super.initState();
    obsecure = widget.showSuffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  hasError ? const Color(0xFFB11B11) : const Color(0xFFFCFCFC),
            ),
            boxShadow: [
              BoxShadow(
                color: hasError
                    ? const Color(0xFFB11B11)
                    : const Color(0xFF9FD4F8),
                spreadRadius: 3,
                blurRadius: 8,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.textEditingController,
            obscureText: obsecure,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.label,
              // Hide the error text
              errorStyle:
                  TextStyle(height: 0, color: Colors.transparent, fontSize: 0),
              /*
                all these borders could be in the theme of the text field,      
                but i did not implement theme in this project , because i hate over engineering :)
                and i saw this UI, so i wanted to implemented myself.
              */
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffix: Visibility(
                visible: widget.showSuffixIcon,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      obsecure = !obsecure;
                    });
                  },
                  child: Icon(
                    obsecure == true ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            validator: (value) {
              final error = widget.validatorFunction?.call(value);
              setState(() {
                hasError = error != null;
                errorText = error;
              });
              return error;
            },
          ),
        ),
        // show the error message outside the shadow :)
        if (hasError && errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Color.fromARGB(255, 177, 27, 17),
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
