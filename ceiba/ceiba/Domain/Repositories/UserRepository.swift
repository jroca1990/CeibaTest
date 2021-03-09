//
//  UserRepository.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation

protocol UserRepository {
    func loadUsersFromDB(success:  @escaping (_ usersList: [User]) -> Void, failure:@escaping (_ error: NSError) -> Void)
    func saveUserToDB(user:User)
    func loadUsersFromAPI(success:  @escaping (_ usersList: [User]) -> Void, failure:@escaping (_ error: NSError) -> Void)
    func loadUserPublications( userId:Int64, success:  @escaping ([Publication]) -> Void, failure:  @escaping (NSError) -> Void);
}
