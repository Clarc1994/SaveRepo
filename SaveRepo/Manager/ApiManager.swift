//
//  ApiManager.swift
//  SaveRepo
//
//  Created by A1398 on 16/01/2023.
//

import Foundation

final class ApiManager {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func makeRequest<T: Decodable>(request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        let task = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(NSError(domain: K.ApiErrors.dataDownloadError, code: 100, userInfo: nil)))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: K.ApiErrors.noDataError, code: 100, userInfo: nil)))
                return
            }
            guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(NSError(domain: K.ApiErrors.dataParsingError, code: 100, userInfo: nil)))
                return
            }
            
            completion(.success(object))
        }
        task.resume()
    }
}
