//
//  NewContactManager.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/17.
//

import Foundation

final class NewContactManager {
    
    // MARK: Properties
    private var digits: String = ""
    private var isFirstDigitZero: Bool {
        return digits.first == "0"
    }
    private var isSecondDigitTwo: Bool {
        return digits.count >= 2 && digits[1] == "2"
    }
    
    // MARK: Custom Methods
    private func isDigitCountInRange(_ start: Int, _ end: Int) -> Bool {
        return digits.count >= start && digits.count <= end
    }
    
    private func insertHypen(_ index: Int) {
        digits.insert("-", at: digits.indexForOffset(index))
    }
    
    private func removeHypen() {
        digits = digits.replacingOccurrences(of: "-", with: "")
    }
    
    /// 핸드폰 번호 형식인지 검사하는 메서드
    private func validatePhoneNumberFormat(_ text: String) -> Bool {
        let regex = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: text)
    }
    
    /// 일반 전화 형식인지 검사하는 메서드
    private func validateContactNumberFormat(_ text: String) -> Bool {
        let regex = "^0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4])-([0-9]{3,4})-([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: text)
    }
}

// MARK: - Public Methods
extension NewContactManager {
    
    /// 전화번호 형식에 맞게 하이픈 추가하는 메서드
    func addHypen(at text: String) -> String {
        digits = text
        removeHypen()
        guard digits.count >= 2 else { return digits }
        
        if isFirstDigitZero {
            if isSecondDigitTwo { // 02
                if isDigitCountInRange(3, 5) {
                    insertHypen(2)
                } else if isDigitCountInRange(6, 9) {
                    insertHypen(2)
                    insertHypen(6)
                } else if digits.count == 10 {
                    insertHypen(2)
                    insertHypen(7)
                }
            } else { // 02 형식 아닐 때
                if isDigitCountInRange(4, 6) {
                    insertHypen(3)
                } else if isDigitCountInRange(7, 10) {
                    insertHypen(3)
                    insertHypen(7)
                } else if digits.count == 11 {
                    insertHypen(3)
                    insertHypen(8)
                }
            }
        }
        
        return digits
    }
    
    /// 연락처 정보 유효성 검사 메서드
    func checkValidityOfContactData(nameInput: String?,
                                            ageInput: String?,
                                            contactNumberInput: String?) throws -> ContactInfoModel {
        guard let name = nameInput?.deleteWhiteSpace() else {
            throw ContactManagerError.invalidInput(input: .name)
        }
        guard let ageInput,
              let age = Int(ageInput.deleteWhiteSpace()), age > 0 && age < 1000 else {
            throw ContactManagerError.invalidInput(input: .age)
        }
        guard let contactNumber = contactNumberInput,
              validatePhoneNumberFormat(contactNumber)
                || validateContactNumberFormat(contactNumber) else {
            throw ContactManagerError.invalidInput(input: .contactNumber)
        }

        return ContactInfoModel(name: name, age: age, contactNumber: contactNumber)
    }
}
