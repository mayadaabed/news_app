import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Linkify(
            onOpen: _onOpen,
            text: 'My Linked In https://www.linkedin.com/feed/',
            style: const TextStyle(color: Colors.black, fontSize: 20),
            linkStyle: const TextStyle(color: Colors.red),
          ),
        ),
        Center(
          child: SelectableLinkify(
            onOpen: _onOpen,
            style: const TextStyle(color: Colors.black, fontSize: 20),
            linkifiers: [
              const UserTagLinkifier(),
              const PhoneNumberLinkifier(),
            ],
            text: "Made by https://cretezy.com\n\nMail: example@gmail.com",
          ),
        ),
      ],
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }
}
