import 'analytics_service.dart';

class EventTracker {
  final AnalyticsService analytics;

  EventTracker(this.analytics);

  Future<void> track(String event, {Map<String, dynamic>? params}) async {
    await analytics.logEvent(event, params: params);
  }
}
