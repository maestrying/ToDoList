//
//  MainViewController.swift
//  ToDoList
//
//  Created by Дывак Максим on 19.04.2024.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Data initial
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [TaskEntity]()
    
    
    // MARK: - Properties
    var tasksTableView: UITableView!
    let identifier = "MyTable"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllItems()
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
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        return cell
    }
    
    // MARK: When touch cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presentTaskViewController = PresentTaskViewController()
        let selectedTask = models[indexPath.row]
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
            let selectedTask = self.models[indexPath.row]
            self.deleteItem(item: selectedTask)
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
    

    // MARK: - CRUD
    
    func getAllItems() {
        do {
            models = try context.fetch(TaskEntity.fetchRequest())
            
            DispatchQueue.main.async {
                self.tasksTableView.reloadData()
            }
        }
        catch {
            // Error
        }
    }
    
    func createItem(title: String, descr: String) {
        let newItem = TaskEntity(context: context)
        newItem.title = title
        newItem.descr = descr
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func deleteItem(item: TaskEntity) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func updateItem(item: TaskEntity, newTitle: String, newDescr: String) {
        item.title = newTitle
        item.descr = newDescr
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }


}


// MARK: - Extentions

extension MainViewController: AddTaskViewControllerDelegate {
    func createTask(text: String, descr: String) {
        createItem(title: text, descr: descr)
    }
    
}

extension MainViewController: PresentTaskViewControllerDelegate {
    func updateTask(item: TaskEntity, title: String, description: String) {
        updateItem(item: item, newTitle: title, newDescr: description)
    }
    
    func deleteTask(at index: IndexPath) {
        deleteItem(item: models[index.row])
        tasksTableView.deleteRows(at: [index], with: .automatic)
    }

}


