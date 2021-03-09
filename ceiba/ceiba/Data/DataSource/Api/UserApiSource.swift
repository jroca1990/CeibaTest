//
//  user_api_source.swift
//  ceiba
//
//  Created by Jorge Luis Rodriguez Carreño on 9/03/21.
//

import Foundation
import Alamofire

protocol UserApiSource {
    func loadUsers(success:  @escaping (_ usersList: [User]) -> Void, failure:@escaping (_ error: NSError) -> Void)
    func loadUserPublications( userId:Int64, success:  @escaping ([Publication]) -> Void, failure:  @escaping (NSError) -> Void);
}

class UserApiSourceImp: BaseApiSource, UserApiSource {
    init?(baseUrl:String) {
        super.init()
        self.baseUrl = baseUrl
    }
    
    func loadUsers( success:  @escaping ([User]) -> Void, failure:  @escaping (NSError) -> Void) {
        let url : String = baseUrl + "/users"
        Alamofire.request(url).responseJSON {(response) in
            switch response.result {
            case .success(let JSON):
                var usersResult:[User] = [User]()

                if let jsonResult = JSON as? Array<Dictionary<String, AnyObject>> {
                    for user in jsonResult {
                        if let userEntity = User(name: user["name"] as! String, email: user["email"] as! String, phoneNumber: user["phone"] as! String, id: user["id"] as! Int64) {
                            usersResult.append(userEntity)
                        }
                    }
                }
            
                success(usersResult)

            case .failure(let error):
                failure(error as NSError)
                break
            }
        }
    }
    
    func loadUserPublications( userId:Int64, success:  @escaping ([Publication]) -> Void, failure:  @escaping (NSError) -> Void) {
        let url : String = baseUrl + "/posts?userId=\(userId)"
        Alamofire.request(url).responseJSON {(response) in
            switch response.result {
            case .success(let JSON):
                var userPublicationsResult:[Publication] = [Publication]()

                if let jsonResult = JSON as? Array<Dictionary<String, AnyObject>> {
                    for publication in jsonResult {
                        if let publicationEntity = Publication(title: publication["title"] as! String, body: publication["title"] as! String) {
                            userPublicationsResult.append(publicationEntity)
                        }
                    }
                }
            
                success(userPublicationsResult)
            case .failure(let error):
                failure(error as NSError)
                break
            }
        }
    }
}
