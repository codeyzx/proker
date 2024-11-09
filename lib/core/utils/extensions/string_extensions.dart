extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String limitText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }

    List<String> words = text.split(' ');
    String truncatedText = '';

    for (String word in words) {
      if ((truncatedText + word).length <= maxLength) {
        truncatedText += (truncatedText.isEmpty ? '' : ' ') + word;
      } else {
        break;
      }
    }

    return truncatedText.trim();
  }
}
