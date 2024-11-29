class StringHelpers {
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }

  static String limitText(String text, int maxLength) {
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

  static String limitTextInitial(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }

    List<String> words = text.split(' ');
    String truncatedText = '';
    bool additionalWordAdded = false;

    for (int i = 0; i < words.length; i++) {
      String word = words[i];

      if ((truncatedText + (truncatedText.isEmpty ? '' : ' ') + word).length <=
          maxLength) {
        truncatedText += (truncatedText.isEmpty ? '' : ' ') + word;
      } else if (!additionalWordAdded &&
          (truncatedText + (truncatedText.isEmpty ? '' : ' ') + word[0])
                  .length <=
              maxLength) {
        truncatedText += (truncatedText.isEmpty ? '' : ' ') + word[0];
        additionalWordAdded = true;
        break;
      } else {
        break;
      }
    }

    return truncatedText.trim();
  }

  static String removeException(String input) {
    String keyword = "Exception: ";
    if (input.contains(keyword)) {
      return input.replaceFirst(keyword, '');
    }
    return input;
  }

  static String cleanHtml(String html) {
    String cleanedHtml = html.replaceAll('\r\n', '').replaceAll('\n', '');
    return cleanedHtml;
  }

  static List<dynamic> extractHtmlForGeneralGuide(String cleanedHtml) {
    // Split html string and get content between <h1> and </h1>
    if (!cleanedHtml.contains('<h1>FORMATTED</h1>')) {
      return [];
    }

    List<String> h1Sections = cleanedHtml.split("<h1>");
    if (h1Sections.isEmpty) {
      return [];
    }

    List<String> h1Content = h1Sections[1].split("</h1>");
    if (h1Content.isEmpty) {
      return [];
    }

    if (h1Content[0].isEmpty && h1Content[0] != 'FORMATTED') {
      return [];
    }

    List<String> sections = cleanedHtml.split("<hr>");

    var splittedSection = [];
    for (int i = 0; i < sections.length; i++) {
      var splittedContent = [];

      // Split html string and get content between <h3> and </h3>
      List<String> h3Sections = sections[i].split("<h3>");
      if (h3Sections.length > 1) {
        List<String> h3Content = h3Sections[1].split("</h3>");
        if (h3Content.length > 1) {
          splittedContent.add(h3Content[0]);
        }
      }

      // Split html string and get content between <p><strong> and </strong></p>
      List<String> pSections = sections[i].split("<p><strong>");
      if (pSections.length > 1) {
        List<String> pContent = pSections[1].split("</strong></p>");
        if (pContent.length > 1) {
          splittedContent.add(pContent[0]);
        }
      }

      // Split html string and get content between <p><span style="text-decoration: underline;"> and </span></p>
      List<String> pUnderlineSections =
          sections[i].split("<p><span style=\"text-decoration: underline;\">");
      if (pUnderlineSections.length > 1) {
        List<String> pUnderlineContent =
            pUnderlineSections[1].split("</span></p>");
        if (pUnderlineContent.length > 1) {
          splittedContent.add(pUnderlineContent[0]);
        }
      }

      // Split html string and get content between <p><em> and </em></p>
      List<String> pEmSections = sections[i].split("<p><em>");
      if (pEmSections.length > 1) {
        List<String> pEmContent = pEmSections[1].split("</em></p>");
        if (pEmContent.length > 1) {
          splittedContent.add(pEmContent[0]);
        }
      }

      splittedSection.add(splittedContent);
    }

    return splittedSection;
  }
}
