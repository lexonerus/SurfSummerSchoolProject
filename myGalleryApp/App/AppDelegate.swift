//
//  AppDelegate.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 02.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: App lifecycle
    
    // 1
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App first launch")
        return true
    }
    
    // 2
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("App initialization")
        let window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController = MainViewController()
        let navi = UINavigationController(rootViewController: initialViewController)
        window.rootViewController = navi
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    // 3
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App goes in foreground")
    }
    
    // 4
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App running in background and may suspend")
    }
    
    // 5
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App moves from backround to foreground but not active")
    }
    
    // 6
    func applicationWillTerminate(_ application: UIApplication) {
        print("App terminated")
    }
    
    
    


}

