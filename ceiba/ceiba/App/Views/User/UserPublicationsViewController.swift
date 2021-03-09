//
//  UserPublicationsViewController.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import UIKit
import SwiftSpinner

class UserPublicationsViewController: UIViewController {
    @IBOutlet var userName: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var table: UITableView!

    var user: User!
    var publications = [Publication]();
    var userPublicationsPresenter : UserPublicationsPresenter = UserPublicationsPresenter(userUseCase: UseCasesInjector.instance.provideUserUseCase())!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userPublicationsPresenter.attachView(self)

        self.userName.text = user.name
        self.phone.text = user.phoneNumber
        self.email.text = user.email
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.userPublicationsPresenter.getPublications(userId: user.id)
    }
}

extension UserPublicationsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.publications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userPublicationCell", for: indexPath)  as! UserPublicationTableViewCell
        let publication:Publication = publications[indexPath.row]
        cell.diplayContent(publication: publication)
        
        return cell
    }
}

extension UserPublicationsViewController: UserPublicationsView {
    func startLoading() {
        SwiftSpinner.show("loading user publications...")
    }
    
    func finishLoading() {
        SwiftSpinner.hide()
    }
    
    func setPublications(publications: [Publication]) {
        self.publications = publications
        self.table.reloadData()
    }
    
    
}
