//
//  UITableViewCell+.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/05.
//

import UIKit

extension UITableViewCell {
    
    // MARK: Properties
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last ?? ""
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last ?? ""
    }
}
