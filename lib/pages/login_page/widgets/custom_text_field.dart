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

  @override
  void initState() {
    super.initState();
    obsecure = widget.showSuffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: obsecure,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
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
      validator: widget.validatorFunction,
    );
  }
}
