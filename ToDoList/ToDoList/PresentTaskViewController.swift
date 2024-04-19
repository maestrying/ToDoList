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
    var dataToDo: DataToDo?
    var taskIndex: IndexPath?
    
    private lazy var label: UILabel = {
        var label = UILabel()
        label.text = dataToDo?.title
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        view.addSubview(label)
        
        
        // MARK: Constraints
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
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
