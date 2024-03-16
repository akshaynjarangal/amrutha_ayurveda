import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationIconWidget extends StatelessWidget {
  const NotificationIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Stack(
        alignment: Alignment.topRight,
        children: [
          SvgPicture.asset(
            'assets/icons/bell.svg',
            height: 28,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 4, top: 2),
            child: CircleAvatar(
              radius: 4,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}