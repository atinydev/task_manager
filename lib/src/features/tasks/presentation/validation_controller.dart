import 'package:flutter/material.dart';

import '../domain/tags.dart';

class ValidatorController {
  static final formKey = GlobalKey<FormState>();

  static String? checkStringNull(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Mandatory value";
    }
    return null;
  }

  static String? checkTags(String? value) {
    try {
      value?.toTags();
    } catch (e) {
      return "Write the tags separated by a comma: [tag1,tag2,...]";
    }
    return null;
  }
}
