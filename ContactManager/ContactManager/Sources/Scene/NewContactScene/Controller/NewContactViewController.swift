//
//  NewContactViewController.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/10.
//

import UIKit

final class NewContactViewController: UIViewController {
    
    // MARK: Properties
    private let newContactManager: NewContactManager
    
    // MARK: @IBOutlet
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var contactNumberTextField: UITextField!
    
    // MARK: Initializer
    required init?(coder aDecoder: NSCoder) {
        self.newContactManager = NewContactManager()
        super.init(coder: aDecoder)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTarget()
    }
    
    // MARK: Custom Methods
    private func addTarget() {
        contactNumberTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: @IBAction
    @IBAction private func tapCancelButton(_ sender: UIBarButtonItem) {
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?",
                               okButtonTitle: "예",
                               cancelButtonTitle: "아니오",
                               okAction: { [weak self] _ in
            self?.dismiss(animated: true)
        })
    }
    
    @IBAction private func tapSaveButton(_ sender: UIBarButtonItem) {
        do {
            let result = try newContactManager.checkValidityOfContactData(nameInput: nameTextField.text,
                                                              ageInput: ageTextField.text,
                                                              contactNumberInput: contactNumberTextField.text)
            guard let presentingViewController = presentingViewController as? ContactListViewController else { return }
            dismiss(animated: true, completion: {
                presentingViewController.updateContactList(result)
            })
        } catch ContactManagerError.invalidInput(let info) {
            presentAlert(title: "입력한 \(info.description) 정보가 잘못되었습니다")
        } catch {
            return
        }
    }
}

// MARK: - TextField
extension NewContactViewController {
    
    @objc
    func textFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        sender.text = newContactManager.addHypen(at: text)
    }
}
