//
//  String+.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/11.
//

import Foundation

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    /// 공백 삭제한 문자열 반환하는 메서드
    func deleteWhiteSpace() -> String {
        return self.filter { $0 != " " }.map { String($0) }.joined()
    }
    
    /// 문자열 내 특정 offset에 해당하는 index를 반환하는 메서드
    func indexForOffset(_ i: Int) -> String.Index {
        return self.index(self.startIndex, offsetBy: i)
    }
}
