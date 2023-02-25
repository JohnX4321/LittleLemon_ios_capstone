//
//  MenuItem.swift
//  LittleLemon
//
//  Created by Samarth MS on 25/02/23.
//

import Foundation

struct MenuItem: Decodable {
    var id: Int = 0
    var title: String = ""
    var description: String = ""
    var price: String = ""
    var image: String = ""
    var category: String = ""
}
