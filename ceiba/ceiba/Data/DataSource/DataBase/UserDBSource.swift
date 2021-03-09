//
//  user_db_source.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import UIKit
import Foundation
import CoreData

protocol UserDBSource {
    func loadUsers(success:  @escaping (_ usersList: [User]) -> Void, failure:@escaping(_ error: NSError) -> Void)
    func saveUserToDB(user:User)
}

class UserDBSourceImpl: UserDBSource {
    func loadUsers(success: @escaping ([User]) -> Void, failure: @escaping(NSError) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            var usersResult:[User] = [User]()
            for data in result {
                if let userEntity = User(name: ((data as AnyObject).value(forKey: "name") as? String)!, email: ((data as AnyObject).value(forKey: "email") as? String)!, phoneNumber: ((data as AnyObject).value(forKey: "phone") as? String)!, id: ((data as AnyObject).value(forKey: "id") as? Int64)!) {
                    usersResult.append(userEntity)
                }
            }
            success(usersResult)
        } catch {
            print("Failed")
        }
    }
    
    func saveUserToDB(user: User) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) as! UserMO
        entity.name = user.name
        entity.email = user.email
        entity.phone = user.phoneNumber
        entity.id = user.id

        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
