import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/shared.dart';

import '../../style/colors.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onPress;
  const MainAppBar({super.key, required this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            navigateTo(
              context,
              SearchScreen(),
            );
          },
          icon: Icon(
            Icons.search,
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          )),
      title: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 20, fontWeight: FontWeight.bold, color: white),
      ),
      actions: [
        IconButton(
            onPressed: onPress,
            icon: Icon(
              Icons.brightness_2,
              color: Theme.of(context).appBarTheme.iconTheme!.color,
            )),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
