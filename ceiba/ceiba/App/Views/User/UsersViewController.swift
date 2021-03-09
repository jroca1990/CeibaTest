//
//  UsersViewController.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import UIKit
import SwiftSpinner

class UsersViewController: UIViewController {
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var emptyState: UILabel!

    var userPresenter : UsersPresenter = UsersPresenter(userUseCase: UseCasesInjector.instance.provideUserUseCase())!
    var allUsers = [User]();
    var usersFound = [User]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userPresenter.attachView(self)
        self.searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userPresenter.getUsers()
    }
}

extension UsersViewController: UsersView {
    func startLoading() {
        SwiftSpinner.show("loading users...")
    }
    
    func finishLoading() {
        SwiftSpinner.hide()
    }
    
    func setUsers(users: [User]) {
        self.usersFound.removeAll()
        self.usersFound = users
        self.allUsers = users
        self.table.reloadData()
    }
    
    func setUsersForSearch(users: [User]) {
        self.usersFound.removeAll()
        self.usersFound = users
        
        if(self.usersFound.count == 0) {
            self.emptyState.isHidden = false
        } else {
            self.emptyState.isHidden = true
        }
        self.table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showUserPublications" {
            let indexPath = self.table.indexPathForSelectedRow
            let user:User = self.usersFound[indexPath!.row]
            let userPublicationsViewController = segue.destination as! UserPublicationsViewController
            userPublicationsViewController.user = user
        }
    }
}

extension UsersViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersFound.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)  as! UserTableViewCell
        let user:User = usersFound[indexPath.row]
        cell.diplayContent(user: user)
        
        return cell
    }
}

extension UsersViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.trimmingCharacters(in: .whitespacesAndNewlines).count == 0) {
            self.emptyState.isHidden = true
            self.usersFound = self.allUsers
            self.table.reloadData()
        } else {
            self.userPresenter.searchUser(users: self.allUsers, text: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

