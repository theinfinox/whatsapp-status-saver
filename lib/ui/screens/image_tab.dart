import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/status_controller.dart';
import '../widgets/status_tile.dart';

class ImageTab extends StatefulWidget {
  const ImageTab({Key? key}) : super(key: key);

  @override
  State<ImageTab> createState() => _ImageTabState();
}

class _ImageTabState extends State<ImageTab> {
  List<File> _images = [];
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
      _images = files.where((f) => ['.jpg', '.jpeg', '.png', '.webp', '.gif'].contains(f.path.toLowerCase().split('.').last)).toList();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_images.isEmpty) return const Center(child: Text('No images found. View statuses in WhatsApp first.'));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: _images.length,
        itemBuilder: (context, idx) {
          final f = _images[idx];
          return StatusTile(
            file: f,
            isVideo: false,
            onTap: () {
              Navigator.pushNamed(context, '/preview', arguments: {'file': f.path, 'isVideo': false});
            },
          );
        },
      ),
    );
  }
}