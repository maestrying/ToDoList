//
//  TabBarController.swift
//  ToDoList
//
//  Created by Дывак Максим on 22.04.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        selectedIndex = 1
        tabBar.backgroundColor = .gray.withAlphaComponent(0.2)
    }
    
    // MARK: - Tab setup
    private func setupTabs() {
        let mainVC = MainViewController()
        let favoriteVC = FavoriteTasksViewController()
        let settingsVC = SettingsViewController()
        
        favoriteVC.delegate = mainVC
        
        let favorites = createNav(title: "Избранные", image: UIImage(systemName: "star.fill"), viewController: favoriteVC)
        let main = createNav(title: "Задачи", image: UIImage(systemName: "list.dash"), viewController: mainVC)
        let settings = createNav(title: "Настройки", image: UIImage(systemName: "gearshape.fill"), viewController: settingsVC)
        
        setViewControllers([favorites, main, settings], animated: true)
        
    }
    
    private func createNav(title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = image
        navigation.viewControllers.first?.navigationItem.title = title
        
        return navigation
        
    }

}
