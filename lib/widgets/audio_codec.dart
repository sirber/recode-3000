import 'package:flutter/material.dart';

class AudioCodecCard extends StatelessWidget {
  final List<String> codecs;
  final String? selectedCodec;
  final bool loading;
  final ValueChanged<String?> onChanged;

  const AudioCodecCard({
    super.key,
    required this.codecs,
    required this.selectedCodec,
    required this.loading,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Audio codec', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            loading
                ? const CircularProgressIndicator()
                : codecs.isEmpty
                    ? const Text('No codecs available', style: TextStyle(color: Colors.red))
                    : DropdownButton<String>(
                        value: selectedCodec,
                        hint: const Text('Select audio codec'),
                        isExpanded: true,
                        items: codecs
                            .map((codec) => DropdownMenuItem(
                                  value: codec,
                                  child: Text(codec),
                                ))
                            .toList(),
                        onChanged: onChanged,
                      ),
          ],
        ),
      ),
    );
  }
}
