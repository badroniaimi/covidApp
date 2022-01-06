import 'package:flutter/material.dart';

class MenuAppBar extends StatefulWidget {
  final Function() onTap;
  final bool showMenu;
  const MenuAppBar({Key? key, required this.onTap, this.showMenu = false})
      : super(key: key);
  @override
  _MenuAppBarState createState() => _MenuAppBarState();
}

class _MenuAppBarState extends State<MenuAppBar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(child: child, scale: animation);
        },
        duration: Duration(milliseconds: 200),
        child: !widget.showMenu
            ? Icon(
                Icons.sort_rounded,
                key: ValueKey<bool>(widget.showMenu),
                size: 50,
                color: Colors.black87.withOpacity(0.9),
              )
            : Icon(
                Icons.menu_open_rounded,
                key: ValueKey<bool>(widget.showMenu),
                size: 50,
                color: Colors.black87.withOpacity(0.9),
              ),
      ),
    );
  }
}
