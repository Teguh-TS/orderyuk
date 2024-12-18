import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatelessWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  Widget build(BuildContext context) {
    // Panggil fungsi _launchURL begitu halaman ini dibuka
    _launchURL(url);
    return Scaffold(
      appBar: AppBar(
        title: Text('Redirecting to Web'),
      ),
      body: Center(
        child:
            CircularProgressIndicator(), // Tampilkan indikator loading saat URL diluncurkan
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
