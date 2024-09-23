import 'package:flutter/material.dart';

class TriggRichContainer extends StatelessWidget {
  final String? title;
  final String bodyText;
  final String? tag;
  final VoidCallback? onTab;
  final double? bodySize;
  final bool showIcon;
  final double? containerHeight;

  const TriggRichContainer(
      {required this.bodyText,
      this.title,
      this.tag,
      this.onTab,
      this.showIcon = false,
      this.bodySize,
      this.containerHeight,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.5,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTab,
        child: Container(
          height: containerHeight,
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? '',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: bodySize),
                        text: bodyText,
                        children: [
                          TextSpan(
                            text: tag ?? '',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (showIcon)
                Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
