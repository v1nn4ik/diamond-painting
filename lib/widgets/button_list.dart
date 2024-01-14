import 'package:diamond_painting/widgets/button_with_number.dart';
import 'package:flutter/material.dart';

class ButtonList extends StatefulWidget {
  final List<ButtonWithNumber> buttons;

  const ButtonList({super.key, required this.buttons});

  @override
  State<ButtonList> createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  late List<bool> favoriteState;

  @override
  void initState() {
    favoriteState = List.generate(
        widget.buttons.length, (index) => widget.buttons[index].isFavorite);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < widget.buttons.length; i++)
          ButtonWithNumber(
            number: widget.buttons[i].number,
            onTap: () {
              for (var j = 0; j < favoriteState.length; j++) {
                favoriteState[j] = false;
              }
              setState(() {
                favoriteState[i] = true;
                if (widget.buttons[i].onTap != null) {
                  widget.buttons[i].onTap!();
                }
              });
            },
            isFavorite: favoriteState[i],
          )
      ],
    );
  }
}
