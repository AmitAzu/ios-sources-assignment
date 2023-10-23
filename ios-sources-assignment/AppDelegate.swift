
//  Copyright © 2018 Chegg. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white

        let networkService: INetworkService = NetworkService()
        let cacheService: ICacheService = CacheService()
        let taskService: ITaskService = TaskService(networkService: networkService,
                                                    cacheService: cacheService)
        let homeViewModel = HomeViewModel(taskService: taskService)
        self.window?.rootViewController = UINavigationController(rootViewController: HomeScreenVC(homeVM: homeViewModel))
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) { }
    func applicationDidEnterBackground(_ application: UIApplication) { }
    func applicationWillEnterForeground(_ application: UIApplication) { }
    func applicationDidBecomeActive(_ application: UIApplication) { }
    func applicationWillTerminate(_ application: UIApplication) { }
}

