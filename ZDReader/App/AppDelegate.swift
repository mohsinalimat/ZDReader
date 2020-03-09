//
//  AppDelegate.swift
//  ZDReader
//
//  Created by Noah on 16/9/16.
//  Copyright © 2016年 ZD. All rights reserved.
//

import UIKit
import RxSwift


let rightScaleX:CGFloat = 0.2
let rootVCKey = "rootVCKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var lastTabVC:UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
            let tabBarVC = ZSTabBarController()
            window?.rootViewController = tabBarVC
            window?.makeKeyAndVisible()

        
        
        UIApplication.shared.setStatusBarHidden(false, with: .fade)
        #if DEBUG
            let fpsLabel = V2FPSLabel(frame: CGRect(x:15, y:ScreenHeight-40, width:55,height: 20));
            self.window?.addSubview(fpsLabel);
        #else
        #endif

        /**
         设置 UINavigationNar 外观
         */
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor ( red: 0.7235, green: 0.0, blue: 0.1146, alpha: 1.0 )
        UIApplication.shared.statusBarStyle = .lightContent
        
    
        
        return true
    }
    
    func configureDataBase(){
        let store  = YTKKeyValueStore(dbWithName: dbName)
        
        if store?.isTableExists(searchHistory) == false {
            store?.createTable(withName: searchHistory)
        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .all
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


