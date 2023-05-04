//
//  UsersProvider.swift
//  Dependency Injection Pattern
//
//  Created by Miguel Angel Bric Ulloa on 02/05/23.
//

import Foundation

/// A set of methods for adapting the contents of your provider: endpoints or mocks.
protocol UsersProviderProtocol {
    /// Asynchronously calls a completion callback with all data (User info).
    /// - Parameter completion: The completion handler to callback with all users.
    func getUsers(_ completion: @escaping (Result<([UserModel], URLResponse?), Error>) -> Void)
}

/// UserProvider class allows connection to the endpoint.
class UsersProvider: UsersProviderProtocol{
    func getUsers(_ completion: @escaping (Result<([UserModel], URLResponse?), Error>) -> Void) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
              completion(.failure(error))
            } else if let data = data, let response = response {
                do {
                    let res = try JSONDecoder().decode([UserModel].self, from: data)
                    //sleep(1)
                    completion(.success((res, response)))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

/// The UserProvider class returns the locally stored bundle object.
class UsersProviderMock: UsersProviderProtocol{
    func getUsers(_ completion: @escaping (Result<([UserModel], URLResponse?), Error>) -> Void) {
        let url = Bundle.main.url(forResource: "UsersMock", withExtension: "json")
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let jsonData = try Data(contentsOf: url!)
            let model = try decoder.decode([UserModel].self, from: jsonData)
            completion(.success((model, nil)))
        }catch let error{
            completion(.failure(error))
        }
        
    }
}
