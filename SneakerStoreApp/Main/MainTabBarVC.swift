//
//  MainTabBarVC.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 08.06.2023.
//

import UIKit

class MainTabBarVC: UITabBarController {
    static let shared = MainTabBarVC()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.extendedLayoutIncludesOpaqueBars = true
        self.tabBarController?.moreNavigationController.isNavigationBarHidden = true
        edgesForExtendedLayout = .top
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = .white
        tabBar.barTintColor = .white
        setupTabBar()
    }
    func setupTabBar() {
        let catalogViewController = UINavigationController(rootViewController: CatalogViewController())
        catalogViewController.tabBarItem.image = UIImage(named: "Vector1")
        catalogViewController.tabBarItem.selectedImage = UIImage(named: "Vector1.1")
        catalogViewController.tabBarItem.title = lables(text: "Catalog")

        
        let cartViewController = UINavigationController(rootViewController: CartVC())
        cartViewController.tabBarItem.image = UIImage(named: "Vector2")
        cartViewController.tabBarItem.selectedImage = UIImage(named: "Vector2.1")
        cartViewController.tabBarItem.title = lables(text: "Cart")
 
        
        let profileViewController = UINavigationController(rootViewController: ProfileVC())
        profileViewController.tabBarItem.image = UIImage(named: "Vector3")
        profileViewController.tabBarItem.selectedImage = UIImage(named: "Vector3.1")
        profileViewController.tabBarItem.title = lables(text: "Profile")


        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        viewControllers = [catalogViewController, cartViewController, profileViewController]

    }
     
    func lables(text: String) -> String {
        let lable = UILabel()
        lable.text = text
        lable.font.withSize(10)
        lable.textColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        return lable.text!
    }
}
