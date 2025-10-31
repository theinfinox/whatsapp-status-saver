import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/status_controller.dart';
import '../widgets/status_tile.dart';

class VideoTab extends StatefulWidget {
  const VideoTab({Key? key}) : super(key: key);

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  List<File> _videos = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _scan();
  }

  Future<void> _scan() async {
    setState(() => _loading = true);
    final controller = Provider.of<StatusController>(context, listen: false);
    final files = await controller.scan();
    setState(() {
      _videos = files.where((f) => ['.mp4', '.mov'].contains(f.path.toLowerCase().split('.').last)).toList();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_videos.isEmpty) return const Center(child: Text('No videos found. View statuses in WhatsApp first.'));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: _videos.length,
        itemBuilder: (context, idx) {
          final f = _videos[idx];
          return StatusTile(
            file: f,
            isVideo: true,
            onTap: () {
              Navigator.pushNamed(context, '/preview', arguments: {'file': f.path, 'isVideo': true});
            },
          );
        },
      ),
    );
  }
}