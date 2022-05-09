//
//  SceneDelegate.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 27/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // For testing
        // let wishItemDataStore = WishItemDummyDataStore()
        // let wishCategoryDataStore = WishCategoryDummyDataStore()
        
        // For production
        let controller = CoreDataPersistentController.instance
        let wishItemDataStore = WishItemCoreDataStore(controller: controller)
        let wishCategoryDataStore = WishCategoryCoreDataStore(controller: controller)
        
        // Setup observables
        let wishItemsObservable = WishItemsObservable(dataStore: wishItemDataStore)
        let wishCategoriesObservable = WishCategoriesObservable(dataStore: wishCategoryDataStore)
        
        // MainStoryboard
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        // RootViewController
        let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "MyViewController") as! ViewController
        rootViewController.wishItemsObservable = wishItemsObservable
        rootViewController.wishCategoriesObservable = wishCategoriesObservable

        // NavigationController
        let navigationController = mainStoryboard.instantiateViewController(withIdentifier: "MyNavigationController") as! UINavigationController
        navigationController.viewControllers = [rootViewController]
        
        // self.window
        self.window = UIWindow(windowScene: windowScene)

        self.window!.rootViewController = navigationController

        self.window!.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
    }


}

