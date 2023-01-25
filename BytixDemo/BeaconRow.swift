//
//  BeaconRow.swift
//
//  Created by Vladislav Mashkov on 11.01.2023.
//

import SwiftUI
import Bytix

struct BeaconRow: View {
    
    let beacon: BytixBeacon
    
    var beaconConnected: Bool { beacon.connectionState == .connected }
    var beaconDisconnected: Bool { beacon.connectionState == .disconnected }
    
    var isInfoResponsed: Bool { beacon.deviceId != nil }
    
    var body: some View {
        HStack(spacing: 16) {
            
            BeaconImage()
            
            MainInfoPanel()
            
            Spacer()
            
            SignalPanel()
            
        }
        .frame(height: 100)
        .overlay(
            RoundedRectangle(cornerRadius: 12).stroke(Color.blue, lineWidth: beacon.connectionState == .connected ? 2 : 0)
        )
    }
    
    func BeaconImage() -> some View {
        Image(beaconConnected ? "beacon-connected" : "beacon-found")
            .padding(.leading, 16)
    }
    
    func MainInfoPanel() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Unknown")
                .font(.system(size: 18, weight: .medium))
                .padding([.top], 8)
            HStack(spacing: 8) {
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Device Id:")
                    Text("Group Id:")
                    Text("Realm:")
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("BB123FF1")
                    Text("20005000")
                    Text("cppk")
                }
            }
            .font(.system(size: 14, weight: .regular))
            .padding(.bottom, 8)
            
        }
    }
    
    func SignalPanel() -> some View {
        VStack {
            Text("\(beacon.rssi) dBm")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.yellow)
                .padding(.trailing, 16)
                .padding(.top, 8)
            Spacer()
        }
    }
}

struct BeaconRow_Previews: PreviewProvider {
    static var previews: some View {
        BeaconRow(beacon: .init(rssi: -71,
                                deviceId: "2",
                                connectionState: .connected))
    }
}
