//
//  AppDelegate.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 05.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    enum AppState: String {
        case firstLaunch
        case signedIn
        case signedOut
    }
    
    var appState: AppState {
        get {
            if let rawState = UserDefaults.standard.string(forKey: "appState") {
                return AppState(rawValue: rawState) ?? .firstLaunch
            }
            return .firstLaunch
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "appState")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        switch appState {
        case .firstLaunch:
            self.window?.rootViewController = UINavigationController(rootViewController: FirstOnboarding())
        case .signedIn:
            self.window?.rootViewController = UINavigationController(rootViewController: MainTabBarVC())
        case .signedOut:
            self.window?.rootViewController = UINavigationController(rootViewController: WelcomePage())
        }

        return true
    }
}
