import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

double? recalculatedTolerance(double? toleranceLevel) {
  // take the argument and return it reduced by 1
  if (toleranceLevel == null) {
    return null; // Return null if input is null
  }
  return toleranceLevel + 1; // Reduce the tolerance level by 1
}

int? is21OrOlder(DateTime? date) {
// Check if the date/time that the user picked is 21 years or older from the current date/time
  if (date == null) {
    return null; // Return null if input is null
  }
  final DateTime currentDate = DateTime.now();
  final DateTime twentyOneYearsAgo =
      DateTime(currentDate.year - 21, currentDate.month, currentDate.day);
  return date.isBefore(twentyOneYearsAgo)
      ? 1
      : 0; // Return 1 if 21 years or older, otherwise return 0
}

String totalDocsId(
  String uid,
  String drinkKey,
) {
  final safeKey = drinkKey
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
  return '${uid}_${safeKey}';
}

String formatProgressString(
  double totalMl,
  String goalMl,
) {
  if (totalMl < 0) totalMl = 0;
  final int t = totalMl.round();
  return '$t/$goalMl mL';
}

double calculateBac(
  double totalGrams,
  int weightKg,
  String sex,
  int timeSinceStart,
) {
  final hoursSinceStart = timeSinceStart / 3600000.0;

  if (weightKg <= 0) return 0.0;

  double r;
  final s = sex.toLowerCase();
  if (s == 'male') {
    r = 0.68;
  } else if (s == 'female') {
    r = 0.55;
  } else {
    r = 0.63;
  }

  const beta = 0.015;

  double bac =
      (totalGrams / (r * (weightKg * 1000))) * 100 - (beta * hoursSinceStart);

  return bac > 0 ? bac : 0.0;
}

int currentTimeMs() {
  return DateTime.now().millisecondsSinceEpoch;
}

int? timeSinceLastDrinkMs(int? lastDrinkTimestampMs) {
  if (lastDrinkTimestampMs == null || lastDrinkTimestampMs <= 0) {
    return null; // FlutterFlow will treat this as "no value"
  }

  final nowMs = DateTime.now().millisecondsSinceEpoch;

  int diffMs = nowMs - lastDrinkTimestampMs;

  if (diffMs < 0) {
    diffMs = 0; // Should never be negative, but safe guard
  }

  return diffMs;
}

String? timeSinceLastDrinkFormatted(int? lastDrinkTimestampMs) {
// If no drink recorded yet
  // If no timestamp exists → return null
  if (lastDrinkTimestampMs == null || lastDrinkTimestampMs <= 0) {
    return '00:00:00';
  }

  // Current time in ms
  final nowMs = DateTime.now().millisecondsSinceEpoch;

  // Difference in ms
  int diffMs = nowMs - lastDrinkTimestampMs;
  if (diffMs < 0) diffMs = 0;

  // Convert to Duration
  final d = Duration(milliseconds: diffMs);

  // Format helper
  String two(int v) => v.toString().padLeft(2, '0');

  final hours = two(d.inHours);
  final minutes = two(d.inMinutes.remainder(60));
  final seconds = two(d.inSeconds.remainder(60));

  return '$hours:$minutes:$seconds';
}

String? timeUntilSoberFormatted(double? currentBAC) {
// If BAC is not known or already 0, no countdown needed
  if (currentBAC == null || currentBAC <= 0.0) {
    return '00:00:00';
  }

  const double eliminationRatePerHour = 0.015;

  // Hours until BAC hits 0
  double hoursRemaining = currentBAC / eliminationRatePerHour;

  if (hoursRemaining <= 0) {
    return null;
  }

  // Convert to whole seconds for display
  int totalSeconds = (hoursRemaining * 3600).round();

  final d = Duration(seconds: totalSeconds);

  String two(int v) => v.toString().padLeft(2, '0');

  final hours = two(d.inHours);
  final minutes = two(d.inMinutes.remainder(60));
  final seconds = two(d.inSeconds.remainder(60));

  return '$hours:$minutes:$seconds';
}

int? lbsToKg(int? lbs) {
  if (lbs == null) return null;
  // 1 lb = 0.45359237 kg
  double kgDecimal = lbs * 0.45359237;
  return kgDecimal.toInt();
}

int? elapseSinceFirstDrinkMs(int? firstDrinkTimestampMs) {
  if (firstDrinkTimestampMs == null || firstDrinkTimestampMs <= 0) {
    return 0;
  }

  final nowMs = DateTime.now().millisecondsSinceEpoch;
  int diffMs = nowMs - firstDrinkTimestampMs;

  if (diffMs < 0) {
    diffMs = 0;
  }

  return diffMs;
}

double progressRatio(
  double totalMl,
  String goalMl,
) {
  final parsed = double.tryParse(goalMl);
  if (parsed == null || parsed <= 0) {
    return 0.0; // invalid input â prevent crashes
  }

  final goal = parsed;

  double ratio = totalMl / goal;

  // Clamp to 0.0â1.0
  if (ratio < 0.0) ratio = 0.0;
  if (ratio > 1.0) ratio = 1.0;

  return ratio;
}

double? bacProgressRatio(
  double currentBAC,
  String bacLimit,
) {
  final limit = double.tryParse(bacLimit); // BAC limit for the bar
  if (limit == null || limit <= 0) return 0.0;
  if (currentBAC == null || currentBAC <= 0) {
    return 0.0;
  }

  final ratio = currentBAC / limit;

  if (ratio >= 1.0) return 1.0;
  if (ratio <= 0.0) return 0.0;
  return ratio;
}

DateTime? oneHour(DateTime currentTime) {
  // get current time and return a time an hour later
  return currentTime.add(Duration(hours: 1));
}

List<DrinkPresetsRecord>? combineDrinkPresetLists(
  List<DrinkPresetsRecord>? a,
  List<DrinkPresetsRecord>? b,
) {
  final combinedList = [...?a, ...?b];
  combinedList.sort((x, y) => x.drinkName.compareTo(y.drinkName));
  return combinedList;
}

DrinkPresetsRecord? getDrinkPreset(
  List<DrinkPresetsRecord> presets,
  String name,
) {
  for (var preset in presets) {
    if (preset.drinkName == name) {
      return preset;
    }
  }
  return null;
}

List<String> getDrinkPresetListNames(List<DrinkPresetsRecord>? presets) {
  if (presets == null) return [];
  return presets.map((preset) => preset.drinkName).toList();
}

bool doesPresetExist(
  List<DrinkPresetsRecord>? presets,
  String name,
) {
  if (presets == null) return false;

  final target = name.toLowerCase();

  for (final p in presets) {
    if (p == null) continue;

    final presetName = p.drinkName?.toLowerCase();

    if (presetName != null && presetName == target) {
      return true;
    }
  }

  return false;
}

double convertToMl(
  double amount,
  String unit,
) {
  final u = unit.trim().toLowerCase();

  // direct mL
  if (u == 'ml' || u == 'milliliter' || u == 'milliliters') {
    return amount;
  }

  // ounces
  if (u == 'oz' || u == 'ounce' || u == 'ounces') {
    return amount * 29.5735;
  }

  // cups (US standard)
  if (u == 'cup' || u == 'cups') {
    return amount * 240.0;
  }

  // fallback, no change
  return amount;
}

String toLowerCase(String a) {
  return a.toLowerCase();
}

DateTime startOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

DateTime startOfWeek(DateTime date) {
  final d = DateTime(date.year, date.month, date.day);
  final weekday = d.weekday % 7; // Sunday = 0
  return d.subtract(Duration(days: weekday));
}

DateTime addDays(
  DateTime date,
  int days,
) {
  return date.add(Duration(days: days));
}

String formatDayLabel(DateTime date) {
  return DateFormat('EEE').format(date);
}

DateTime startOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

int daysInMonth(DateTime date) {
  final firstDayThisMonth = DateTime(date.year, date.month, 1);
  final firstDayNextMonth = DateTime(date.year, date.month + 1, 1);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}

String highestIntakeThisMonth(List<DailyLogsRecord> logs) {
  if (logs.isEmpty) {
    return 'No data';
  }

  DailyLogsRecord? best;

  for (final log in logs) {
    final current = log.totalMlConsumed ?? 0;
    if (best == null) {
      best = log;
    } else {
      final bestVal = best!.totalMlConsumed ?? 0;
      if (current > bestVal) {
        best = log;
      }
    }
  }

  if (best == null || best!.date == null) {
    return 'No data';
  }

  final date = best!.date!;
  final ml = (best!.totalMlConsumed ?? 0).round();
  final dateStr = DateFormat('MMMM d').format(date); // e.g. "June 12"

  return '$dateStr ($ml mL)';
}

DateTime startOfYear(DateTime date) {
  return DateTime(date.year, 1, 1);
}

String yearlyControlMessage(List<DailyLogsRecord> logs) {
  int safeCount = 0;

  for (var item in logs) {
    // If you use within_safe_limit instead, change this line
    if (item.safeDay == true) {
      safeCount++;
    }
  }

  return 'You stayed in control for $safeCount days this year 🍷';
}

String bestMonthThisYear(List<DailyLogsRecord> logs) {
  double _safeTotalMl(DailyLogsRecord log) => log.totalMlConsumed ?? 0.0;

  if (logs.isEmpty) {
    return 'No data yet';
  }

  // Sum total_ml_consumed per month (1–12)
  final Map<int, double> monthTotals = {};

  for (final log in logs) {
    final date = log.date;
    if (date == null) continue;

    final month = date.month; // 1..12
    final ml = _safeTotalMl(log);

    monthTotals[month] = (monthTotals[month] ?? 0) + ml;
  }

  if (monthTotals.isEmpty) {
    return 'No data yet';
  }

  // Find month with **lowest** total
  int bestMonth = monthTotals.keys.first;
  double bestTotal = monthTotals[bestMonth]!;

  monthTotals.forEach((m, total) {
    if (total < bestTotal) {
      bestMonth = m;
      bestTotal = total;
    }
  });

  // Convert month number → name
  final monthName = DateFormat('MMMM').format(DateTime(2000, bestMonth, 1));

  // Round mL so it looks nice
  final roundedMl = bestTotal.round();

  return '$monthName ($roundedMl mL)';
}

String formatYearLabel(DateTime date) {
  return DateFormat('y').format(date); // e.g. 2025
}

String formatWeekLabel(DateTime weekStart) {
  final start = weekStart;
  final end = weekStart.add(const Duration(days: 6));

  final startFmt = DateFormat('MMM d').format(start);
  final endFmt = DateFormat('MMM d').format(end);

  // Example: "Dec 8 – Dec 14"
  return '$startFmt – $endFmt';
}

List<String> weekDayLabels(DateTime weekStart) {
  // Normalise to midnight so we don't get weird off-by-one issues
  final start = DateTime(weekStart.year, weekStart.month, weekStart.day);

  final labels = <String>[];

  for (var i = 0; i < 7; i++) {
    final d = start.add(Duration(days: i));
    // Example: "Nov 30"
    labels.add(DateFormat('MMM d').format(d));
  }

  return labels;
}

int? ouncesToMl(double? ounces) {
  if (ounces == null || ounces == 0) {
    return 0;
  }

  return (ounces * 30).toInt();
}

int? cupsToMl(double? cups) {
  if (cups == null || cups == 0) {
    return 0;
  }
  return (cups * 236.588).toInt();
}

String? feetAndInches(
  int? heightFeet,
  int? heightInches,
) {
  // I want the function to return a string in the format of how you display feet and inches in the Imperial system, e.g., 5'9"
  if (heightFeet == null || heightInches == null) {
    return "0"; // Return null if any input is null
  }
  return '${heightFeet}\'${heightInches}\"'; // Format the string as feet and inches
}

String? bacProgressLabel(
  double? currentBAC,
  String limit,
) {
  final bac = (currentBAC == null || currentBAC < 0) ? 0.0 : currentBAC;

  // Clamp to a reasonable display range if desired
  final clampedBAC = bac.clamp(0.0, 0.999);

  // Always show 3 decimal places (e.g., 0.021)
  return clampedBAC.toStringAsFixed(3);
}

double totalIntakeThisMonth(List<DailyDrinkLogRecord> logs) {
  final now = DateTime.now();
  final monthStart = DateTime(now.year, now.month);
  final nextMonthStart = DateTime(
    now.month == 12 ? now.year + 1 : now.year,
    now.month == 12 ? 1 : now.month + 1,
  );

  double total = 0;

  for (final item in logs) {
    final day = item.dayStart;
    if (day == null) continue;

    if (day.isAtSameMomentAs(monthStart) ||
        (day.isAfter(monthStart) && day.isBefore(nextMonthStart))) {
      total += item.totalMl ?? 0;
    }
  }

  return total;
}

List<double> weeklyTotalsForChart(
  List<DailyDrinkLogRecord> logs,
  DateTime weekStart,
) {
  // Normalise weekStart to midnight
  final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
  final end = start.add(const Duration(days: 7));

  // One slot per day: Sun..Sat (or whatever your weekStart is)
  final totals = List<double>.filled(7, 0.0);

  for (final log in logs) {
    final dt = log.dayStart;
    if (dt == null) continue;

    final day = DateTime(dt.year, dt.month, dt.day);

    // Only include logs inside this week window
    if (day.isBefore(start) || !day.isBefore(end)) continue;

    final index = day.difference(start).inDays;
    if (index < 0 || index >= 7) continue;

    // Use the field we've been saving from Golden Path
    final ml = log.totalMl ?? 0.0;

    totals[index] += ml;
  }

  return totals;
}

int toInt(double drinkSize) {
  if (drinkSize == null || drinkSize == 0) {
    return 0;
  }
  return drinkSize.toInt();
}

int? drinkSizeStringToInt(String drinkSize) {
  if (drinkSize == null || drinkSize.isEmpty) return 0;
  int? drinkSizeToMlInt(String? drinkSize) {
    if (drinkSize == null || drinkSize.isEmpty) return 0;

    final input = drinkSize.trim().toLowerCase();

    // Match numeric value and unit (e.g., 750ml, 12oz)
    final match = RegExp(r'^([\d.]+)(ml|oz)$').firstMatch(input);
    if (match == null) return 0;

    final value = double.tryParse(match.group(1)!);
    final unit = match.group(2);

    if (value == null) return 0;

    double mlValue;
    if (unit == 'ml') {
      mlValue = value;
    } else {
      // oz → mL
      mlValue = value * 29.5735;
    }

    return mlValue.round(); // Integer result
  }
}

int? stringToInt(String? numString) {
  // convert string to int
  if (numString == null) {
    return null;
  }
  try {
    return int.parse(numString);
  } catch (e) {
    return null;
  }
}

List<String> monthDayLabels(DateTime currentMonthStart) {
  final start = DateTime(currentMonthStart.year, currentMonthStart.month, 1);
  final nextMonthStart = DateTime(
    start.month == 12 ? start.year + 1 : start.year,
    start.month == 12 ? 1 : start.month + 1,
    1,
  );

  final labels = <String>[];
  for (var d = start;
      d.isBefore(nextMonthStart);
      d = d.add(const Duration(days: 1))) {
    labels.add(d.day.toString()); // "1", "2", ...
  }
  return labels;
}

List<double> monthDailyMlValues(
  DateTime currentMonthStart,
  List<DailyDrinkLogRecord> logs,
) {
  final start = DateTime(currentMonthStart.year, currentMonthStart.month, 1);
  final nextMonthStart = DateTime(
    start.month == 12 ? start.year + 1 : start.year,
    start.month == 12 ? 1 : start.month + 1,
    1,
  );

  // Map: day-of-month -> totalMl
  final mlByDay = <int, double>{};
  for (final log in logs) {
    final ds = log.dayStart;
    if (ds == null) continue;

    // Only accept logs that fall in the selected month
    if (ds.isBefore(start) || !ds.isBefore(nextMonthStart)) continue;

    mlByDay[ds.day] = (log.totalMl ?? 0.0).toDouble();
  }

  // Build aligned list (same length as labels)
  final values = <double>[];
  for (var d = start;
      d.isBefore(nextMonthStart);
      d = d.add(const Duration(days: 1))) {
    values.add(mlByDay[d.day] ?? 0.0);
  }
  return values;
}

DateTime nextMonthStart(DateTime currentMonthStart) {
  final y = currentMonthStart.year;
  final m = currentMonthStart.month;
  return DateTime(m == 12 ? y + 1 : y, m == 12 ? 1 : m + 1, 1);
}

DateTime prevMonthStart(DateTime currentMonthStart) {
  final y = currentMonthStart.year;
  final m = currentMonthStart.month;
  return DateTime(m == 1 ? y - 1 : y, m == 1 ? 12 : m - 1, 1);
}

List<String> yearMonthLabels() {
  return List.generate(12, (i) => '${i + 1}');
}

List<double> yearMonthlyMlTotals(
  DateTime currentYearStart,
  List<DailyDrinkLogRecord> logs,
) {
  final year = currentYearStart.year;
  final yearStart = DateTime(year, 1, 1);
  final nextYearStart = DateTime(year + 1, 1, 1);

  // month index 1..12 -> total ml
  final totalsByMonth = List<double>.filled(12, 0.0);

  for (final log in logs) {
    final ds = log.dayStart;
    if (ds == null) continue;

    // Only include logs within the target year
    if (ds.isBefore(yearStart) || !ds.isBefore(nextYearStart)) continue;

    final monthIndex = ds.month - 1; // 0..11
    totalsByMonth[monthIndex] += (log.totalMl ?? 0.0).toDouble();
  }

  return totalsByMonth;
}

DateTime nextYearStart(DateTime currentYearStart) {
  return DateTime(currentYearStart.year + 1, 1, 1);
}

DateTime prevYearStart(DateTime currentYearStart) {
  return DateTime(currentYearStart.year - 1, 1, 1);
}

DateTime nextWeekStart(DateTime currentWeekStart) {
// Assumes currentWeekStart is already normalized to the start of a week
  // (e.g., Monday at 00:00 in local time).
  final start = DateTime(
    currentWeekStart.year,
    currentWeekStart.month,
    currentWeekStart.day,
  );
  return start.add(const Duration(days: 7));
}

List<String> offersToDropdownOptions(List<double> offersJson) {
  final offers = (offersJson is List) ? offersJson : const [];
  final out = <String>[];

  for (final o in offers) {
    if (o is! Map) continue;

    final price = o['price'];
    final currency = (o['currency'] ?? 'USD').toString();
    final merchant = (o['merchant'] ?? o['seller'] ?? 'Offer').toString();

    double? p;
    if (price is num) p = price.toDouble();
    if (price is String) p = double.tryParse(price);

    if (p == null) continue;

    out.add('$merchant — ${p.toStringAsFixed(2)} $currency');
  }

  // Remove duplicates + keep order
  final seen = <String>{};
  return out.where((s) => seen.add(s)).toList();
}

double? stringToDouble(String? price) {
  // convert string to double
  if (price == null) return null; // Return null if input is null
  try {
    return double.tryParse(price); // Attempt to parse the string to double
  } catch (e) {
    return null; // Return null if parsing fails
  }
}

List<double> weeklyCostSeries(
  DateTime weekStart,
  List<DailyDrinkLogRecord> logs,
) {
// Normalize weekStart to local midnight to avoid time drift.
  final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
  final end = start.add(const Duration(days: 7));

  // Build a map keyed by yyyyMMdd for fast lookup
  String key(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}${d.month.toString().padLeft(2, '0')}${d.day.toString().padLeft(2, '0')}';

  final Map<String, double> costByDay = {};

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);
    if (d.isBefore(start) || !d.isBefore(end)) continue;

    final c = (item.totalCost ?? 0).toDouble();
    costByDay[key(d)] = c;
  }

  // Output 7 values (0 if missing)
  final List<double> out = [];
  for (int i = 0; i < 7; i++) {
    final d = start.add(Duration(days: i));
    out.add(costByDay[key(d)] ?? 0.0);
  }

  return out;
}

double weeklyTotalCost(List<double> series) {
  double sum = 0.0;
  for (final v in series) {
    sum += v;
  }
  return sum;
}

double weeklyTotalMl(List<DailyDrinkLogRecord> logs) {
  double total = 0.0;

  for (final item in logs) {
    final ml = item.totalMl;
    if (ml != null && ml > 0) {
      total += ml.toDouble();
    }
  }

  return total;
}

List<double> monthlyCostSeries(
  DateTime currentMonthStart,
  List<DailyDrinkLogRecord> logs,
) {
  final start = DateTime(currentMonthStart.year, currentMonthStart.month, 1);
  final end = DateTime(start.year, start.month + 1, 1);
  final daysInMonth = end.difference(start).inDays;

  // Map day-of-month (1..N) -> cost
  final Map<int, double> costByDay = {};

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);
    if (d.isBefore(start) || !d.isBefore(end)) continue;

    final dayNum = d.day; // 1..daysInMonth
    costByDay[dayNum] = (item.totalCost ?? 0).toDouble();
  }

  final out = <double>[];
  for (int day = 1; day <= daysInMonth; day++) {
    out.add(costByDay[day] ?? 0.0);
  }

  return out;
}

List<double> monthlyMlSeries(
  DateTime currentMonthStart,
  List<DailyDrinkLogRecord> logs,
) {
  final start = DateTime(currentMonthStart.year, currentMonthStart.month, 1);
  final end = DateTime(start.year, start.month + 1, 1);
  final daysInMonth = end.difference(start).inDays;

  final Map<int, double> mlByDay = {};

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);
    if (d.isBefore(start) || !d.isBefore(end)) continue;

    mlByDay[d.day] = (item.totalMl ?? 0).toDouble();
  }

  final out = <double>[];
  for (int day = 1; day <= daysInMonth; day++) {
    out.add(mlByDay[day] ?? 0.0);
  }

  return out;
}

double monthlyTotalCost(
  List<DailyDrinkLogRecord> logs,
  DateTime currentMonthStart,
) {
  final start = DateTime(currentMonthStart.year, currentMonthStart.month, 1);
  final end = DateTime(start.year, start.month + 1, 1);

  double total = 0.0;

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);

    if (d.isBefore(start) || !d.isBefore(end)) continue;

    final cost = (item.totalCost ?? 0).toDouble();
    if (cost > 0) {
      total += cost;
    }
  }

  return total;
}

double monthlyTotalMl(
  List<DailyDrinkLogRecord> logs,
  DateTime currentMonthStart,
) {
  final start = DateTime(currentMonthStart.year, currentMonthStart.month, 1);
  final end = DateTime(start.year, start.month + 1, 1);

  double total = 0.0;

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);

    if (d.isBefore(start) || !d.isBefore(end)) continue;

    final ml = (item.totalMl ?? 0).toDouble();
    if (ml > 0) {
      total += ml;
    }
  }

  return total;
}

List<double> yearlyCostSeries(
  DateTime currentYearStart,
  List<DailyDrinkLogRecord> logs,
) {
  final start = DateTime(currentYearStart.year, 1, 1);
  final end = DateTime(currentYearStart.year + 1, 1, 1);

  final out = List<double>.filled(12, 0.0);

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);
    if (d.isBefore(start) || !d.isBefore(end)) continue;

    final monthIndex = d.month - 1; // 0..11
    final c = (item.totalCost ?? 0).toDouble();
    out[monthIndex] += c;
  }

  return out;
}

List<double> yearlyMlSeries(
  DateTime currentYearStart,
  List<DailyDrinkLogRecord> logs,
) {
  final start = DateTime(currentYearStart.year, 1, 1);
  final end = DateTime(currentYearStart.year + 1, 1, 1);

  final out = List<double>.filled(12, 0.0);

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);
    if (d.isBefore(start) || !d.isBefore(end)) continue;

    final monthIndex = d.month - 1;
    final ml = (item.totalMl ?? 0).toDouble();
    out[monthIndex] += ml;
  }

  return out;
}

double yearlyTotalCost(
  List<DailyDrinkLogRecord> logs,
  DateTime currentYearStart,
) {
  double total = 0.0;

  for (final item in logs) {
    final day = item.dayStart;
    final cost = item.totalCost;

    if (day != null &&
        cost != null &&
        cost > 0 &&
        !day.isBefore(currentYearStart)) {
      total += cost.toDouble();
    }
  }

  return total;
}

double yearlyTotalMl(
  List<DailyDrinkLogRecord> logs,
  DateTime currentYearStart,
) {
  final start = DateTime(currentYearStart.year, 1, 1);
  final end = DateTime(start.year + 1, 1, 1);

  double total = 0.0;

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);

    if (d.isBefore(start) || !d.isBefore(end)) continue;

    final ml = (item.totalMl ?? 0).toDouble();
    total += ml;
  }

  return total;
}

String? doubleToString(double? price) {
  // convert double to string
  return price
      ?.toStringAsFixed(2); // Convert double to string with 2 decimal places
}

String? ensureGuestId(String? existing) {
  if (existing != null && existing.trim().isNotEmpty) return existing.trim();
  // Pseudo-unique enough for a device-local guest id
  return DateTime.now().millisecondsSinceEpoch.toString();
}

List<String> convertListOfNumsToStrings(List<double> numbers) {
  // Convert a list of numbers to a list of strings
  return numbers
      .where((number) => number != 0)
      .map((number) => number.toString())
      .toList();
}

int doubleToInt(double number) {
  return number.toInt();
}

DateTime fourteenHoursAgo() {
  return DateTime.now().subtract(const Duration(hours: 14));
}

double? intToDouble(int? num) {
  // convert integer to double
  return num?.toDouble();
}

String? intToString(int? num) {
  // convert integer to string
  return num?.toString();
}

double randomChance() {
  // generate a random number between 0 and 1
  return math.Random().nextDouble();
}

String? formatDayHeader(DateTime? dayStart) {
  if (dayStart == null) return '';

  return DateFormat('MMMM d, yyyy').format(dayStart);
}

String? monthNameFromTimestamp(DateTime? monthStart) {
  if (monthStart == null) return '';

  return DateFormat('MMMM').format(monthStart);
}

double? sumTwoNumbers(
  double num1,
  double num2,
) {
  return num1 + num2;
}

String getTodayDayKey() {
  final now = DateTime.now();
  final y = now.year.toString().padLeft(4, '0');
  final m = now.month.toString().padLeft(2, '0');
  final d = now.day.toString().padLeft(2, '0');
  return '$y$m$d';
}

double decrement(double num) {
  return num--;
}

int beerCalories12oz(
  double? abv,
  double? ounces,
) {
  if (abv == null || abv <= 0 || ounces == null) return 0;

  final calories = 2.5 * abv * ounces;

  return calories.round();
}

double mlToOunces(double mL) {
  return mL / 29.574;
}

double cupsToOunces(double cups) {
  return cups * 8;
}

double ouncesToCups(double ounces) {
  return ounces / 8;
}

List<double> weeklyCaloriesForChart(
  List<DailyDrinkLogRecord> logs,
  DateTime weekStart,
) {
  final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
  final end = start.add(const Duration(days: 7));

  // One slot per day
  final totals = List<double>.filled(7, 0.0);

  for (final log in logs) {
    final dt = log.dayStart;
    if (dt == null) continue;

    final day = DateTime(dt.year, dt.month, dt.day);

    // Only include logs inside this week window
    if (day.isBefore(start) || !day.isBefore(end)) continue;

    final index = day.difference(start).inDays;
    if (index < 0 || index >= 7) continue;

    // Use dailyCalories instead of totalMl
    final calories = (log.dailyCalories ?? 0).toDouble();

    totals[index] += calories;
  }

  return totals;
}

double weeklyTotalCalories(List<DailyDrinkLogRecord> logs) {
  double total = 0.0;

  for (final item in logs) {
    final calories = item.dailyCalories;
    if (calories != null && calories > 0) {
      total += calories.toDouble();
    }
  }

  return total;
}

List<double> monthlyCaloriesSeries(
  DateTime currentMonthStart,
  List<DailyDrinkLogRecord> logs,
) {
  final start = DateTime(currentMonthStart.year, currentMonthStart.month, 1);
  final end = DateTime(start.year, start.month + 1, 1);
  final daysInMonth = end.difference(start).inDays;

  final Map<int, double> caloriesByDay = {};

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);
    if (d.isBefore(start) || !d.isBefore(end)) continue;

    caloriesByDay[d.day] = (item.dailyCalories ?? 0).toDouble();
  }

  final out = <double>[];
  for (int day = 1; day <= daysInMonth; day++) {
    out.add(caloriesByDay[day] ?? 0.0);
  }

  return out;
}

double monthlyTotalCalories(
  List<DailyDrinkLogRecord> logs,
  DateTime currentMonthStart,
) {
  final start = DateTime(
    currentMonthStart.year,
    currentMonthStart.month,
    1,
  );

  final end = DateTime(
    start.year,
    start.month + 1,
    1,
  );

  double total = 0.0;

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);

    if (d.isBefore(start) || !d.isBefore(end)) continue;

    final calories = item.dailyCalories;
    if (calories != null && calories > 0) {
      total += calories.toDouble();
    }
  }

  return total;
}

List<double> monthlyDayXAxis(DateTime currentMonthStart) {
  final start = DateTime(currentMonthStart.year, currentMonthStart.month, 1);
  final end = DateTime(start.year, start.month + 1, 1);
  final daysInMonth = end.difference(start).inDays;

  final values = <double>[];
  for (int day = 1; day <= daysInMonth; day++) {
    values.add(day.toDouble());
  }

  return values;
}

List<double> yearlyCaloriesSeries(
  DateTime currentYearStart,
  List<DailyDrinkLogRecord> logs,
) {
  final start = DateTime(currentYearStart.year, 1, 1);
  final end = DateTime(start.year + 1, 1, 1);

  // Map month number (1..12) -> calories
  final Map<int, double> caloriesByMonth = {};

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);
    if (d.isBefore(start) || !d.isBefore(end)) continue;

    final monthNum = d.month;
    final calories = (item.dailyCalories ?? 0).toDouble();

    caloriesByMonth[monthNum] = (caloriesByMonth[monthNum] ?? 0.0) + calories;
  }

  final out = <double>[];
  for (int month = 1; month <= 12; month++) {
    out.add(caloriesByMonth[month] ?? 0.0);
  }

  return out;
}

double yearlyTotalCalories(
  DateTime currentYearStart,
  List<DailyDrinkLogRecord> logs,
) {
  final start = DateTime(currentYearStart.year, 1, 1);
  final end = DateTime(start.year + 1, 1, 1);

  double total = 0.0;

  for (final item in logs) {
    final ds = item.dayStart;
    if (ds == null) continue;

    final d = DateTime(ds.year, ds.month, ds.day);

    if (d.isBefore(start) || !d.isBefore(end)) continue;

    final calories = (item.dailyCalories ?? 0).toDouble();
    total += calories;
  }

  return total;
}

DateTime weekEnd(DateTime currentWeekStart) {
  return DateTime(
    currentWeekStart.year,
    currentWeekStart.month,
    currentWeekStart.day + 6,
  );
}

DateTime monthEnd(DateTime currentMonthStart) {
  return DateTime(
    currentMonthStart.year,
    currentMonthStart.month + 1,
    0,
  );
}

DateTime yearEnd(DateTime currentYearStart) {
  return DateTime(
    currentYearStart.year + 1,
    1,
    0,
  );
}

int soberDaysInPeriod(
  List<DailyDrinkLogRecord> logs,
  DateTime periodStart,
  DateTime periodEnd,
) {
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);

  // Prevent counting future days
  final effectiveEnd = periodEnd.isAfter(todayDate) ? todayDate : periodEnd;

  if (effectiveEnd.isBefore(periodStart)) {
    return 0;
  }

  final drinkingDays = <String>{};

  for (final log in logs) {
    final day = log.dayStart;
    final ml = log.totalMl;

    if (day != null &&
        ml != null &&
        ml > 0 &&
        !day.isBefore(periodStart) &&
        !day.isAfter(effectiveEnd)) {
      drinkingDays.add("${day.year}-${day.month}-${day.day}");
    }
  }

  final totalDays = effectiveEnd.difference(periodStart).inDays + 1;

  return totalDays - drinkingDays.length;
}

int soberStreakDays(List<DailyDrinkLogRecord> logs) {
  if (logs.isEmpty) return 0;

  final drinkingDays = <String>{};

  for (final log in logs) {
    final day = log.dayStart;
    final ml = log.totalMl;

    if (day != null && ml != null && ml > 0) {
      final normalized = DateTime(day.year, day.month, day.day);
      drinkingDays
          .add("${normalized.year}-${normalized.month}-${normalized.day}");
    }
  }

  int streak = 0;

  DateTime cursor = DateTime.now();
  cursor = DateTime(cursor.year, cursor.month, cursor.day);

  final earliestLog = logs
      .where((l) => l.dayStart != null)
      .map(
          (l) => DateTime(l.dayStart!.year, l.dayStart!.month, l.dayStart!.day))
      .reduce((a, b) => a.isBefore(b) ? a : b);

  while (!cursor.isBefore(earliestLog)) {
    final key = "${cursor.year}-${cursor.month}-${cursor.day}";

    if (drinkingDays.contains(key)) {
      break;
    }

    streak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }

  return streak;
}

int daysBetweenDates(
  DateTime createdTime,
  DateTime currentTime,
) {
  final createdDate = DateTime(
    createdTime.year,
    createdTime.month,
    createdTime.day,
  );

  final currentDate = DateTime(
    currentTime.year,
    currentTime.month,
    currentTime.day,
  );

  return currentDate.difference(createdDate).inDays;
}

String formatDrinkTimeStamp12h(DateTime? timestamp) {
  if (timestamp == null) return '';

  final month = timestamp.month.toString().padLeft(2, '0');
  final day = timestamp.day.toString().padLeft(2, '0');

  int hour = timestamp.hour;
  final minute = timestamp.minute.toString().padLeft(2, '0');

  final period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12;
  if (hour == 0) hour = 12;

  return '$month/$day $hour:$minute $period';
}

double calculateBacFromDrinks(
  List<DrinkTotalsRecord> docs,
  int weightKg,
  String sex,
) {
  if (weightKg <= 0) return 0.0;

  final now = DateTime.now();

  double r;
  final s = sex.toLowerCase();
  if (s == 'male') {
    r = 0.68;
  } else if (s == 'female') {
    r = 0.55;
  } else {
    r = 0.63;
  }

  const beta = 0.015;

  double totalBac = 0.0;

  for (final doc in docs) {
    final count = doc.count ?? 0;
    final sizeMl = doc.sizeMl;
    final abv = doc.abv;
    final timestamp = doc.createdAt;

    if (count <= 0 || sizeMl == null || abv == null || timestamp == null) {
      continue;
    }

    final hoursSinceDrink =
        now.difference(timestamp).inMilliseconds / 3600000.0;

    final gramsPerDrink = sizeMl * (abv / 100.0) * 0.789;

    final bacContribution = (gramsPerDrink / (r * (weightKg * 1000))) * 100;

    final decayed = bacContribution - (beta * hoursSinceDrink);

    if (decayed > 0) {
      totalBac += decayed * count;
    }
  }

  return totalBac;
}

List<DateTime> getDatesInMonth(String? monthKey) {
  if (monthKey == null || monthKey.length != 6) {
    return [];
  }

  int year = int.tryParse(monthKey.substring(0, 4)) ?? 0;
  int month = int.tryParse(monthKey.substring(4, 6)) ?? 0;

  if (year == 0 || month < 1 || month > 12) {
    return [];
  }

  // Get number of days using Dart's DateTime (cleaner than manual logic)
  int daysInMonth = DateTime(year, month + 1, 0).day;

  return List.generate(daysInMonth, (index) {
    return DateTime(year, month, index + 1);
  });
}

String getMonthName(String? monthKey) {
  if (monthKey == null || monthKey.length != 6) {
    return '';
  }

  int month = int.tryParse(monthKey.substring(4, 6)) ?? 0;

  const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  if (month < 1 || month > 12) {
    return '';
  }

  return monthNames[month - 1];
}

List<DateTime> getCalendarGrid(String? monthKey) {
  if (monthKey == null || monthKey.length != 6) {
    return [];
  }

  int year = int.tryParse(monthKey.substring(0, 4)) ?? 0;
  int month = int.tryParse(monthKey.substring(4, 6)) ?? 0;

  if (year == 0 || month < 1 || month > 12) {
    return [];
  }

  DateTime firstDay = DateTime(year, month, 1);
  int startOffset = firstDay.weekday % 7;

  int daysInMonth = DateTime(year, month + 1, 0).day;

  List<DateTime> calendar = [];

  // Placeholder cells
  for (int i = 0; i < startOffset; i++) {
    calendar.add(DateTime(1900, 1, 1));
  }

  // Real dates
  for (int i = 1; i <= daysInMonth; i++) {
    calendar.add(DateTime(year, month, i));
  }

  return calendar;
}

String getYearFromMonthKey(String? monthKey) {
  if (monthKey == null || monthKey.length != 6) {
    return '';
  }

  return monthKey.substring(0, 4);
}

String buildDateKey(
  String? year,
  String? month,
  String? day,
) {
  if (year == null || month == null || day == null) {
    return '';
  }

  String m = month.padLeft(2, '0');
  String d = day.padLeft(2, '0');

  return '$year$m$d';
}

String dateTimeToKey(DateTime date) {
  String year = date.year.toString();
  String month = date.month.toString().padLeft(2, '0');
  String day = date.day.toString().padLeft(2, '0');

  return '$year$month$day';
}

bool hasDrinkForDate(
  DateTime date,
  List<String> drinkKeys,
) {
  String key = date.year.toString() +
      date.month.toString().padLeft(2, '0') +
      date.day.toString().padLeft(2, '0');

  return drinkKeys.contains(key);
}

String formatMonthYear(DateTime date) {
  const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String monthName = monthNames[date.month - 1];
  return '$monthName, ${date.year}';
}
