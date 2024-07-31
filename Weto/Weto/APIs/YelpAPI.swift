//
//  YelpAPI.swift
//  Weto
//
//  Created by Hanan on 23/12/2020.
//

import Foundation

struct YelpAPI {
    
    // Yelp api base url
    static var host = "api.yelp.com"
    static var path = "/v3/businesses/search"
    
    // Yelp api Key
    static var apiKey = "FSA2evG6raTpMWYs1WgXZCQfaBKVbz6VfXvEjjZuh5jtN14UNCwPtpl0NuSveIHy8AuTOIq2zY6WjGAkoerQc4gx2gFcfxJu7jt6PQK5z0Ph6Mu35LY_cEA4bNDbX3Yx"
    
    //MARK: Parse JSONData -> YelpAPI Response
    static func parseJsonData(fromJSON: Data) -> Result<[Business], Error> {
        // 1- declare JSONDecoder instance
        let decoder = JSONDecoder()
        
        do {
            // 2- decode data to an array of Businuss Type
            let YelpResponse = try decoder.decode(BusinessResponse.self, from: fromJSON)
            
            // 3- Store array in a businesses array
            let businesses = YelpResponse.businesses
            
            // 4- return businesses array if success
            return .success(businesses)
        } catch {
            
            // 5- if else return error
            return .failure(error)
        }
    }
}
