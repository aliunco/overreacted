//
//  PostDetailViewController.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/21/23.
//

import UIKit
import Combine

class PostDetailViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    @IBOutlet private var switchView: CustomSwitch!
    
    private var cancellables = Set<AnyCancellable>()
    var viewModel: PostDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindView()
    }
    
    
    func bindView() {
        viewModel.$presentingPost
            .sink {[weak self] post in
                self?.titleLabel.text = post.title
                self?.dateLabel.text = post.publishedAt.format(dateFormat: "MMMM dd, yyyy")
                self?.bodyLabel.text = post.body
            }.store(in: &self.cancellables)

        
        viewModel.$isDarkTheme
            .receive(on: RunLoop.main)
            .assign(to: \.isOn, on: switchView)
            .store(in: &self.cancellables)
    }
    
    func configView () {
        switchView.onImage = UIImage(named: "moon")
        switchView.offImage = UIImage(named: "sun")
        switchView.isOn = ThemeManager.shared.getCurrentThemeStyle() == .dark
    }
    
    @IBAction func switchViewChange(_ sender: CustomSwitch) {
        viewModel.switchThemeStyle(isDarkActive: sender.isOn)
    }
}
