
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var navigator: NavigatorImpl!
    private var appAssembly: AppAssembly!
    private var coreComponents: CoreComponents!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        navigator = NavigatorImpl(window: window)
        
        // Setup core components
        coreComponents = CoreComponents(navigator: navigator)
        appAssembly = AppAssembly(coreComponents: coreComponents)
        navigator.appAssembly = appAssembly
    }
}

