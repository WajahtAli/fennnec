// check if string is video
extension StringExtension on String {
  bool get isVideo =>
      contains(".mp4") ||
      contains(".MP4") ||
      contains(".mov") ||
      contains(".MOV") ||
      contains(".avi") ||
      contains(".AVI") ||
      contains(".mkv") ||
      contains(".MKV");
  bool get isNetworkUrl {
    var value = trim();

    while (value.startsWith('/http') || value.startsWith('/https')) {
      value = value.substring(1);
    }

    if (value.startsWith('http:/') && !value.startsWith('http://')) {
      value = value.replaceFirst('http:/', 'http://');
    }

    if (value.startsWith('https:/') && !value.startsWith('https://')) {
      value = value.replaceFirst('https:/', 'https://');
    }

    final uri = Uri.tryParse(value);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  bool get isImage =>
      contains(".jpg") ||
      contains(".JPG") ||
      contains(".jpeg") ||
      contains(".JPEG") ||
      contains(".png") ||
      contains(".PNG") ||
      contains(".gif") ||
      contains(".GIF");

  bool get isAudio =>
      contains(".mp3") ||
      contains(".MP3") ||
      contains(".wav") ||
      contains(".WAV") ||
      contains(".aac") ||
      contains(".AAC") ||
      contains(".m4a") ||
      contains(".M4A");

  bool get isVideoUrl => startsWith("http") && (isVideo || isImage || isAudio);

  bool get isVideoFile => isVideo && !isVideoUrl;

  bool get isImageUrl => isImage && startsWith("http");

  bool get isAudioUrl => isAudio && !isVideoUrl;

  bool get isUrl => Uri.tryParse(this) != null;
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  String makeSearchAble() {
    return toLowerCase().replaceAll(" ", "");
  }
}
