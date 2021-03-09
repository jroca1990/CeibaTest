//
//  AppContext.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation

class AppContext: NSObject {
    static let instance = AppContext()
    var baseUrl : String

   private override init() {
    self.baseUrl = "https://jsonplaceholder.typicode.com";
    super.init()
   }
}

