//
//  Forecastday.swift
//  Weto
//
//  Created by Hanan on 23/12/2020.
//

import Foundation

struct ForecastResponse: Codable {
    let forecast: ForecastdayResponse
}

struct ForecastdayResponse: Codable {
    var forecastday: [Forecastday]
}

struct Forecastday: Codable  {
    var date: String
    var day: Day
}

struct Day: Codable {
    var temp: Double
    var humidity: Double
    var wind: Double
    var condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case temp = "avgtemp_c"
        case humidity = "avghumidity"
        case wind = "maxwind_mph"
        case condition
    }
}

struct Condition: Codable {
    var text: String
}
