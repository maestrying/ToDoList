//
//  SettingsViewController.swift
//  ToDoList
//
//  Created by Дывак Максим on 20.04.2024.
//

import UIKit

enum SettingType {
    case name
    case language
    case darkMode
    case notifications
    case privacyPolicy
    case helpAndFeedback
}

class SettingsViewController: UIViewController {

    // MARK: - Properties
    // TODO: Имя, Язык, Темный режим, Уведомления, Политика конфиденциальности, Помощь & Обратная связь
    var settingsTableView: UITableView!
    let identifier = "SettingsCell"
    var settings: [SettingType] = [
        .name,
        .language,
        .darkMode,
        .notifications,
        .privacyPolicy,
        .helpAndFeedback
    ]
    
    private lazy var nameTextField: UITextField = {
        var name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.borderStyle = .roundedRect
        name.placeholder = "Введите ваше имя"
        return name
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    //MARK: - Methods
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        
        createTable()
        
        //MARK: - Constraints
        
    }
    
    private func createTable() {
        settingsTableView = UITableView(frame: view.bounds)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(settingsTableView)
    }

}

// MARK: - Table methods
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let setting = settings[indexPath.row]
        
        switch setting {
        case .name: cell.textLabel?.text = "Имя"
        case .language: cell.textLabel?.text = "Язык"
        case .darkMode: cell.textLabel?.text = "Темный режим"
        case .notifications: cell.textLabel?.text = "Уведомления"
        case .privacyPolicy: cell.textLabel?.text = "Политика конфиденциальности"
        case .helpAndFeedback: cell.textLabel?.text = "Помощь & Обратная связь"
        }
        
        return cell
    }
}
