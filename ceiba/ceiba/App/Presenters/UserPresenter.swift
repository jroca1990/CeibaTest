//
//  UserPresenter.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation

protocol UsersView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setUsers(users: [User])
    func setUsersForSearch(users: [User])

}

class UsersPresenter: NSObject {
    var userUseCase: UserUseCase
    var usersView : UsersView?
    
    init?(userUseCase:UserUseCase) {
        self.userUseCase = userUseCase
    }
    
    func attachView(_ view:UsersView){
        usersView = view
    }
    
    func getUsers(){
        usersView?.startLoading()

        userUseCase.loadUsers { (users) in
            self.usersView?.setUsers(users: users)
            self.usersView?.finishLoading()
        } failure: { (error) in
            self.usersView?.finishLoading()
        }

    }
    
    func searchUser(users:[User], text:String) {
        var usersFound = [User]();

        for user in users {
            if user.name!.contains(text) {
                usersFound.append(user)
            }
        }
        self.usersView?.setUsersForSearch(users: usersFound)
    }
}

