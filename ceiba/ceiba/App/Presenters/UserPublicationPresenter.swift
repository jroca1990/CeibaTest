//
//  UserPublicationPresenter.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation

protocol UserPublicationsView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setPublications(publications: [Publication])
}

class UserPublicationsPresenter: NSObject {
    var userUseCase: UserUseCase
    var userPublicationsView : UserPublicationsView?
    
    init?(userUseCase:UserUseCase) {
        self.userUseCase = userUseCase
    }
    
    func attachView(_ view:UserPublicationsView){
        userPublicationsView = view
    }
    
    func getPublications(userId: Int64){
        self.userPublicationsView?.startLoading()
        userUseCase.loadUserPublications(userId: userId) { (publications) in
            self.userPublicationsView?.setPublications(publications: publications)
            self.userPublicationsView?.finishLoading()
        } failure: { (error) in
            self.userPublicationsView?.finishLoading()
            self.userPublicationsView?.setPublications(publications: [])
        }
    }
}
