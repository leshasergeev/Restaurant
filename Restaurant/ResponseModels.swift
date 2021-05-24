//
//  ResponseModels.swift
//  Restaurant
//
//  Created by Алексей Сергеев on 24.05.2021.
//  Copyright © 2021 Алексей Сергеев. All rights reserved.
//

import Foundation

struct MenuResponse: Codable {
    let items: [MenuItem]
}


struct CategoriesResponse: Codable {
    let categories: [String]
}


struct OrderResponse: Codable {
    let prepTime: Int
 
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}











