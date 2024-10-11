import 'dart:async'; // For Timer
import 'dart:math'; // For random selection of notifications
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // Import audio player package
import 'package:Puredrops/notification/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> notifications = [];
  bool hasNewNotification = false;
  Timer? notificationTimer; // Timer to manage periodic notifications
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance

  @override
  void initState() {
    super.initState();
    _generateHardCodedNotifications();
    _startNotificationLoop(); // Start the notification loop
  }

  // Generate hardcoded notifications
  void _generateHardCodedNotifications() {
    notifications = [
      NotificationModel(
          message: 'Water usage updated!',
          timestamp: DateTime.now().subtract(Duration(minutes: 5))),
      NotificationModel(
          message: 'Reminder: Track your water usage.',
          timestamp: DateTime.now().subtract(Duration(minutes: 10))),
      NotificationModel(
          message: 'Great job saving water!',
          timestamp: DateTime.now().subtract(Duration(minutes: 15))),
      NotificationModel(
          message: 'New tips available for saving water.',
          timestamp: DateTime.now().subtract(Duration(minutes: 20))),
    ];
  }

  // Start periodic notifications
  void _startNotificationLoop() {
    notificationTimer = Timer.periodic(
      Duration(seconds: 15), // Adjust the time interval as needed
      (timer) {
        _simulateNewNotification(); // Simulate new notification
      },
    );
  }

  // Simulate new notification
  void _simulateNewNotification() {
    int randomIndex = Random().nextInt(notifications.length);
    var newNotification = notifications[randomIndex];

    setState(() {
      hasNewNotification = true; // Indicate a new notification received
      notifications = [
        newNotification
      ]; // Replace with only the new notification
    });

    // Play the notification sound
    _playNotificationSound();
  }

  // Play sound when a new notification appears
  Future<void> _playNotificationSound() async {
    await _audioPlayer.play(AssetSource('notification_sound.mp3'));
  }

  @override
  void dispose() {
    notificationTimer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Water_Consumption_Feature.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        var notification = notifications[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          elevation: 4,
                          child: ListTile(
                            title: Text(notification.message),
                            subtitle: Text(
                                '${notification.timestamp.hour}:${notification.timestamp.minute.toString().padLeft(2, '0')}'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
