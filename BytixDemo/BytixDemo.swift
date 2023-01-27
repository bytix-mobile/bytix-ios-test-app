//
//  BytixDemo.swift
//  BytixDemo
//
//  Created by Denis Gryzlov on 30.03.2022.
//

import SwiftUI

@main
struct BytixDemo: App {
        
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init())
        }
    }
}
