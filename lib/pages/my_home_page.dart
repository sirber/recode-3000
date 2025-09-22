import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:recode3000/models/source.dart';
import 'package:recode3000/services/handbrake_cli.dart';
import 'package:recode3000/widgets/video_codec.dart';
import 'package:recode3000/widgets/audio_codec.dart';
import 'package:recode3000/widgets/file_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recode 3000',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Recode 3000'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _videoBitrate = 1000;
  int _audioBitrate = 128;
  final List<SourceDTO> _files = [];
  final HandBrakeCliService _cli = HandBrakeCliService();


  List<String> _videoCodecs = [];
  String? _selectedVideoCodec;

  // Audio codecs are now static
  final List<String> _audioCodecs = HandBrakeCliService.audioCodecs;
  String? _selectedAudioCodec;

  bool _loadingCodecs = false;

  @override
  void initState() {
  super.initState();
  _fetchVideoCodecs();
  }

  Future<void> _fetchVideoCodecs() async {
    setState(() => _loadingCodecs = true);
    try {
      final videos = await _cli.getVideoCodecs();
      setState(() {
        _videoCodecs = videos;
        _selectedVideoCodec = videos.isNotEmpty ? videos.first : null;
        _selectedAudioCodec = _audioCodecs.isNotEmpty ? _audioCodecs.first : null;
      });
    } catch (e) {
      debugPrint('Error fetching video codecs: $e');
      setState(() {
        _videoCodecs = [];
        _selectedVideoCodec = null;
        _selectedAudioCodec = _audioCodecs.isNotEmpty ? _audioCodecs.first : null;
      });
    } finally {
      setState(() => _loadingCodecs = false);
    }
  }

  void _addFiles(List<String> paths) {
    setState(() {
      _files.addAll(paths.map((p) => SourceDTO(p)));
    });
  }

  void _removeFile(int index) {
    setState(() {
      _files.removeAt(index);
    });
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      _addFiles(result.paths.whereType<String>().toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // File list + drag-drop
          Expanded(
            flex: 2,
            child: DropTarget(
              onDragDone: (details) {
                final paths = details.files.map((f) => f.path).toList();
                _addFiles(paths);
              },
              child: FileListCard(
                files: _files,
                onAddFiles: _pickFiles,
                onRemoveFile: _removeFile,
              ),
            ),
          ),
          // Codec dropdowns (full width)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: VideoCodecCard(
                      codecs: _videoCodecs,
                      selectedCodec: _selectedVideoCodec,
                      loading: _loadingCodecs,
                      onChanged: (value) {
                        setState(() {
                          _selectedVideoCodec = value;
                        });
                      },
                      bitrate: _videoBitrate,
                      onBitrateChanged: (value) {
                        setState(() {
                          _videoBitrate = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AudioCodecCard(
                      codecs: _audioCodecs,
                      selectedCodec: _selectedAudioCodec,
                      loading: _loadingCodecs,
                      onChanged: (value) {
                        setState(() {
                          _selectedAudioCodec = value;
                        });
                      },
                      bitrate: _audioBitrate,
                      onBitrateChanged: (value) {
                        setState(() {
                          _audioBitrate = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}