//
//  HomeViewModel.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/20/23.
//

import Foundation
import Combine

class HomeViewModel {
    
    
    @Published private(set) var posts: Result<[Post], Error> = .success([])
    @Published private(set) var isDarkTheme: Bool
    @Published private(set) var isPending: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var postRequestManager: PostRequestProtocl
    private var originalPosts: [Post] = [] // can be used specially for filtering
    private var themeManager: ThemeManagerProtocol
    
    init(reqManager: PostRequestProtocl, themeMgn: ThemeManagerProtocol) {
        postRequestManager = reqManager
        isDarkTheme = ThemeManager.shared.getCurrentThemeStyle() == .dark
        themeManager = themeMgn
    }
    
    func prepareData() {
        self.isPending = true
        self.postRequestManager.fetchPosts()
            .sink { [weak self] completion in
                self?.isPending = false
                if case let .failure(error) = completion {
                    self?.posts = .failure(error)
                }
            } receiveValue: { [weak self] value in
                self?.posts = .success(value)
                self?.originalPosts = value
            }
            .store(in: &self.cancellables)
    }
    
    func getPostAtIndex(index: Int) -> Post? {
        if index < self.originalPosts.count {
            return self.originalPosts[index]
        }
        return nil
    }
    
    func switchThemeStyle(isDarkActive: Bool) {
        themeManager.changeThemeStyle(style: isDarkActive ? .dark : .light)
        isDarkTheme = isDarkActive
    }
    
}
