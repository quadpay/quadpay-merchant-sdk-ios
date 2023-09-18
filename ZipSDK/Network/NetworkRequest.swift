//
//  NetworkRequest.swift
//  QuadPaySDK
//
//  Created by Rhys John Williams on 15/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (Result<ModelType?, Error>) -> Void)
}

extension NetworkRequest {
    func load (_ url: URL, withCompletion completion: @escaping (Result<ModelType?, Error>) -> Void){
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) -> Void in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(Result.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(Result.failure(ServiceError.server))
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(Result.success(nil))
                }
                return
            }

            guard let value = self?.decode(data) else {
                DispatchQueue.main.async {
                    completion(Result.failure(ServiceError.parsing))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(Result.success(value))
            }
        }
        task.resume()
    }
}
