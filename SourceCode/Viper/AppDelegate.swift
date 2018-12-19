//
//  AppDelegate.swift
//  Viper
//

import UIKit
import IQKeyboardManagerSwift
import CocoaLumberjack
//import MSAL

/// log level for CocoaLumberjack
let defaultDebugLevel = DDLogLevel.all

///
protocol ApplicationDelegate: class {
    
    /// Used to return device token value
    func fetchedApnsDeviceToken(value: String, errorMsg: String?)
    
    /// Used to handle remote notification data
    func didReceiveRemoteNotification(withData data: [AnyHashable: Any], application: UIApplication)
}

///
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// The window for this application
    var window: UIWindow?
    
    /// The file logger used by CocoaLumberjack
    var fileLogger: DDFileLogger?
    
    /// Entery point of architecture
    var mainRouter: MainRouter?
    
    /// Don't assign value to this delegate. It's used in NotificationService.swift. You can use the delegate in that class.
    weak var delegate: ApplicationDelegate?
    
    // MARK: - UIApplication Methods
    
    ///
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Configure Logger
        configureLogger()
        
        // Configure IQKeyboard
        configureIQKeyboard()
        
        //
//        MSALPublicClientApplication
        //
        UINavigationController().navigationBar.setBackgroundImage(UIImage(named: ""), for: .default)
        UINavigationController().navigationBar.shadowImage = UIImage(named: "")
        // MainRouter is the entry point. Override point for customization after application launch.
        guard let window = window else { return true }
        mainRouter = MainRouter(window: window, launchOptions: launchOptions)
        mainRouter?.setInitialViewController()
        return true
    }
    
    ///
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    ///
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    ///
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    ///
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    ///
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - registering notification methods
    
    ///
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        // Shared.sharedInstance.strDeviceToken = deviceTokenString
        // Print it to console
        delegate?.fetchedApnsDeviceToken(value: deviceTokenString, errorMsg: nil)
    }
    
    ///
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("APNs registration failed: \(error)")
        delegate?.fetchedApnsDeviceToken(value: "", errorMsg: error.localizedDescription)
    }
    
    ///
    /*func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     switch application.applicationState {
     case .inactive:
     print("Inactive")
     completionHandler(.newData)
     
     case .background:
     print("Background")
     completionHandler(.newData)
     
     case .active:
     print("Active")
     completionHandler(.newData)
     }
     }*/
    
    // MARK: - receiving notification methods
    
    ///
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable: Any]) {
        delegate?.didReceiveRemoteNotification(withData: data, application: application)
    }
    
    // MARK: - Other Methods
    
    ///
    func configureIQKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    /// Call to configure the logging for this application
    func configureLogger() {
        
        // Create a File Logger
        if let logger = DDFileLogger() {
            logger.rollingFrequency = TimeInterval(60 * 60 * 24)  // 24 hours in seconds
            logger.logFileManager.maximumNumberOfLogFiles = 7
            DDLog.add(logger, with: .info)
            fileLogger = logger
        }
        #if DEBUG
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
        #else
        DDLog.add(DDASLLogger.sharedInstance, with: .error) // ASL = Apple System Logs
        #endif
    }
}

///
extension UIApplication {
    
    /// Gets the top most VC from the base.
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
