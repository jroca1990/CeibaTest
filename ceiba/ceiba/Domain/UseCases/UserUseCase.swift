//
//  UserUseCase.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation

protocol UserUseCase {
    func loadUsers(success:  @escaping (_ usersList: [User]) -> Void, failure:@escaping (_ error: NSError) -> Void)
    func loadUserPublications( userId:Int64, success:  @escaping ([Publication]) -> Void, failure:  @escaping (NSError) -> Void);
}

class UserUseCaseImpl: UserUseCase {
    var userRepository:UserRepository
    
    init?(userRepository:UserRepository) {
        self.userRepository = userRepository
    }
    
    func loadUsers(success: @escaping ([User]) -> Void, failure: @escaping (NSError) -> Void) {
        self.userRepository.loadUsersFromDB { (usersFromDb) in
            if(usersFromDb.count == 0) {
                self.userRepository.loadUsersFromAPI { (users) in
                    for user in users {
                        self.userRepository.saveUserToDB(user: user)
                    }
                    success(users)
                } failure: { (error) in
                    failure(error)
                }

            } else {
                success(usersFromDb)
            }
        } failure: { (error) in
            failure(error)
        }

    }
    
    func loadUserPublications(userId: Int64, success: @escaping ([Publication]) -> Void, failure: @escaping (NSError) -> Void) {
        return self.userRepository.loadUserPublications(userId: userId, success: success, failure: failure)
    }
}
