//
//  ContactListViewController.swift
//  ContactManager
//
//  Created by 둘리 on 2024/01/03.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    // MARK: Properties
    private let contactListManager: ContactListManager
    private var contactList: [ContactInfoModel]
    
    // MARK: @IBOutlet
    @IBOutlet private weak var contactTableView: UITableView!
    
    // MARK: Initializer
    required init?(coder aDecoder: NSCoder) {
        self.contactListManager = ContactListManager()
        self.contactList = contactListManager.fetchContactListData()
        super.init(coder: aDecoder)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        registerTableViewCell()
    }
    
    // MARK: Custom Methods
    private func setUpTableView() {
        contactTableView.delegate = self
        contactTableView.dataSource = self
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: ContactTableViewCell.className, bundle: nil)
        contactTableView.register(nib, forCellReuseIdentifier: ContactTableViewCell.className)
    }
    
    // MARK: @IBAction
    @IBAction private func tapAddContactButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "NewContact", bundle: nil)
        guard let newContactViewController =
                storyboard.instantiateViewController(identifier: NewContactViewController.className) as? NewContactViewController else { return }
        self.present(newContactViewController, animated: true)
    }
    
    // MARK: Custom Methods
    func updateContactList(_ contact: ContactInfoModel) {
        contactList = contactListManager.createContactData(contact)
        contactTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ContactListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            contactList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

// MARK: - UITableViewDataSource
extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.className, for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        
        cell.setUpData(data: contactList[indexPath.row])

        return cell
    }
}
