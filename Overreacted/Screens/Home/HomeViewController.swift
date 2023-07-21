//
//  ViewController.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/20/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet private var switchView: CustomSwitch!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = HomeViewModel(reqManager: PostRequest(), themeMgn: ThemeManager.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
        viewModel.prepareData()
    }
    
    func bindViewModel() {
        viewModel.$posts.receive(on: RunLoop.main)
            .compactMap({ result in
                if case .success(let value) = result {
                    return value
                }
                return nil
            }).sink(receiveValue: self.tableView.items { tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostItemTableViewCell else {
                    return UITableViewCell()
                }
                cell.setPost(post: item)
                return cell
            })
            .store(in: &self.cancellables)
        
        self.loadingIndicator.stopAnimating()
        
        viewModel.$isPending
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: loadingIndicator)
            .store(in: &self.cancellables)
        
        viewModel.$isDarkTheme
            .receive(on: RunLoop.main)
            .assign(to: \.isOn, on: switchView)
            .store(in: &self.cancellables)
    }
    
    func configView() {
        ThemeManager.shared.config()
        
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        switchView.onImage = UIImage(named: "moon")
        switchView.offImage = UIImage(named: "sun")
        
        textView.addHyperLinksToText(
            originalText: "Personal blog by Ali Saeedifar I explain with words and code.",
            hyperLinks: ["Ali Saeedifar":"https://www.linkedin.com/in/ali-saeedifar/"]
        )
    }
    
    @IBAction func switchViewChange(_ sender: CustomSwitch) {
        viewModel.switchThemeStyle(isDarkActive: sender.isOn)
    }
    
    
    // MARK: tableviewdelegates
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = viewModel.getPostAtIndex(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let _ = selectedItem else { return}
        self.performSegue(withIdentifier: "showDetailSegue", sender: selectedItem)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            guard let detailView = segue.destination as? PostDetailViewController,
                  let item = sender as? Post else { return }
            detailView.viewModel = PostDetailViewModel(params: item, themeMgn: ThemeManager.shared)
            
            // in order to get information from the next screen
            detailView.viewModel.$isDarkTheme
                .receive(on: RunLoop.main)
                .assign(to: \.isOn, on: switchView)
                .store(in: &self.cancellables)
        }
    }
}

