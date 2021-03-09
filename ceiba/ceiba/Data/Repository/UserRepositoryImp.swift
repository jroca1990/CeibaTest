//
//  UserRepositoryImp.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation

class UserRepositoryImp: UserRepository {
    var userApiSource : UserApiSource
    var userDBSource : UserDBSource

    init?(userApiSource:UserApiSource, userDBSource:UserDBSource) {
        self.userApiSource = userApiSource
        self.userDBSource = userDBSource
    }
    
    func loadUsersFromDB(success: @escaping ([User]) -> Void, failure: @escaping(NSError) -> Void) {
        self.userDBSource.loadUsers(success: success, failure: failure)
    }
    
    func saveUserToDB(user: User) {
        self.userDBSource.saveUserToDB(user: user)
    }
    
    func loadUsersFromAPI(success: @escaping ([User]) -> Void, failure: @escaping (NSError) -> Void) {
        self.userApiSource.loadUsers(success: success, failure: failure)
    }
    
    func loadUserPublications(userId: Int64, success: @escaping ([Publication]) -> Void, failure: @escaping (NSError) -> Void) {
        self.userApiSource.loadUserPublications(userId: userId, success: success, failure: failure)
    }
}
