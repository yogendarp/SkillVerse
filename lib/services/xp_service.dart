import 'package:cloud_firestore/cloud_firestore.dart';
import 'achievement_service.dart';
import 'notification_service.dart';

class XPService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addXP({
    required String userId,
    required int earnedXP,
  }) async {
    final userRef = _firestore.collection("users").doc(userId);

    final userDoc = await userRef.get();

    if (!userDoc.exists) return;

    final data = userDoc.data()!;

    final int currentXP = data["xp"] ?? 0;

    final int newXP = currentXP + earnedXP;

    final int newLevel = calculateLevel(newXP);

    final int oldLevel = data["level"] ?? 1;

    await userRef.update({
      "xp": newXP,
      "level": newLevel,
    });

    if (newLevel > oldLevel) {

      await NotificationService().createNotification(
        userId: userId,
        title: "Level Up! 🎉",
        message: "Congratulations! You've reached Level $newLevel.",
        type: "achievement",
      );

      await AchievementService().unlockAchievement(
        userId: userId,
        title: "Level $newLevel Reached",
        description: "Reached Level $newLevel by earning XP.",
        type: "level",
      );
    }
    if (newXP >= 100) {
      await AchievementService().unlockAchievement(
        userId: userId,
        title: "Beginner",
        description: "Earned your first 100 XP.",
        type: "xp",
      );
    }

    if(newXP >= 500) {
      await AchievementService().unlockAchievement(
        userId: userId,
        title: "Rising Star",
        description: "Earned 500 XP.",
        type: "xp",
      );
    }

    if (newXP >= 1000) {
      await AchievementService().unlockAchievement(
        userId: userId,
        title: "Skill Master",
        description: "Earned 1000 XP.",
        type: "xp",
      );
    }

    if (newXP >= 2500) {
      await AchievementService().unlockAchievement(
        userId: userId,
        title: "Elite Performer",
        description: "Earned 2500 XP.",
        type: "xp",
      );
    }

    if (newXP >= 5000) {
      await AchievementService().unlockAchievement(
        userId: userId,
        title: "Legend",
        description: "Earned 5000 XP.",
        type: "xp",
      );
    }
  }
  Future<void> awardAttendanceXP({
    required String userId,
  }) async {
    await addXP(
      userId: userId,
      earnedXP: 5,
    );
  }

  Future<void> awardSkillApprovalXP({
    required String userId,
  }) async {
    await addXP(
      userId: userId,
      earnedXP: 50,
    );
  }

  Future<void> awardAchievementXP({
    required String userId,
  }) async {
    await addXP(
      userId: userId,
      earnedXP: 30,
    );
  }

  Future<void> awardSkillCompletionXP({
    required String userId,
  }) async {
    await addXP(
      userId: userId,
      earnedXP: 100,
    );
  }

  Future<void> awardShowcaseXP({
    required String userId,
    required int score,
  }) async {
    int earnedXP = 25;

    if (score >= 90) {
      earnedXP += 40;
    }

    await addXP(
      userId: userId,
      earnedXP: earnedXP,
    );
  }

  int calculateLevel(int xp) {
    if (xp >= 5000) return 10;
    if (xp >= 4000) return 9;
    if (xp >= 3200) return 8;
    if (xp >= 2500) return 7;
    if (xp >= 1800) return 6;
    if (xp >= 1200) return 5;
    if (xp >= 700) return 4;
    if (xp >= 350) return 3;
    if (xp >= 100) return 2;

    return 1;
  }
}
