//
//  DemoAppApp.swift
//  DemoApp
//
//  Created by Denis Gryzlov on 30.03.2022.
//

import SwiftUI

@main
struct DemoApp: App {
        
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init())
        }
    }
}
