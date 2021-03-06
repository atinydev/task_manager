class Tags {
  final List<String> stringTags;

  const Tags(this.stringTags);

  String toJoinByComma() {
    return stringTags.join(", ");
  }
}

extension ToTags on String {
  Tags toTags() {
    return Tags(split(',').map((e) => e.trim()).toList());
  }
}

Tags toTags(String value) {
  return Tags(value.split(',').map((e) => e.trim()).toList());
}
