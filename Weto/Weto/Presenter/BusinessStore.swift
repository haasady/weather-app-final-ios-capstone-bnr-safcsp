//
//  BusinessStore.swift
//  Weto
//
//  Created by Hanan on 23/12/2020.
//

import UIKit

enum PhotoError: Error {
    case imageCreationError
    case missingImageURL
}

class BusinessStore  {

    let api = API()
    let imageStore = ImageStore()

    func requestBusinessData(completion: @escaping (Result<[Business], Error>) -> Void) {
        
        // 1- set requset url
        var request = URLRequest(url: api.yelpApiURL)
        request.setValue("Bearer \(YelpAPI.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        // 2 - set the task
        let task = API.session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processRequest(data: data, error: error)
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
        // 3- start task
        task.resume()
    }
    
    // Do optional binding for requested data from api
    func processRequest(data: Data?, error: Error?) -> Result<[Business], Error> {
       guard let jsonData = data
       else {
           return .failure(error!)
       }
        return YelpAPI.parseJsonData(fromJSON: jsonData)
   }
    
    func fetchImage(for business: Business, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        let photoKey = business.id
        if let image = imageStore.image(forKey: photoKey) {
            DispatchQueue.main.async {
                completion(.success(image))
            }
            return
        }
        
        guard let photoURL = business.imageURL else {
            completion(.failure(PhotoError.missingImageURL))
            return
        }
        
        let request = URLRequest(url: photoURL)
        
        let task = API.session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
        guard let imageData = data, let image = UIImage(data: imageData) else {
            if data == nil {
                return .failure(error!)
            } else {
                return .failure(PhotoError.imageCreationError)
            }
        }
        return .success(image)
    }
}
