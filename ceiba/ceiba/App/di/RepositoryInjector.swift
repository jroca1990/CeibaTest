//
//  RepositoryInjector.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation

class RepositoryInjector: NSObject {
    static let instance = RepositoryInjector()
 
    private override init() {
        super.init()
    }
    
    func ProvideUserRepository() ->  UserRepository{
        return UserRepositoryImp(userApiSource: DataSourceInjector.instance.provideUserApiSource(), userDBSource: DataSourceInjector.instance.provideUserDBSource())!
    }
}
