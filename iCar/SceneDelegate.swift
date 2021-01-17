import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        var builder = Builder<ManufacturerViewModel, CarModelsViewModel>.manufacturers
        builder.navigationController = UINavigationController()
        builder.build { [unowned self] manufacurerViewController in
            builder.navigationController?.viewControllers = [manufacurerViewController]
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            self.window?.rootViewController = builder.navigationController
            self.window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

