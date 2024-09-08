//
//  GetUpTimeApp.swift
//  GetUpTime
//
//  Created by Rodrigo Souza on 07/09/24.
//

import SwiftUI
import UIKitNavigation

@main
struct GetUpTimeApp: App {
    var body: some Scene {
        WindowGroup {
            UIViewControllerRepresenting {
                HomeView()
            }
        }
    }
}
