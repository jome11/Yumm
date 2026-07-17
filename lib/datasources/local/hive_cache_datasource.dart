import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart' as hivedb;

import 'package:yumm/models/hive_model.dart';
import 'package:yumm/models/insight_model.dart';
import 'package:yumm/models/overview_stats_model.dart';

class HiveCacheDatasource {
  static const _boxName = 'yumm_dashboard_cache';

  static const _kOverviewStats = 'overview_stats';
  static const _kHives = 'hives';
  static const _kInsights = 'insights';

  static Future<void> openBox() async {
    await hivedb.Hive.openBox<String>(_boxName);
  }

  hivedb.Box<String> get _box => hivedb.Hive.box<String>(_boxName);

  Future<void> cacheOverviewStats(OverviewStatsModel stats) async {
    await _box.put(_kOverviewStats, jsonEncode(stats.toJson()));
  }

  OverviewStatsModel? getCachedOverviewStats() {
    final raw = _box.get(_kOverviewStats);
    if (raw == null) return null;
    return OverviewStatsModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> cacheHives(List<HiveModel> hives) async {
    final encoded = jsonEncode(hives.map((h) => h.toJson()).toList());
    await _box.put(_kHives, encoded);
  }

  List<HiveModel>? getCachedHives() {
    final raw = _box.get(_kHives);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => HiveModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> cacheInsights(List<InsightModel> insights) async {
    final encoded = jsonEncode(insights.map((i) => i.toJson()).toList());
    await _box.put(_kInsights, encoded);
  }

  List<InsightModel>? getCachedInsights() {
    final raw = _box.get(_kInsights);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => InsightModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
