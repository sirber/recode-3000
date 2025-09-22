import 'dart:io';

class SourceDTO {
	final String path;
	SourceDTO(this.path);
	String get filename => path.split(Platform.pathSeparator).last;
}