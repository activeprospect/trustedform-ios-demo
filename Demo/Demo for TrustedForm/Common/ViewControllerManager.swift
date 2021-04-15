//
//  ViewControllerManager.swift
//  TrustedForm_Demo
//
//  Created by Konrad Siemczyk on 15/11/2020.
//  Copyright © 2020 Devscale. All rights reserved.
//

import UIKit

final class ViewControllerManager {
    func setInitialViewController(window: UIWindow? = nil) {
        let viewController: WhoIsActiveProspectViewController = UIStoryboard.instantiateInitialViewController()
        let navigationController = TrustedFormNavigationController(rootViewController: viewController)
        setInitial(viewController: navigationController, window: window)
    }

    func setInitial(viewController: UIViewController, window: UIWindow? = nil) {
        let window = window ?? getWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    private func getWindow() -> UIWindow {
        if let window = UIApplication.shared.keyWindow {
            return window
        }
        return UIWindow(frame: UIScreen.main.bounds)
    }
}

extension UIStoryboard {
    static func instantiateInitialViewController<Controller: UIViewController>(name: String? = nil, bundle: Bundle = Bundle.main) -> Controller {
        let controllerName = name ?? String(describing: Controller.self)
        let storyboard = UIStoryboard(name: controllerName, bundle: bundle)
        guard let controller = storyboard.instantiateInitialViewController() as? Controller else {
            fatalError("Couldn't instantiate \(controllerName)")
        }
        return controller
    }
}
