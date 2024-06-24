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
            
            Content()
        }
    }
}

// MARK: - View building
private extension ContentView {
    func Background() -> some View {
        Color("backgroundColor")
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    func Content() -> some View {
        if !viewModel.hasDevice {
            EmptyState()
        } else {
            DeviceList()
        }
        
        BottomTrailingButtons()
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
}

// MARK: - Components
private extension ContentView {
    func DeviceList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(viewModel.sortedBeacons, id: \.self) { beacon in
                    Button {
                        viewModel.didBeaconTap(beacon)
                    } label: {
                        BeaconRow(beacon: beacon)
                    }
                }
                Spacer()
            }.padding(16)
        }
    }
    
    func BottomTrailingButtons() -> some View {
        VStack {
            Spacer()
            HStack(spacing: 16) {
                Spacer()
                ButtonAutoConnectState()
                ButtonScan()
            }
            .padding(.trailing, 32)
            .padding(.bottom, 32)
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
    
    func ButtonAutoConnectState() -> some View {
        Button(action: {
            viewModel.toggleAutoConnection()
        }, label: {
            Circle()
                .fill(Color("scanButtonColorBg"))
                .frame(width: 60, height: 60)
                .overlay(
                    ZStack {
                        if viewModel.autoConnectionEnabled {
                            Image(systemName: "wifi.circle")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                        } else {
                            Image(systemName: "wifi.exclamationmark.circle")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                        }
                    }
                )
        })
    }
}

#Preview {
    ContentView(viewModel: .init())
}

