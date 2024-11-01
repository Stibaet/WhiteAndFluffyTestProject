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
        viewControllers = [generateVC(viewController: RandomPicturesViewController.self,
                                      title: "Pictures", image: UIImage(systemName: "photo")),
                           generateVC(viewController: FavoritePicturesViewController.self,
                                      title: "Favorite", image: UIImage(systemName: "heart"))
        ]
    }
    
    func generateVC(viewController: UIViewController.Type, title: String, image: UIImage?) -> UIViewController {
        let vc = viewController.init()
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
    
    func setupTabBar() {
        view.backgroundColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = .red
    }
    
}
