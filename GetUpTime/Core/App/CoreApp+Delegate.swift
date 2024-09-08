//
//  CoreApp+Delegate.swift
//  GetUp
//
//  Created by Rodrigo Souza on 05/09/24.
//

import SwiftUI

extension CoreApp {
    final class Delegate: NSObject, UIApplicationDelegate {
        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
        ) -> Bool {
            
            dump("AppDelegate -> didFinishLaunchingWithOptions")
            return true
        }
    }
}
