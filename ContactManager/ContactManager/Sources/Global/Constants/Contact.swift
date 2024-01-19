//
//  Contact.swift
//  ContactManager
//
//  Created by 둘리 on 2024/01/18.
//

import Foundation

enum Contact {
    case normal
    case phone
    
    var regex: String {
        switch self {
        case .normal:
            return "^0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4])-([0-9]{3,4})-([0-9]{4})$"
        case .phone:
            return "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$"
        }
    }
}
