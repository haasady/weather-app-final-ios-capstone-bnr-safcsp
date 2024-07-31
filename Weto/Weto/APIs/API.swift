//
//  API.swift
//  Weto
//
//  Created by Hanan on 23/12/2020.
//

import Foundation

struct API {
    
    public static var city = String()
    public static var lat = Double()
    public static var lon = Double()
    
    // Declare Configured URLSession instanceg
    static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    // Yelp api requesr url
     var yelpApiURL: URL {
        return API.fechUrl(host: YelpAPI.host, path: YelpAPI.path,
                           parameters: ["API_KEY": YelpAPI.apiKey,
                                        "format": "json",
                                        "term": "coffee",
                                        "location": "\(API.city)" ])
    }
    
    // Weather api requesr url
     var weatherApiURL: URL {
        return API.fechUrl(host: WeatherAPI.host, path: WeatherAPI.path,
                           parameters: ["key": WeatherAPI.apiKey,
                                        "q": "\(API.lat), \(API.lon)",
                                        "days": "3" ])
    }
    
    // Returns api requesrt url
    static func fechUrl(host: String, path: String, parameters: [String: String])  -> URL  {
         var component = URLComponents()
         
         component.scheme = "https"
         component.host = host
         component.path = path
         
         var query = [URLQueryItem]()
         
         for (key, value) in parameters {
             let item = URLQueryItem(name: key, value: value)
             query.append(item)
         }
         
         component.queryItems = query
         
         return component.url!
     }
}




