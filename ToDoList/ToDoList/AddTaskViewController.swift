//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Дывак Максим on 19.04.2024.
//

import UIKit

// MARK: - Protocols
protocol AddTaskViewControllerDelegate: AnyObject {
    func createTask(text: String, descr: String)
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
    
    private lazy var descrTask: UITextView = {
        var textView = UITextView()
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.backgroundColor = .black
        textView.layer.cornerRadius = 4
        textView.isEditable = true
        textView.isScrollEnabled = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        view.addSubview(descrTask)
        
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
            
            descrTask.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descrTask.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descrTask.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40),
            descrTask.heightAnchor.constraint(equalToConstant: 200),

        ])
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func sendDataFromTextField() {
        let text = textField.text ?? "nil"
        let descr = descrTask.text ?? "nil"
        
        self.delegate?.createTask(text: text, descr: descr)
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
