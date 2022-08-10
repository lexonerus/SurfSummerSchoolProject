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
    var tokenStorage: TokenStorage {
        BaseTokenStorage()
    }
    let service = FavoriteService.shared
    
    // MARK: Flow setup
    func runMainFlow() {        
        //self.window?.rootViewController = TabBarConfig().configure()
        DispatchQueue.main.async {
            self.window?.rootViewController = TabBarConfig().configure()
        }
    }
    
    // MARK: App lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //print("App initialization")
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        service.loadDataFromUserDefaults()
        startApplicationProcess()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("App will terminated")
        service.saveDataToUserDefaults()
    }
    
    func startApplicationProcess() {
        runLaunchScreen()
        
        if let tokenContainer = try? tokenStorage.getToken(), !tokenContainer.isExpired {
            runMainFlow()
        } else {
            let tempCredentials = AuthRequestModel(phone: "+71234567890", password: "qwerty")
            AuthService()
                .performLoginRequestAndSaveToken(credentials: tempCredentials) { [weak self] result in
                    switch result {
                    case .success:
                        self?.runMainFlow()
                    case .failure:
                        // TODO: Handle error if token was not received
                        break
                    }
                }
        }
    }
    
    func runLaunchScreen() {
        let launchScreenViewController = UIStoryboard(name: "LaunchScreen", bundle: .main)
            .instantiateInitialViewController()
        window?.rootViewController = launchScreenViewController
    }
    
    /*
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
     //print("App first launch")
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
    */
    

    
    
}

