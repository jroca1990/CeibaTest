//
//  UserTableViewCell.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet var userName: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var email: UILabel!

    func diplayContent(user : User) {
        self.userName.text = user.name
        self.phone.text = user.phoneNumber
        self.email.text = user.email
    }
}
