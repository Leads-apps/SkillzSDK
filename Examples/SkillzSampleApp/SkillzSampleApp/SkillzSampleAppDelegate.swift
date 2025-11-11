#if canImport(UIKit)
import UIKit
import Skillz

@UIApplicationMain
final class SkillzSampleAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SkillzSampleViewController(gameId: "123_456", environment: .sandbox)
        window?.makeKeyAndVisible()
        return true
    }
}
#endif
