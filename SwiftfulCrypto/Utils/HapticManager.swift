//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-14.
//

import Foundation
import SwiftUI

class HApticManager{
    private static let genrater = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        genrater.notificationOccurred(type)
    }
}
