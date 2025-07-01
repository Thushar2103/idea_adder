import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'services/config.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: Config.supabaseUrl,
    anonKey: Config.supabaseAnon,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PreviewData? _previewData;
  final String _url = 'https://thushar-portfolio.netlify.app';

  @override
  void initState() {
    super.initState();
    _fetchPreview();
  }

  Future<void> _fetchPreview() async {
    final data = await getPreviewData(_url);
    setState(() {
      _previewData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LinkPreview(
              previewData: _previewData,
              width: double.maxFinite,
              enableAnimation: true,
              onPreviewDataFetched: (metadata) {
                debugPrint('Preview Data: $metadata');
              },
              text: 'https://thushar-portfolio.netlify.app',
              padding: const EdgeInsets.all(8),
            ),
          ],
        ),
      ),
    );
  }
}
