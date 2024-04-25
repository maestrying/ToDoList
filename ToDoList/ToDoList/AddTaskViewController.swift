//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Дывак Максим on 19.04.2024.
//

import UIKit

// MARK: - Protocols
protocol AddTaskViewControllerDelegate: AnyObject {
    func createTask(text: String)
}

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    weak var delegate: AddTaskViewControllerDelegate?
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите что хотите сделать"
        textField.borderStyle = .roundedRect
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var submitButton: UIButton = {
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Сохранить", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10.0
        submitButton.titleLabel?.adjustsFontSizeToFitWidth = true
        submitButton.addTarget(self, action: #selector(sendDataFromTextField), for: .touchUpInside)
        submitButton.backgroundColor = .systemBlue
        
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
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            textField.heightAnchor.constraint(equalToConstant: 40),

            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            submitButton.widthAnchor.constraint(equalToConstant: 300),
            submitButton.heightAnchor.constraint(equalToConstant: 60),

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
