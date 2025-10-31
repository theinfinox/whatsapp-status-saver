import 'dart:io';
import 'package:flutter/material.dart';

class StatusTile extends StatelessWidget {
  final File file;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final bool isVideo;

  const StatusTile({Key? key, required this.file, required this.onTap, this.onLongPress, this.isVideo = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Hero(
        tag: file.path,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(file, fit: BoxFit.cover),
              if (isVideo)
                const Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.play_circle_fill, size: 48, color: Colors.white70),
                ),
            ],
          ),
        ),
      ),
    );
  }
}