// ignore_for_file: file_names
import 'package:flutter/material.dart';

enum InputType {
  name,
  email,
  password,
  phone,
  address,
  number,
  longText,
}

class PrimaryTextFieldWithHeader extends StatefulWidget {
  final bool isObscure;
  final String? hintText;
  final InputType inputType;
  final double? radius;
  final String? fixedValue;
  final String? initialValue;
  final bool? isEditable;
  final bool? isRequired;
  final Color? backgroundColor;
  final void Function(String value) onChangedValue;

  const PrimaryTextFieldWithHeader(
      {Key? key,
      this.hintText,
      required this.isObscure,
      required this.onChangedValue,
      required this.inputType,
      this.isEditable,
      this.fixedValue,
      this.isRequired,
      this.initialValue,
      this.radius,
      this.backgroundColor})
      : super(key: key);

  @override
  State<PrimaryTextFieldWithHeader> createState() =>
      _PrimaryTextFieldWithHeaderState();
}

class PrefixItem {
  final String prefix;
  final String country;
  final String shortCode;

  const PrefixItem(
      {required this.prefix, required this.country, required this.shortCode});
}

class _PrimaryTextFieldWithHeaderState
    extends State<PrimaryTextFieldWithHeader> {
  // final String? Function(String? value) validator;
  late bool textVisibility;
  static const List<PrefixItem> phonePrefixes = [
    PrefixItem(prefix: "+966", country: "Saudi Arabia", shortCode: "SA"),
    PrefixItem(prefix: "+20", country: "Egypt", shortCode: "EG")
  ];
  PrefixItem phonePrefix = phonePrefixes.first;
  String valueBuffer = "";

  @override
  void initState() {
    super.initState();
    textVisibility = widget.isObscure;
    valueBuffer = widget.initialValue ?? widget.fixedValue ?? "";
    valueBuffer =
        phonePrefixes.any((element) => valueBuffer.startsWith(element.prefix))
            ? valueBuffer.substring(phonePrefixes
                .firstWhere((element) => valueBuffer.startsWith(element.prefix))
                .prefix
                .length)
            : valueBuffer;
    if (widget.inputType == InputType.phone) {
      String query;
      if (widget.initialValue != null) {
        query = widget.initialValue!;
      } else if (widget.fixedValue != null) {
        query = widget.fixedValue!;
      } else {
        return;
      }
      phonePrefix = phonePrefixes.cast<PrefixItem?>().firstWhere(
              (element) => query.startsWith(element!.prefix),
              orElse: () => null) ??
          phonePrefixes.first;
    }
  }

  @override
  void didUpdateWidget(covariant PrimaryTextFieldWithHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.inputType == InputType.phone) {
      String query;
      if (widget.initialValue != null) {
        query = widget.initialValue!;
      } else if (widget.fixedValue != null) {
        query = widget.fixedValue!;
      } else {
        return;
      }
      phonePrefix = phonePrefixes.cast<PrefixItem?>().firstWhere(
              (element) => query.startsWith(element!.prefix),
              orElse: () => null) ??
          phonePrefixes.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: widget.backgroundColor ?? Colors.black12),
          borderRadius: BorderRadius.circular(widget.radius ?? 10),
        ),
        child: Column(
          children: [
            if (widget.hintText != null)
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.inputType == InputType.phone) ...[
                        Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    widget.backgroundColor ?? Colors.black12),
                            borderRadius:
                                BorderRadius.circular(widget.radius ?? 10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: DropdownButton<PrefixItem>(
                              isExpanded: true,
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(25),
                              items: !(widget.isEditable ?? true)
                                  ? []
                                  : phonePrefixes
                                      .map((e) => DropdownMenuItem<PrefixItem>(
                                            value: e,
                                            child: Text(
                                                "${e.country} (${e.prefix})"),
                                          ))
                                      .toList(),
                              selectedItemBuilder: (context) => phonePrefixes
                                  .map((e) => DropdownMenuItem<PrefixItem>(
                                        value: e,
                                        child: Text(
                                            "${e.prefix} (${e.shortCode})"),
                                      ))
                                  .toList(),
                              hint: !(widget.isEditable ?? true)
                                  ? Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 0),
                                      child: Text(
                                          "${phonePrefix.prefix} (${phonePrefix.shortCode})"))
                                  : const SizedBox(),
                              value: phonePrefix,
                              onChanged: (newVal) => setState(() {
                                    phonePrefix = newVal ?? phonePrefixes.first;
                                    widget.onChangedValue(
                                        phonePrefix.prefix + valueBuffer);
                                  })),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                              color: widget.backgroundColor ?? Colors.black12),
                          enabled: widget.isEditable,
                          maxLines:
                              widget.inputType == InputType.longText ? 7 : 1,
                          obscureText: textVisibility,
                          maxLength:
                              widget.inputType == InputType.name ? 15 : null,
                          keyboardType: widget.inputType == InputType.phone ||
                                  widget.inputType == InputType.number
                              ? TextInputType.number
                              : null,
                          initialValue: widget.inputType == InputType.phone &&
                                  widget.initialValue != null &&
                                  phonePrefixes.any((element) => widget
                                      .initialValue!
                                      .startsWith(element.prefix))
                              ? widget.initialValue!.substring(phonePrefixes
                                  .firstWhere((element) => widget.initialValue!
                                      .startsWith(element.prefix))
                                  .prefix
                                  .length)
                              : widget.initialValue,
                          onFieldSubmitted: (newVal) {
                            valueBuffer = newVal;
                            if (widget.inputType == InputType.phone) {
                              widget
                                  .onChangedValue(phonePrefix.prefix + newVal);
                            } else {
                              widget.onChangedValue(newVal);
                            }
                          },
                          // onChanged: (newVal) {
                          //   valueBuffer = newVal;
                          //   if (widget.inputType == InputType.phone) {
                          //     widget
                          //         .onChangedValue(phonePrefix.prefix + newVal);
                          //   } else {
                          //     widget.onChangedValue(newVal);
                          //   }
                          // },
                          decoration: InputDecoration(
                            suffixIcon: widget.inputType == InputType.password
                                ? IconButton(
                                    icon: const Icon(Icons.visibility,
                                        color: Colors.grey),
                                    onPressed: () => setState(
                                      () {
                                        textVisibility = !textVisibility;
                                      },
                                    ),
                                  )
                                : null,
                            contentPadding: const EdgeInsets.all(10),
                            hintText: widget.hintText ?? "",
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color:
                                    widget.backgroundColor ?? Colors.black12),
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                color: widget.backgroundColor ?? Colors.black12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
