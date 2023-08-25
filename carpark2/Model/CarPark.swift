//
//  CarPark.swift
//  carpark2
//
//  Created by Wai Hong Lee on 25/08/2023.
//

import Foundation

struct CarParkReponse: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let timestamp: String
    let carParkData: [CarparkData]

    enum CodingKeys: String, CodingKey {
        case timestamp
        case carParkData = "carpark_data"
    }
}

struct CarparkData: Decodable {
    let carparkInfo: [CarparkInfo]
    let carparkNumber, updateDatetime: String

    enum CodingKeys: String, CodingKey {
        case carparkInfo = "carpark_info"
        case carparkNumber = "carpark_number"
        case updateDatetime = "update_datetime"
    }
}

struct CarparkInfo: Decodable {
    let totalLots: String
    let lotType: String
    let lotsAvailable: String

    enum CodingKeys: String, CodingKey {
        case totalLots = "total_lots"
        case lotType = "lot_type"
        case lotsAvailable = "lots_available"
    }
    
}
