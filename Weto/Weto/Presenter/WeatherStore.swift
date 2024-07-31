//
//  WeatherStore.swift
//  Weto
//
//  Created by Hanan on 23/12/2020.
//

import Foundation

class WeatherStore  {
   
    let api = API()

    func requestWeatherData(completion: @escaping (Result<[Forecastday], Error>) -> Void) {
        // 1- set requset url
        var request = URLRequest(url: api.weatherApiURL)
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
    func processRequest(data: Data?, error: Error?) -> Result<[Forecastday], Error> {
        guard let jsonData = data
        else {
            return .failure(error!)
        }
        return WeatherAPI.parseJsonData(fromJSON: jsonData)
    }
}
