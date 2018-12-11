//
//  HapticFeedback.swift
//  Viper
//
//

import UIKit

///
class HapticFeedback: NSObject {

    /// Notification based haptic feedback
    ///
    /// - Parameter type: notification feedback can be Success, Warning or Failure
    static func notificationFeedback(ofType type: UINotificationFeedbackGenerator.FeedbackType) {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(type)
    }

    /// Impact based haptic feedback
    ///
    /// - Parameter type: impact feedback that can be Light, Medium or Heavy
    static func impactFeedback(ofType type: UIImpactFeedbackGenerator.FeedbackStyle) {
        let impact = UIImpactFeedbackGenerator(style: type)
        impact.impactOccurred()
    }

    /// Selection based haptic feedback
    static func selectionFeedback() {
        let selection = UISelectionFeedbackGenerator()
        selection.selectionChanged()
    }
}
