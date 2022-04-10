import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class DateNotifier extends StateNotifier<DateTime?> {
  DateNotifier() : super(null);

  void updateState(DateTime? date) {
    state = date;
  }

  void clear() {
    state = null;
  }
}

final dateProvider = StateNotifierProvider<DateNotifier, DateTime?>((ref) {
  return DateNotifier();
});

extension DateYYMMDD on DateTime {
  String toDateFormat() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }

  String toDateVisual() {
    final DateFormat formatter = DateFormat('E, MMM d, y');
    return formatter.format(this);
  }
}
