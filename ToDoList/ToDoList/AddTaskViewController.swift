//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Дывак Максим on 19.04.2024.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - Properties
    
    weak var delegate: AddTaskViewControllerDelegate?
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите что хотите сделать"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var submitButton: UIButton = {
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Сохранить", for: .normal)
        submitButton.addTarget(self, action: #selector(sendDataFromTextField), for: .touchUpInside)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        return submitButton
    }()
    

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self

        setupLayout()
    }
    
    
    // MARK: - Methods
    
    private func setupLayout() {
        
        // MARK: Hide keyboard
        let keyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        keyboardGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(keyboardGesture)
        
        // MARK: UI
        view.backgroundColor = .systemBackground
        
        title = "Добавить задачу"
        
        view.addSubview(submitButton)
        view.addSubview(textField)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20)
        ])
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func sendDataFromTextField() {
        let text = textField.text ?? "nil"
        
        self.delegate?.createTask(text: text)
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
