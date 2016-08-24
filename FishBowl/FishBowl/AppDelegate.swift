
import UIKit
import Material
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
    var accountAccess: Bool? = true
    static var token:String?
    let dataManager : DataManager = DataManager()
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Slide)

        createViewControllerStack()
        
        self.window!.tintColor = MaterialColor.green.accent4

        return true

    }
    
    private func createViewControllerStack() {
    if window == nil {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
    }
    let eventsViewController = EventsViewController ()
    let navigationController: AppNavigationController = AppNavigationController(rootViewController: eventsViewController)
    let statusBarController: StatusBarController = StatusBarController(rootViewController: navigationController)
    let contactsViewController = ContactsViewController ()
    let navigationDrawerController: AppNavigationDrawerController = AppNavigationDrawerController (rootViewController: statusBarController, leftViewController: contactsViewController)
    
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window!.rootViewController = navigationDrawerController
    
    window!.makeKeyAndVisible()
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        if (url.host == "CardBowlTest") {
            OAuthSwift.handleOpenURL(url)
            //Dismiss webview once url is passed to extract authorization code
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
        
        self.window = nil
        createViewControllerStack()
        
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.window?.endEditing(true)
    }
    
}

