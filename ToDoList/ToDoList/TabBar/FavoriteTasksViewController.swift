//
//  FavoriteTasksViewController.swift
//  ToDoList
//
//  Created by Дывак Максим on 20.04.2024.
//

import UIKit

protocol FavoriteTasksDelegate: AnyObject {
    func getAllFavoriteTasks() -> [TaskEntity]
    func getAllTasks()
}

class FavoriteTasksViewController: UIViewController {
    
    weak var delegate: FavoriteTasksDelegate?
    var favoriteTasksTable: UITableView!
    let identifier = "FavoriteCell"
    var favoriteTasks = [TaskEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let delegate = self.delegate {
            favoriteTasks = delegate.getAllFavoriteTasks()
        }
        favoriteTasksTable.reloadData()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        
        createTable()
    }
    
    private func createTable() {
        favoriteTasksTable = UITableView(frame: view.bounds)
        favoriteTasksTable.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        favoriteTasksTable.dataSource = self
        favoriteTasksTable.delegate = self
        favoriteTasksTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(favoriteTasksTable)
    }

}

extension FavoriteTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = favoriteTasks[indexPath.row].title
        return cell
    }
    
    
}
