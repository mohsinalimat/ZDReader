//
//  ZSTabBarController.swift
//  ZDReader
//
//  Created by Noah on 2019/6/18.
//  Copyright © 2019年 ZD. All rights reserved.
//

import UIKit

class ZSTabBarController: UITabBarController,UITabBarControllerDelegate {

    var lastSelectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setupSubviews() {
        let homeItem = UITabBarItem(title: "书架", image: UIImage(named: "tab_bookshelf")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_bookshelf_sel")?.withRenderingMode(.alwaysOriginal))
        let mineItem = UITabBarItem(title: "我的", image: UIImage(named: "tab_profile")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tab_profile_sel")?.withRenderingMode(.alwaysOriginal))
        
        let homeVC = ZSBookShelfViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = homeItem
        
        let mineVC = ZSMineViewController()
        let mineNav = UINavigationController(rootViewController: mineVC)
        mineNav.tabBarItem = mineItem
        
        viewControllers = [homeNav, mineNav]
        for (_, item) in tabBar.items!.enumerated() {
            let normalAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.0)]
            let selectedAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(hexString: "#A70B0B")]
            item.setTitleTextAttributes(normalAttributes, for: .normal)
            item.setTitleTextAttributes(selectedAttributes as [NSAttributedString.Key : Any], for: .selected)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let baseNav = viewController as? UINavigationController else {
            return
        }
        guard let _ = baseNav.topViewController as? BaseViewController else {
            return
        }
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        lastSelectedIndex = selectedIndex
        if let index = tabBar.items?.index(of: item) {
            guard let navController = viewControllers?[index] as? UINavigationController else {
                return
            }
            guard let viewController = navController.topViewController as? BaseViewController else {
                return
            }
//            if viewController.needsLogin {
//
//            }
        }
    }

}
