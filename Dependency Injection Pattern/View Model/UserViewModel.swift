//
//  PostViewModel.swift
//  Dependency Injection Pattern
//
//  Created by Miguel Angel Bric Ulloa on 02/05/23.
//

import Foundation

class UsersViewModel {
    
    private var provider: UsersProviderProtocol
    
    init(provider: UsersProviderProtocol = UsersProvider()) {
        self.provider = provider
    }
    
    func getUserFromProvider(_ completion: @escaping ([UserModel]) -> Void){
        provider.getUsers { response in
            switch response{
            case .success((let model, _)):
                completion(model)
            case .failure(let error):
                print("error: ", error.localizedDescription)
            }
        }
    }
    
    func getUserFromProvider2(_ completion: @escaping ([UserModel]) -> Void){
        provider.getUsers { response in
            
        }
    }
}
