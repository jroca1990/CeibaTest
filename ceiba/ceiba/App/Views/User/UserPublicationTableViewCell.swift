//
//  UserPublicationTableViewCell.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import UIKit

class UserPublicationTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var body: UILabel!

    func diplayContent(publication : Publication) {
        self.title.text = publication.title
        self.body.text = publication.body
    }
}
