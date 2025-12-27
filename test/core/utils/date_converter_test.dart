import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_new/core/utils/date_converter.dart';

void main() {
  test(': should be return ---- Aug 10 -------', () {
    var result = DateConverter.changeDtToDateTime(1660127867);
    expect(result, 'Aug 10');
  });
}
