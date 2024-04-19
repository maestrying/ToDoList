//
//  ReadTaskViewController.swift
//  ToDoList
//
//  Created by Дывак Максим on 19.04.2024.
//

import UIKit

class PresentTaskViewController: UIViewController {
    
    // MARK: - Properties
    var taskText: String?
    
    private lazy var label: UILabel = {
        var label = UILabel()
        label.text = taskText
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    
    // MARK: - Lifecycle
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        title = "Редактировать"

        view.addSubview(label)
        
        
        // MARK: Constraints
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
    }
    
    
    // MARK: - Methods
    
}
