//
//  ReadTaskViewController.swift
//  ToDoList
//
//  Created by Дывак Максим on 19.04.2024.
//

import UIKit

// MARK: - Protocols

protocol PresentTaskViewControllerDelegate: AnyObject {
    func deleteTask(at index: IndexPath)
}


class PresentTaskViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: PresentTaskViewControllerDelegate?
    var dataToDo: TaskEntity?
    var taskIndex: IndexPath?
    
    private lazy var textField: UITextField = {
        var textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 20)
        if let text = dataToDo?.title {
            textField.text = dataToDo?.title
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    
    // MARK: - Methods
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        title = "Редактировать"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAction))
        
        view.addSubview(textField)
        
        
        // MARK: Constraints
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
        ])
    }
    
    @objc func deleteAction() {
        guard let index = taskIndex else { return }
        
        let alertController = UIAlertController(title: "Удалить задачу", message: "Вы действительно хотите удалить задачу?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            self.delegate?.deleteTask(at: index)
            self.navigationController?.popViewController(animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        self.present(alertController, animated: true)
    }
    
}
