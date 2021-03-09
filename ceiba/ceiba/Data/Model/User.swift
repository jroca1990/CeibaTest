//
//  User.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//


import CoreData
import Foundation

class User {
    var name: String?
    var email: String?
    var phoneNumber: String?
    var id: Int64
    
    init?(name:String, email:String, phoneNumber:String, id:Int64) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.id = id
    }
}

class UserMO : NSManagedObject{
    @NSManaged var name: String?
    @NSManaged var email: String?
    @NSManaged var phone: String?
    @NSManaged var id: Int64

}
