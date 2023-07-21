//
//  PostViewModel.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/21/23.
//

import Foundation

class PostDetailViewModel {
    
    @Published private(set) var presentingPost: Post
    @Published private(set) var isDarkTheme: Bool
    
    private var themeManager: ThemeManagerProtocol
    
    init(params: Post, themeMgn: ThemeManagerProtocol) {
        presentingPost = params
        themeManager = themeMgn
        isDarkTheme = ThemeManager.shared.getCurrentThemeStyle() == .dark
    }
    
    func switchThemeStyle(isDarkActive: Bool) {
        themeManager.changeThemeStyle(style: isDarkActive ? .dark : .light)
        isDarkTheme = isDarkActive
    }
}
