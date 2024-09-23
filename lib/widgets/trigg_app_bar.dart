import 'package:flutter/material.dart';
import 'package:trigg_app/widgets/trigg_pop_button.dart';

class TriggAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool transparent;
  final VoidCallback? customPop;

  TriggAppBar({this.title, this.transparent = false, this.customPop});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? '',
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.white),
      ),
      backgroundColor: transparent ? Colors.transparent : null,
      elevation: transparent ? 0 : null,
      leading: Navigator.canPop(context)
          ? TriggPopButton(customPop: customPop)
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
