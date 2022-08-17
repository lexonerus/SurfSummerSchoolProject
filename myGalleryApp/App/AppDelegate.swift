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
    var coordinator: AppCoordinator?
    
    var tokenStorage: TokenStorage {
        BaseTokenStorage()
    }
    let service = FavoriteService.shared
    
    
    // MARK: App lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
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
            self.runMainFlow(isLoggedIn: true)
            
        } else {
            let tempCredentials = AuthRequestModel(phone: "+71234567890+", password: "qwerty")
            AuthService()
                .performLoginRequestAndSaveToken(credentials: tempCredentials) { [weak self] result in
                    switch result {
                    case .success:
                        self?.runMainFlow(isLoggedIn: true)
                    case .failure:
                        // TODO: Handle error if token was not received
                        self?.runMainFlow(isLoggedIn: false)
                    }
                }
        }
    }
    
    func runLaunchScreen() {
        let lauchScreenViewController = UIStoryboard(name: "LaunchScreen", bundle: .main)
            .instantiateInitialViewController()

        window?.rootViewController = lauchScreenViewController
    }
    
    // MARK: Flow setup
    func runMainFlow(isLoggedIn: Bool) {
        DispatchQueue.main.async {
            let navigationController = UINavigationController()
            self.window?.rootViewController = navigationController
            self.coordinator = AppCoordinator(navigationController)
            if isLoggedIn {
                self.coordinator?.start(isLoggedIn: true)
            } else {
                self.coordinator?.start(isLoggedIn: false)
            }
            
        }

    }

}

