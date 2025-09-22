import 'dart:io';


class HandBrakeCliService {
  final String executablePath;
  static const List<String> audioCodecs = [
    'mp3',
    'opus',
    'vorbis',
    'av_aac',
  ];
  static List<String>? _cachedVideoCodecs;
  static bool _fetching = false;
  static Future<List<String>>? _pendingFetch;

  HandBrakeCliService({this.executablePath = 'HandBrakeCLI'});

  /// Builds a HandBrakeCLI command with the given parameters.
  List<String> buildCommand({
    required String input,
    required String output,
    List<String> extraArgs = const [],
  }) {
    return [
      executablePath,
      '-i', input,
      '-o', output,
      ...extraArgs,
    ];
  }

  Future<List<String>> getVideoCodecs() async {
    if (_cachedVideoCodecs != null) {
      return _cachedVideoCodecs!;
    }
    if (_fetching && _pendingFetch != null) {
      return _pendingFetch!;
    }
    _fetching = true;
    _pendingFetch = _getVideoCodecsInternal();
    final codecs = await _pendingFetch!;
    _cachedVideoCodecs = codecs;
    _fetching = false;
    return codecs;
  }

  Future<List<String>> _getVideoCodecsInternal() async {
    final result = await Process.run(executablePath, ['--help']);
    if (result.exitCode != 0) {
      throw Exception('Failed to run HandBrakeCLI: ${result.stderr}');
    }
    final output = result.stdout as String;

    // Parse Video Encoders
    final videoCodecs = <String>[];
    final videoSection = RegExp(r'Select video encoder:\n([\s\S]*?)\n\s{0,}-')
        .firstMatch(output)
        ?.group(1);
    if (videoSection != null) {
      for (final line in videoSection.split('\n')) {
        final codec = line.trim();
        if (codec.isNotEmpty) videoCodecs.add(codec);
      }
    }
    return videoCodecs;
  }

  Future<Process> run({
    required String input,
    required String output,
    List<String> extraArgs = const [],
  }) {
    final args = buildCommand(input: input, output: output, extraArgs: extraArgs).skip(1).toList();
    return Process.start(executablePath, args);
  }
}
