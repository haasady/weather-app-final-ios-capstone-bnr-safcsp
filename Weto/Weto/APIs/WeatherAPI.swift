//
//  WeatherAPI.swift
//  Weto
//
//  Created by Hanan on 23/12/2020.
//

import Foundation

struct WeatherAPI {
    
    // Weather api base url
    static var host = "api.weatherapi.com"
    static var path = "/v1/forecast.json"
    
    // Weather api Key
    static var apiKey = "2b5b5a08035a40b3942172348201712"

    //MARK: Parse JsonData -> WeatherAPI Response
    static func parseJsonData(fromJSON: Data) -> Result<[Forecastday], Error> {
        // 1- declare JSONDecoder instance
        let decoder = JSONDecoder()
        
        do {
            // 2- decode data to an array of Forecastday Type
            let weatherResponse = try decoder.decode(ForecastResponse.self, from: fromJSON)
            
            // 3- Store array in a forcastday array
            let forcastday = weatherResponse.forecast.forecastday
            
            // 4- return forcastday array if success
            return .success(forcastday)
        } catch {
            
            // 5- if else return error
            return .failure(error)
        }
    }
    
}
