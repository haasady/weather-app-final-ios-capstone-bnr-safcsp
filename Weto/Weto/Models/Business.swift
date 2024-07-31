//
//  Business.swift
//  Weto
//
//  Created by Hanan on 23/12/2020.
//

import Foundation

struct BusinessResponse: Codable {
    var businesses: [Business]
}

struct Business: Codable {
    var id: String
    var name: String
    var imageURL: URL?
    var isClosed: Bool
    var businessURL: URL
    var coordinates: Coordinates
    var phone: String
    var location: Location
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case businessURL = "url"
        case coordinates
        case phone = "display_phone"
        case location
    }
}

struct Coordinates: Codable {
    var latitude: Double
    var longitude: Double
}

struct Location: Codable {
  var  address: [String]

    enum CodingKeys: String, CodingKey {
        case address = "display_address"
    }
}
