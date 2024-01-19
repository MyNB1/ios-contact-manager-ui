//
//  UIViewController+.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/05.
//

import UIKit

extension UIViewController {
    
    // MARK: Properties
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last ?? ""
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last ?? ""
    }
}

extension UIViewController {
    
    /// 확인 버튼 Alert
    func presentAlert(title: String,
                      message: String? = nil,
                      okButtonTitle: String? = nil,
                      okAction: ((UIAlertAction) -> ())? = nil,
                      completion: (() -> ())? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    /// 확인, 취소 버튼이 있는 Alert
    func presentAlertWithCancel(title: String,
                                message: String? = nil,
                                okButtonTitle: String,
                                cancelButtonTitle: String,
                                okAction: ((UIAlertAction) -> ())? = nil,
                                cancelAction: ((UIAlertAction) -> ())? = nil,
                                completion: (() -> ())? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: okButtonTitle, style: .destructive, handler: okAction)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
