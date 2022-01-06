import 'package:anitcorona/Functions/TextFunction.dart';
import 'package:flutter/material.dart';

class TitledListView extends StatefulWidget {
  final String title;
  final Widget child;
  final double? borderRadius;
  final double? onOpenBorderRadius;
  final Color? decorationColor;
  final Color? textColor;
  final double? fontSize;
  final Color? iconActionColor;
  final Color? iconDisActiveColor;
  final Color? borderColor;
  final double? onOpenSize;
  final Duration? duration;
  final BoxDecoration? boxDecorationOpen;
  final TextStyle? titleStyle;
  const TitledListView(
      {Key? key,
      required this.title,
      required this.child,
      this.borderRadius,
      this.onOpenBorderRadius,
      this.decorationColor,
      this.textColor,
      this.fontSize,
      this.iconActionColor,
      this.iconDisActiveColor,
      this.borderColor,
      this.onOpenSize,
      this.duration,
      this.boxDecorationOpen,
      this.titleStyle})
      : super(key: key);
  @override
  _WikiButtonState createState() => _WikiButtonState();
}

class _WikiButtonState extends State<TitledListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool showMenu = false;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (!showMenu)
                _controller.forward();
              else
                _controller.reverse();
              setState(() {
                showMenu = !showMenu;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color:
                      widget.decorationColor ?? Colors.black87.withOpacity(0.5),
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 5)),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${widget.title}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: widget.titleStyle ??
                              Theme.of(context).textTheme.button!.copyWith(
                                  color: widget.textColor ?? Colors.white,
                                  fontSize: widget.fontSize ?? 15),
                          textScaleFactor:
                              MyTextFunctions.getTheTextFactor(context),
                          textDirection: MyTextFunctions.getTextDirection(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: AnimatedIcon(
                      progress: _controller,
                      icon: AnimatedIcons.menu_close,
                      color: !showMenu
                          ? (widget.iconActionColor ?? Colors.white)
                          : (widget.iconDisActiveColor ?? Colors.red),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: AnimatedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: widget.child),
                ],
              ),
              height: showMenu ? (widget.onOpenSize ?? 150) : 0,
              duration: widget.duration ?? Duration(milliseconds: 500),
              decoration: widget.boxDecorationOpen ??
                  BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          widget.onOpenBorderRadius ?? 10),
                      border: Border.all(
                          color: (widget.borderColor ?? Colors.grey))),
            ),
          ),
        ],
      ),
    );
  }
}
