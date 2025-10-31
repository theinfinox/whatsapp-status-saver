import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../widgets/custom_appbar.dart';
import 'package:share_plus/share_plus.dart';


class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  VideoPlayerController? _controller;
  String? filePath;
  bool isVideo = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    filePath = args?['file'];
    isVideo = args?['isVideo'] ?? false;

    if (isVideo && filePath != null) {
      _controller = VideoPlayerController.file(File(filePath!))
        ..initialize().then((_) {
          if (!mounted) return;
          setState(() {});
          _controller!.play();
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _saveToGallery() async {
    if (filePath == null) return;
    if (isVideo) {
      await GallerySaver.saveVideo(filePath!);
    } else {
      await GallerySaver.saveImage(filePath!);
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved to gallery')));
  }

  Future<void> _shareFile() async {
    if (filePath == null) return;

    final box = context.findRenderObject() as RenderBox?;
    final origin = box != null ? (box.localToGlobal(Offset.zero) & box.size) : Rect.fromLTWH(0, 0, 0, 0);

    // Build ShareParams using the modern SharePlus API.
    final params = ShareParams(
      text: 'Check out this status',
      files: [XFile(filePath!)],
      sharePositionOrigin: origin,
    );

    // Use the SharePlus singleton. This is the non-deprecated method.
    await SharePlus.instance.share(params);
  }

  @override
  Widget build(BuildContext context) {
    if (filePath == null) return const SizedBox();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Preview'),
      body: Center(
        child: isVideo
            ? (_controller != null && _controller!.value.isInitialized
                ? AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: VideoPlayer(_controller!))
                : const CircularProgressIndicator())
            : Image.file(File(filePath!)),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: _saveToGallery,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _shareFile,
            ),
          ],
        ),
      ),
    );
  }
}
