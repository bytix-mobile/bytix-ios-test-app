//
//  ContentView.swift
//
//  Created by Denis Gryzlov on 30.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        ZStack {
            Color(red: 50/255, green: 49/255, blue: 57/255).ignoresSafeArea()
            VStack {
                ZStack(alignment: .top) {
                    if viewModel.isScanning {
                        ScanIndicator()
                            .padding(.trailing, 16)
                    }
                    
                    DeviceList()
                        .padding([.leading, .trailing], 16)
                }
                Spacer()
                ButtonPanel()
            }
            Image("logo")
        }
    }
    
    func DeviceList() -> some View {
        ForEach(viewModel.beacons, id: \.self) { beacon in
            BeaconRow(beacon: beacon)
        }
        .padding(.top, 38)
    }
    
    func ButtonPanel() -> some View {
        HStack() {
            
            
            Spacer()
            
            Button {
                withAnimation(.linear) {
                    if viewModel.isScanning {
                        viewModel.stopScan()
                    } else {
                        viewModel.startScan()
                    }
                }
            } label: {
                Text(viewModel.isScanning ? "STOP SCAN" : "START SCAN")
                    .padding()
                    .font(.system(size: 18, weight: .bold))
            }
            .background(Color.blue.opacity(0.3))
            .cornerRadius(16)
            
            Spacer()
            
        }
    }
    
    func ScanIndicator() -> some View {
        HStack {
            Text("Идет сканирование...")
                .foregroundColor(.white)
            RadarLoader()
        }.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func DataPanel() -> some View {
        HStack {}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
