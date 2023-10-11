import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

// ignore: must_be_immutable
class ExpandText extends StatefulWidget {
  ExpandText(
      {super.key,
      required this.labelHeader,
      required this.description,
      required this.shortDescription});

  String labelHeader;
  // String labelFooter;
  String description;
  String shortDescription;

  @override
  State<ExpandText> createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText> {
  bool descTextShowFlag = false;

  String getlongText() {
    return widget.shortDescription.length > widget.description.length
        ? widget.shortDescription
        : widget.description;
  }

  String getShortText() {
    return widget.shortDescription.length < widget.description.length
        ? widget.shortDescription
        : widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.labelHeader,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Html(
          data: descTextShowFlag ? getlongText() : getShortText(),
          // style: {
          //   "div": Style(
          //     padding: HtmlPaddings.only(top: 0, bottom: 0),
          //     fontSize: FontSize.medium,
          //   )
          // },
        ),
        Align(
          child: GestureDetector(
            child: Text(
              descTextShowFlag ? "Read Less" : "Read More",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            onTap: () {
              setState(() {
                descTextShowFlag = !descTextShowFlag;
              });
            },
          ),
        ),
      ]),
    );
  }
}
