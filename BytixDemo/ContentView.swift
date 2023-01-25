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
            Background()
            
            if !viewModel.hasDevice {
                EmptyState()
            } else {
                DeviceList()
            }
            
            BottomTrailingButton()
        }
    }
    
    func Background() -> some View {
        Color("backgroundColor")
            .ignoresSafeArea()
    }
    
    func EmptyState() -> some View {
        ZStack {
            TopTrailingLogo()
            VStack {
                Image("bgImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                Text(viewModel.isScanning ? "Идет сканирование\nустройств..." : "Запустите сканирование,\nчтобы найти устройства рядом")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.label))
                    .font(.system(size: 18, weight: .regular))
            }
            
        }
        
    }
    
    func DeviceList() -> some View {
        VStack(spacing: 16) {
            ForEach(viewModel.beacons, id: \.self) { beacon in
                BeaconRow(beacon: beacon)
            }
        }.padding(16)
    }
    
    func BottomTrailingButton() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ButtonScan()
                    .padding(.trailing, 32)
                    .padding(.bottom, 32)
            }
            
        }
    }
    
    func TopTrailingLogo() -> some View {
        VStack {
            HStack {
                Spacer()
                Image("logo").padding(.trailing, 24)
            }
            Spacer()
        }
    }
    
    func ButtonScan() -> some View {
        Button(action: {
            if viewModel.isScanning {
                viewModel.stopScan()
            } else {
                viewModel.startScan()
            }
        }, label: {
            Circle()
                .fill(Color("scanButtonColorBg"))
                .frame(width: 60, height: 60)
                .overlay(
                    ZStack {
                        if viewModel.isScanning {
                            Image(systemName: "pause.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 24)
                        } else {
                            Image(systemName: "play.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 24)
                                .padding(.leading, 5)
                        }
                    }
                )
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
