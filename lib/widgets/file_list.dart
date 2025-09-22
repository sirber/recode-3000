import 'package:flutter/material.dart';
import 'package:recode3000/models/source.dart';

class FileListCard extends StatelessWidget {
  final List<SourceDTO> files;
  final void Function() onAddFiles;
  final void Function(int) onRemoveFile;

  const FileListCard({
    super.key,
    required this.files,
    required this.onAddFiles,
    required this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Files to recode',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Add files',
                onPressed: onAddFiles,
              ),
            ],
          ),
          Expanded(
            child: files.isEmpty
                ? const Center(
                    child: Text(
                      'Drag and drop files here or click +',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                : ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, idx) => ListTile(
                      title: Text(files[idx].filename),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => onRemoveFile(idx),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
