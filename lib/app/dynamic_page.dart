// ignore_for_file: avoid_print

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({Key? key}) : super(key: key);

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  Uri? myUrl;
  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      print('Success');
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        setState(() {
          myUrl = deepLink;
        });
        // Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      setState(() {
        myUrl = deepLink;
      });
      // Navigator.pushNamed(context, deepLink.path);
    }
  }

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Links'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                launch('https://zianfahrudy.page.link/kucing');
              },
              child: const Text(
                'Open Manual',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),

            const SizedBox(
              height: 50,
            ),
            myUrl != null
                ? TextButton(
                    onPressed: () => launch(myUrl.toString()),
                    child: const Text('Open Dynamic Link'),
                  )
                : const Text('Kosong'),
            // Text(myUrl != null ? myUrl.toString() : 'Kosong'),
          ],
        ),
      ),
    );
  }
}
