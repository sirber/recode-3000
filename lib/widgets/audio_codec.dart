import 'package:flutter/material.dart';

class AudioCodecCard extends StatelessWidget {
  final List<String> codecs;
  final String? selectedCodec;
  final bool loading;
  final ValueChanged<String?> onChanged;
  final int bitrate;
  final ValueChanged<int> onBitrateChanged;

  const AudioCodecCard({
    super.key,
    required this.codecs,
    required this.selectedCodec,
    required this.loading,
    required this.onChanged,
    required this.bitrate,
    required this.onBitrateChanged,
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
            const SizedBox(height: 16),
            const Text('Bitrate'),
            TextFormField(
              initialValue: bitrate.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (value) {
                final parsed = int.tryParse(value);
                if (parsed != null && parsed > 0) {
                  onBitrateChanged(parsed);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
