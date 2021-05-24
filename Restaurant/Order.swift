//
//  Order.swift
//  Restaurant
//
//  Created by Алексей Сергеев on 24.05.2021.
//  Copyright © 2021 Алексей Сергеев. All rights reserved.
//

import Foundation


struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}













