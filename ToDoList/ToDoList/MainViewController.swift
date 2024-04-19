//
//  MainViewController.swift
//  ToDoList
//
//  Created by Дывак Максим on 19.04.2024.
//

import UIKit

// MARK: - Protocold
protocol AddTaskViewControllerDelegate: AnyObject {
    func createTask(text: String)
}


// MARK: - Data
struct DataToDo {
    var title: String
}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Data initial
    var dataArr: [DataToDo] = []
    
    
    // MARK: - Properties
    var tableView: UITableView!
    let identifier = "MyTable"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    
    // MARK: - methods
    private func createTable() {
        let tableView = UITableView(frame: view.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        title = "ToDo-Lite"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    
        createTable()
    }
    
    
    // MARK: - Table methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row].title
        return cell
    }
    
    @objc func addTask() {
        let addTaskViewController = AddTaskViewController()
        addTaskViewController.delegate = self
        navigationController?.pushViewController(addTaskViewController, animated: true)
    }


}


// MARK: - Extentions

extension MainViewController: AddTaskViewControllerDelegate {
    func createTask(text: String) {
        dataArr.append(DataToDo(title: text))
        createTable()
    }
    
}


