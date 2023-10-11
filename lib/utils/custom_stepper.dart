import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomStepper extends StatefulWidget {
  CustomStepper(
      {super.key,
      required this.lowerLimit,
      required this.upperLimit,
      required this.stepValue,
      required this.iconSize,
      required this.value,
      required this.onChanged});

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;
  final ValueChanged<dynamic> onChanged;

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => {
                    setState(() {
                      if (widget.value > widget.lowerLimit) {
                        widget.value -= widget.stepValue;
                        widget.onChanged(widget.value);
                      }
                    })
                  },
              icon: const Icon(Icons.remove)),
          Text(
            '${widget.value}',
            style: TextStyle(fontSize: widget.iconSize * 0.8),
            textAlign: TextAlign.center,
          ),
          IconButton(
              onPressed: () => {
                    setState(() {
                      if (widget.value < widget.upperLimit) {
                        widget.value += widget.stepValue;
                        widget.onChanged(widget.value);
                      }
                    })
                  },
              icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
