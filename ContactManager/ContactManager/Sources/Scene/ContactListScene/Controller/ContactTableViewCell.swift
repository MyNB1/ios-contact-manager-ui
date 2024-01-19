//
//  ContactTableViewCell.swift
//  ContactManager
//
//  Created by 둘리 on 2024/01/03.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    
    // MARK: @IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    // MARK: Custom Methods
    func configureUI() {
        let image = UIImage(systemName: "chevron.right")
        let rightImageView = UIImageView(image: image)
        rightImageView.tintColor = .systemGray3
        accessoryView = rightImageView
    }
    
    func setUpData(data: ContactInfoModel) {
        titleLabel.text = "\(data.name)(\(data.age))"
        subtitleLabel.text = data.contactNumber
    }
}
