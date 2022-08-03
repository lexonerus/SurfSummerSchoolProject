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
    
    // MARK: Flow setup
    func runMainFlow() {
        self.window?.rootViewController = TabBarConfig().configure()
    }
    
    // MARK: App lifecycle
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App first launch")
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("App initialization")
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        runMainFlow()
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App goes in foreground")
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App running in background and may suspend")
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App moves from backround to foreground but not active")
    }
    func applicationWillTerminate(_ application: UIApplication) {
        print("App terminated")
    }
    
}

