//
//  UseCasesInjector.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation

class UseCasesInjector: NSObject {
    static let instance = UseCasesInjector()
 
    private override init() {
        super.init()
    }
    
    func provideUserUseCase() ->  UserUseCase{
        return UserUseCaseImpl(userRepository: RepositoryInjector.instance.ProvideUserRepository())!
    }
}
