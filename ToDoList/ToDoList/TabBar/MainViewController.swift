//
//  MainViewController.swift
//  ToDoList
//
//  Created by Дывак Максим on 19.04.2024.
//

import UIKit


// MARK: - Data
struct DataToDo {
    var title: String
}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Data initial
    var dataArr: [DataToDo] = []
    
    
    // MARK: - Properties
    var tasksTableView: UITableView!
    let identifier = "MyTable"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    
    // MARK: - methods
    
    private func setupLayout() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    
        createTable()
    }
    
    private func createTable() {
        tasksTableView = UITableView(frame: view.bounds)
        tasksTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tasksTableView)
    }
    
    
    // MARK: Table methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row].title
        return cell
    }
    
    // MARK: When touch cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presentTaskViewController = PresentTaskViewController()
        let selectedTask = dataArr[indexPath.row]
        presentTaskViewController.dataToDo = selectedTask
        tableView.deselectRow(at: indexPath, animated: true)
        
        presentTaskViewController.delegate = self
        presentTaskViewController.taskIndex = indexPath
        
        presentTaskViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(presentTaskViewController, animated: true)
    }
    
    // MARK: Gesture for delete task
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { action, view, completionHandler in
            self.dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    @objc func addTask() {
        let addTaskViewController = AddTaskViewController()
        addTaskViewController.delegate = self
        self.present(addTaskViewController, animated: true)
    }


}


// MARK: - Extentions

extension MainViewController: AddTaskViewControllerDelegate {
    func createTask(text: String) {
        dataArr.append(DataToDo(title: text))
        tasksTableView.reloadData()
    }
    
}

extension MainViewController: PresentTaskViewControllerDelegate {
    func deleteTask(at index: IndexPath) {
        dataArr.remove(at: index.row)
        tasksTableView.deleteRows(at: [index], with: .automatic)
    }

}


