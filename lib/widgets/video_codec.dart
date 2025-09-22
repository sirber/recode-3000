import 'package:flutter/material.dart';

class VideoCodecCard extends StatelessWidget {
  final List<String> codecs;
  final String? selectedCodec;
  final bool loading;
  final ValueChanged<String?> onChanged;

  const VideoCodecCard({
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
        child: _VideoCodecCardContent(
          codecs: codecs,
          selectedCodec: selectedCodec,
          loading: loading,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _VideoCodecCardContent extends StatefulWidget {
  final List<String> codecs;
  final String? selectedCodec;
  final bool loading;
  final ValueChanged<String?> onChanged;

  const _VideoCodecCardContent({
    required this.codecs,
    required this.selectedCodec,
    required this.loading,
    required this.onChanged,
  });

  @override
  State<_VideoCodecCardContent> createState() => _VideoCodecCardContentState();
}

class _VideoCodecCardContentState extends State<_VideoCodecCardContent> {
  int _bitrate = 2048;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Video codec', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        widget.loading
            ? const CircularProgressIndicator()
            : widget.codecs.isEmpty
                ? const Text('No codecs available', style: TextStyle(color: Colors.red))
                : DropdownButton<String>(
                    value: widget.selectedCodec,
                    hint: const Text('Select video codec'),
                    isExpanded: true,
                    items: widget.codecs
                        .map((codec) => DropdownMenuItem(
                              value: codec,
                              child: Text(codec),
                            ))
                        .toList(),
                    onChanged: widget.onChanged,
                  ),
        const SizedBox(height: 16),
        const Text('Bitrate'),
        TextFormField(
          initialValue: _bitrate.toString(),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
          onChanged: (value) {
            final parsed = int.tryParse(value);
            if (parsed != null && parsed > 0) {
              setState(() {
                _bitrate = parsed;
              });
            }
          },
        ),
      ],
    );
  }
}
