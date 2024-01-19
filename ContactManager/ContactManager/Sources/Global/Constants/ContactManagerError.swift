//
//  ContactManagerError.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/17.
//

import Foundation

enum ContactManagerError: Error {
    case invalidInput(input: ContactInfo)
}
