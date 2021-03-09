//
//  Publication.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation

class Publication {
    var title: String?
    var body: String?
    
    init?(title:String, body:String) {
        self.title = title
        self.body = body
    }
}
