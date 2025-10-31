import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/status_controller.dart';
import '../widgets/status_tile.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<StatusController>(context);
    final saved = controller.saved;

    if (saved.isEmpty) return const Center(child: Text('No saved statuses yet.'));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: saved.length,
        itemBuilder: (context, idx) {
          final model = saved[idx];
          final file = File(model.path);
          return StatusTile(
            file: file,
            isVideo: model.isVideo,
            onTap: () {
              Navigator.pushNamed(context, '/preview', arguments: {'file': file.path, 'isVideo': model.isVideo, 'model': model});
            },
            onLongPress: () async {
              // allow delete or pin
              showModalBottomSheet(context: context, builder: (_) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text('Delete'),
                      onTap: () async {
                        await controller.deleteSaved(model);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(model.pinned ? Icons.push_pin : Icons.push_pin_outlined),
                      title: Text(model.pinned ? 'Unpin' : 'Pin'),
                      onTap: () async {
                        await controller.togglePin(model);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
            },
          );
        },
      ),
    );
  }
}