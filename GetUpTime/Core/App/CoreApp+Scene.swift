//
//  CoreApp+Scene.swift
//  GetUp
//
//  Created by Rodrigo Souza on 05/09/24.
//

import UIKit

extension CoreApp {
    class Scene: UIResponder, UIWindowSceneDelegate {
        func windowScene(
            _ windowScene: UIWindowScene,
            performActionFor shortcutItem: UIApplicationShortcutItem,
            completionHandler: @escaping (Bool) -> Void
        ) {
            completionHandler(true)
        }
    }
}
