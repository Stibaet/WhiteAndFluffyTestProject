//
//  MainTabBarController.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewControllerToTabBar()
        setupTabBar()
    }
}

//MARK: - private methods
private extension MainTabBarController {
    func addViewControllerToTabBar() {
        viewControllers = [
            generateNavController(for: RandomPicturesViewController(),
                                  title: "Pictures",
                                  image: UIImage(systemName: "photo")),
            generateNavController(for: FavoritePicturesViewController(),
                                  title: "Favorite",
                                  image: UIImage(systemName: "heart"))
        ]
    }
    
    func generateNavController(for rootViewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .red
    }
    
}
