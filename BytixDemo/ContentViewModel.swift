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
    
    let btxManager: BytixSDK
    
    init() {
        self.btxManager = BytixSDK("BAA2A494-4BC6-4071-9723-403D06A8AC85")
        self.btxManager.delegate = self
    }
    
    var sortedBeacons: [BytixBeacon] {
        beacons.sorted { $0.rssi ?? -1000 > $1.rssi ?? -1000 }
    }
    
    var hasDevice: Bool {
        !beacons.isEmpty
    }
    
    var autoConnectionEnabled: Bool {
        btxManager.autoConnection
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
    
    func didBeaconTap(_ beacon: BytixBeacon) {
        if beacon.connectionState == .connected || beacon.connectionState == .connecting {
            btxManager.disconnectFrom(beacon)
            return
        }
        
        if beacon.connectionState == .disconnected || beacon.connectionState == .discovered {
            btxManager.connectTo(beacon)
            return
        }
    }
    
    func toggleAutoConnection() {
        btxManager.autoConnection.toggle()
        objectWillChange.send()
    }
}

extension ContentViewModel: BytixDelegate {
    func didUpdatedBeacons() {
        withAnimation(.easeInOut(duration: 0.2)) {
            beacons = btxManager.getBeacons()
        }
    }
    
    func bytix(update RSSI: Int, for device: BytixBeacon) {
        if let currentBeaconIndex = beacons.firstIndex(where: { $0.shortIdentifier == device.shortIdentifier }) {
            
            let rssiDeltaTreshold = 9
            let rssiDeltaTresholdSqrt = rssiDeltaTreshold * rssiDeltaTreshold
            
            // Для оптимизации обновляем значения сигнала при значительных изменениях
            let diff = RSSI - (beacons[currentBeaconIndex].rssi ?? -200)
            let diffSqrt = diff * diff
            if diffSqrt >= rssiDeltaTresholdSqrt { beacons[currentBeaconIndex].rssi = RSSI }
        }
    }
}
