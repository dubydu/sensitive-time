/*
  Copyright © 2022 DUBYDU

  This software is provided 'as-is', without any express or implied warranty.
  In no event will the authors be held liable for any damages arising from
  the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
  claim that you wrote the original software. If you use this software in a
  product, an acknowledgment in the product documentation would be
  appreciated but is not required.

  2. Altered source versions must be plainly marked as such, and must not be
  misrepresented as being the original software.

  3. This notice may not be removed or altered from any source distribution.
 */

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    fileprivate let notificationCenter = UNUserNotificationCenter.current()
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notificationCenter.delegate = self
        let options: UNAuthorizationOptions = [
            .alert,
            .sound,
            .badge,
            .carPlay,
            .criticalAlert
        ]
        notificationCenter.requestAuthorization(options: options) {
            (allowed, error) in
            if !allowed {
                print("User has declined notifications")
            }
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([
            .badge,
            .banner,
            .list,
            .sound]
        )
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let intent = userActivity
            .interaction?
            .intent as? OperateNumbersIntent {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "intent"),
                                            object: nil,
                                            userInfo: ["intent": intent])
        }
        return true
    }

    /*
    func application(_ application: UIApplication,
                     willContinueUserActivityWithType userActivityType: String) -> Bool {
      return true
    }
     */

    func scheduleNotification(_ notificationType: String) {
        let content = UNMutableNotificationContent()
        let categoryIdentifier = "Delete Notification Type"
        content.title = notificationType
        content.body = "This is example how to create " + notificationType
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = categoryIdentifier
        if #available(iOS 15.0, *) {
            content.interruptionLevel = .timeSensitive
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10,
                                                        repeats: false
        )
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger
        )
        notificationCenter.add(request)
        let snoozeAction = UNNotificationAction(
            identifier: "Snooze",
            title: "Snooze", options: []
        )
        let deleteAction = UNNotificationAction(
            identifier: "DeleteAction",
            title: "Delete", options: [.destructive]
        )
        let category = UNNotificationCategory(identifier: categoryIdentifier,
                                              actions: [snoozeAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        notificationCenter.setNotificationCategories([category])
    }
}
