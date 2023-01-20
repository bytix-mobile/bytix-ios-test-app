//
//  RadarLoader.swift
//  DemoApp
//
//  Created by Vladislav Mashkov on 11.01.2023.
//

import SwiftUI

struct RadarLoader: View {
    
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.green.opacity(0.5))
            Circle()
                .strokeBorder(Color.white, lineWidth: 1)
                .frame(width: 30, height: 30)
            Circle()
                .strokeBorder(Color.white, lineWidth: 1)
                .frame(width: 20, height: 20)
            Circle()
                .strokeBorder(Color.white, lineWidth: 1)
                .frame(width: 10, height: 10)
        }
        .animation(.linear.repeatForever(), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }
}

struct RadarLoader_Previews: PreviewProvider {
    static var previews: some View {
        RadarLoader()
    }
}
