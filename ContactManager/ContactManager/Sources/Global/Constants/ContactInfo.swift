//
//  ContactInfo.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/15.
//

import Foundation

enum ContactInfo: String {
    case name = "이름"
    case age = "나이"
    case contactNumber = "연락처"
    
    var description: String {
        return rawValue
    }
}
