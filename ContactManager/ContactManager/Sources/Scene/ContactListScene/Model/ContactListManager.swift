//
//  ContactListManager.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/17.
//

import Foundation

final class ContactListManager {
    
    // MARK: Properties
    private var contactList: [ContactInfoModel] = [
        ContactInfoModel(name: "james", age: 30, contactNumber: "05-343-2234"),
        ContactInfoModel(name: "steven", age: 100, contactNumber: "047-221-3432"),
        ContactInfoModel(name: "hajin", age: 33, contactNumber: "010-333-23122"),
        ContactInfoModel(name: "tom", age: 23, contactNumber: "2313-23-232"),
        ContactInfoModel(name: "tomi", age: 23, contactNumber: "123-123-123"),
        ContactInfoModel(name: "jane", age: 99, contactNumber: "6988-768-788"),
        ContactInfoModel(name: "july", age: 32, contactNumber: "05-2222-3234"),
        ContactInfoModel(name: "eren", age: 220, contactNumber: "123-13-423"),
        ContactInfoModel(name: "gom", age: 53, contactNumber: "010-222-36722"),
        ContactInfoModel(name: "jin", age: 73, contactNumber: "683-2543-233432"),
        ContactInfoModel(name: "saejun", age: 42, contactNumber: "1889-793-677"),
        ContactInfoModel(name: "jinyoung", age: 19, contactNumber: "111-2222-33333-444"),
        ContactInfoModel(name: "mike", age: 60, contactNumber: "05-343-2256564"),
        ContactInfoModel(name: "nero", age: 90, contactNumber: "45457-2221-3432"),
        ContactInfoModel(name: "easy", age: 13, contactNumber: "0220-333-65122"),
        ContactInfoModel(name: "matthew", age: 63, contactNumber: "22133-23-23446452"),
        ContactInfoModel(name: "sidi", age: 72, contactNumber: "968763-123-123"),
        ContactInfoModel(name: "den", age: 09, contactNumber: "0293-233-1111")
    ]
    
    // MARK: Custom Methods
    func fetchContactListData() -> [ContactInfoModel] {
        return contactList
    }
    
    func createContactData(_ newContact: ContactInfoModel) -> [ContactInfoModel] {
        contactList.append(newContact)
        return contactList
    }
}
