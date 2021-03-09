//
//  DataSourceInjector.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation

class DataSourceInjector: NSObject {
    static let instance = DataSourceInjector()
 
    private override init() {
        super.init()
    }
    
    func provideUserApiSource() ->  UserApiSource{
        return UserApiSourceImp(baseUrl: AppContext.instance.baseUrl)!
    }
    
    func provideUserDBSource() ->  UserDBSource{
        return UserDBSourceImpl()
    }
}
