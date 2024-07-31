//
//  BusinessWeather.swift
//  Weto
//
//  Created by Hanan on 30/12/2020.
//

import UIKit

class BusinessWeather: Codable {
    
    var business: Business
    var weather: [Forecastday] // [(date,day), , (date,day), (date,day), (date,day)]
    
    init(business: Business, weather: [Forecastday]) {
        self.business = business
        self.weather = weather
    }
}

extension BusinessWeather: Equatable {
    static func == (lhs: BusinessWeather, rhs: BusinessWeather) -> Bool {
        return lhs.business.id == rhs.business.id
    }
}


