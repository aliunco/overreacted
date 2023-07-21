//
//  ThemeManager.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/20/23.
//

import Foundation
import UIKit

protocol ThemeManagerProtocol {
    func config() -> Void
    func getCurrentThemeStyle() -> UIUserInterfaceStyle
    func changeThemeStyle(style: UIUserInterfaceStyle) -> Void
}

class ThemeManager: ThemeManagerProtocol {
    // singleton
    static var shared: ThemeManager = ThemeManager()
    
    @Persisted(key: "ali.overreacted.themeStyle") private var isDark: Bool = false
    
    func config () {
        changeThemeStyle(style: self.isDark ? .dark : .light)
    }
    
    func getCurrentThemeStyle () -> UIUserInterfaceStyle {
        return isDark ? .dark : .light
    }
    
    func changeThemeStyle(style: UIUserInterfaceStyle) {
        DispatchQueue.main.async { [weak self] in
            UIApplication.firstKeyWindowForConnectedScenes?.overrideUserInterfaceStyle = style
            self?.isDark = style == .dark
        }
    }
    
}


private extension UIApplication {
    static var firstKeyWindowForConnectedScenes: UIWindow? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window
    }
}
