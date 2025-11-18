import 'package:drift/drift.dart';
import 'package:drift/web.dart';

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    // Beri nama database 'db'. Drift akan mengelolanya
    // di IndexedDB atau local storage browser.
    return WebDatabase('db');
  });
}