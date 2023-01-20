//
//  ContentViewModel.swift
//  DemoApp
//
//  Created by Vladislav Mashkov on 11.01.2023.
//

import SwiftUI
import Bytix

final class ContentViewModel: ObservableObject {
    
    @Published var isScanning: Bool = false
    @Published var beacons: [BytixBeacon] = []
    
    let btxManager: BytixSDK
    
    init() {
        self.btxManager = BytixSDK("BAA2A494-4BC6-4071-9723-403D06A8AC85")
        self.btxManager.delegate = self
    }
    
    func startScan() {
        guard !isScanning else { return }
        isScanning = true
        
        btxManager.startScanning()
    }
    
    func stopScan() {
        guard isScanning else { return }
        isScanning = false
        
        btxManager.stopScanning()
    }
    
    
}

extension ContentViewModel: BytixDelegate {
    
    func bytix(connectedTo device: BytixBeacon) {
        print("con")
    }
    
    func bytix(disconnectedFrom device: BytixBeacon) {
        print("dis")
    }
    
    func bytix(lost device: BytixBeacon) {
       print("los")
    }
    
    func didUpdatedBeacons() {
        beacons = btxManager.getBeacons()
    }
}
