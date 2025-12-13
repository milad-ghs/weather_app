import 'package:intl/intl.dart';

class DateConverter {
  /// ورودی: رشته تاریخ به فرمت yyyy-MM-dd
  /// خروجی: رشته به فرمت dd MMM (مثلا 27 Nov)
  static String formatToDayMonth(String dateStr) {
    try {
      // تبدیل رشته به DateTime
      DateTime dateTime = DateTime.parse(dateStr);

      // فرمت روز + سه حرف اول ماه
      String formatted = DateFormat("dd MMM").format(dateTime);

      return formatted;
    } catch (e) {
      // اگر فرمت تاریخ اشتباه بود، خود رشته اصلی رو برگردون
      return dateStr;
    }
  }

  /// change dt to our dateFormat ---Jun 23--- for Example
  static String changeDtToDateTime(dt){
    final formatter = DateFormat.MMMd();
    var result = formatter.format(DateTime.fromMillisecondsSinceEpoch(
        dt * 1000,
        isUtc: true));

    return result;
  }

  /// change dt to our dateFormat ---5:55 AM/PM--- for Example
  static String changeDtToDateTimeHour(dt, timeZone){
    final formatter = DateFormat.jm();
    return formatter.format(
        DateTime.fromMillisecondsSinceEpoch(
            (dt * 1000) +
                timeZone * 1000,
            isUtc: true));
  }

}
