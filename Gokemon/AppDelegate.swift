//
//  AppDelegate.swift
//  Gokemon
//
//  Created by Jan Sebastian on 16/04/24.
//

import UIKit
import GoogleSignIn


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = SplashScreenViewController()
        self.window?.makeKeyAndVisible()
        #if DEBUG
            if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
                // Code only executes when tests are running
                CoreDataStack.shared.doTestSetup()
                registerDependInjec()
            } else {
                print("work on unit test mode")
                registerDependInjec()
            }
        #else
            CoreDataStack.shared.doTestSetup()
            registerDependInjec()
        #endif
        
        GIDSignIn.sharedInstance.restorePreviousSignIn(completion: { [weak self] user, error in
            
            if let error {
                print("GIDSignIn restorePreviousSignIn error: \(error.localizedDescription)")
                self?.window?.rootViewController = LoginViewController()
            } else {
                if let user {
                    let nav = UINavigationController(rootViewController: HomeViewController())
                    nav.navigationBar.isHidden = true
                    self?.window?.rootViewController = nav
                } else {
                    self?.window?.rootViewController = LoginViewController()
                }
            }
            self?.window?.makeKeyAndVisible()
        })
        
        
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool

        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }
        
        return false
    }

    private func registerDependInjec() {
        ServiceContainer.register(type: GokemonUseCase.self, GokemonUseCaseImpl())
        ServiceContainer.register(type: GokemonLocalUseCase.self, GokemonLocalUseCaseImpl())
        ServiceContainer.register(type: AuthUseCase.self, AuthUseCaseImpl())
    }

}

