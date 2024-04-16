import 'package:url_launcher/url_launcher.dart';

void openURL(String url) {
  var encodedUrl = Uri.encodeFull(url);
  _launchURL(encodedUrl);
}

void _launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
