//
//  ViewController.swift
//  Dependency Injection Pattern
//
//  Created by Miguel Angel Bric Ulloa on 02/05/23.
//

import UIKit

// MARK: - UsersListViewController
class UsersListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    // MARK: - Properties
    var viewModel: UsersViewModel?
    // let viewModel = UsersViewModel()
    // let viewModel = UsersViewModel(provider: UsersProviderMock())
    var usersList: [UserModel] = []

    // MARK: - Methods View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users List"
        tableView.delegate = self
        tableView.dataSource = self
        activity(isHidden: false)
        configureTableView()
    }
    
    // MARK: - Methods
    private func configureTableView(){
        tableView.estimatedRowHeight = UITableView.automaticDimension
        viewModel?.getUserFromProvider {[weak self] model in
            DispatchQueue.main.async {
                self?.activity(isHidden : true)
                self?.usersList = model
                self?.tableView.reloadData()
            }
        }
    }
    
    private func activity(isHidden : Bool){
        if !isHidden{
            activityView.startAnimating()
        }else{
            activityView.stopAnimating()
        }
        activityView.isHidden = isHidden
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = usersList[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = user.name
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = user.email
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}
