//
//  ContactTableViewCell.swift
//  ContactManager
//
//  Created by 둘리 on 2024/01/03.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    
    // MARK: @IBOutlet
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    
    // MARK: Custom Methods
    func setUpData(data: ContactInfoModel) {
        nameLabel.text = data.name
        ageLabel.text = "\(data.age) 세"
        contactNumberLabel.text = data.contactNumber
    }
}
