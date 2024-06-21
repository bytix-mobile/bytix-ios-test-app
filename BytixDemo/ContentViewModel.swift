//
//  ContentViewModel.swift
//
//  Created by Vladislav Mashkov on 11.01.2023.
//

import SwiftUI
import Bytix

final class ContentViewModel: ObservableObject {
    
    @Published var isScanning: Bool = false
    @Published var beacons: [BytixBeacon] = []
    @Published var hasDevice: Bool = false
    
    let btxManager: BytixSDK
    
    init() {
        self.btxManager = BytixSDK("BAA2A494-4BC6-4071-9723-403D06A8AC85")
        self.btxManager.delegate = self
    }
    
    var sortedBeacons: [BytixBeacon] {
        beacons.sorted { $0.rssi ?? -1000 > $1.rssi ?? -1000 }
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
    func didUpdatedBeacons() {
        beacons = btxManager.getBeacons()
        hasDevice = !beacons.isEmpty
    }
}
