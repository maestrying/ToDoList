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
    func updateTask(item: TaskEntity, title: String, description: String)
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
    
    private lazy var descrTask: UITextView = {
        var textView = UITextView()
        textView.textColor = .white
        if let text = dataToDo?.descr {
            textView.text = dataToDo?.descr
        }
        textView.backgroundColor = .darkGray.withAlphaComponent(0.3)
        textView.layer.cornerRadius = 4
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = true
        textView.isScrollEnabled = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateAction)),
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAction))
        ]
        
        view.addSubview(textField)
        view.addSubview(descrTask)
        
        
        // MARK: Constraints
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            descrTask.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            descrTask.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            descrTask.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40),
            descrTask.heightAnchor.constraint(equalToConstant: 200)
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
    
    @objc func updateAction() {
        guard taskIndex != nil else { return }
        
        if let taskEntity = dataToDo, let text = textField.text, let descr = descrTask.text {
            self.delegate?.updateTask(item: taskEntity, title: text, description: descr)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
}
