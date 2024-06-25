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
    var beaconDiscovered: Bool { beacon.connectionState == .discovered }
    
    var isInfoResponsed: Bool { beacon.deviceId != nil }
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 16) {
                
                BeaconImage()
                
                MainInfoPanel()
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    SignalPanel()
                    IdentifierMark()
                    Spacer()
                }
                .padding(.trailing, 16)
                .padding(.top, 16)
                
            }
            .frame(height: 80)
            if let metrics = beacon.metrics {
                MetricsView(metrics: metrics)
                    .padding(.bottom, 8)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12).stroke(strokeColor,
                                                      lineWidth: beaconDiscovered ? 0 : 2)
        )
        .background(
            RoundedRectangle(cornerRadius: 12).fill(Color("cellBackgroundColor"))
        )
    }
    
    func BeaconImage() -> some View {
        Image(beaconConnected ? "beacon-connected" : "beacon-found")
            .padding(.leading, 16)
    }
    
    func MainInfoPanel() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(beacon.deviceName ?? "unknown")
                .foregroundColor(Color(.label))
                .font(.system(size: 14, weight: .medium))
                .padding([.top], 8)
                .opacity(beacon.deviceName == nil ? 0.5 : 1)
            HStack(spacing: 8) {
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Device Id:")
                    Text("Group Id:")
                    Text("Realm:")
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(beacon.deviceId?.uppercased() ?? "unknown")
                        .opacity(beacon.deviceId == nil ? 0.5 : 1)
                    Text(beacon.groupId ?? "unknown")
                        .opacity(beacon.groupId == nil ? 0.5 : 1)
                    Text(beacon.realm ?? "unknown")
                        .opacity(beacon.realm == nil ? 0.5 : 1)
                }.foregroundColor(Color(.label))
            }
            .font(.system(size: 11, weight: .regular))
            .padding(.bottom, 8)
            
        }.foregroundColor(Color(.label))
    }
    
    func SignalPanel() -> some View {
        Text(rssiText)
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(beacon.approximateDistance == .close ? Color("beaconCloseColor") : beacon.approximateDistance == .near ? Color("beaconMediumColor") : Color("beaconFarColor"))
    }
    
    func IdentifierMark() -> some View {
        Text(beacon.shortIdentifier)
            .font(.system(size: 12))
            .foregroundStyle(Color(.label))
            .opacity(0.5)
    }
    
    var rssiText: String {
        if let rssi = beacon.rssi {
            return "\(rssi) dBm"
        } else {
            return "---"
        }
    }
    
    var strokeColor: Color {
        switch beacon.connectionState {
        case .connected: Color.blue
        case .connecting: Color.yellow
        case .disconnected: Color.red
        case .disconnecting: Color.orange
        default: Color.clear
        }
    }
}

struct BeaconRow_Previews: PreviewProvider {
    static var previews: some View {
        BeaconRow(beacon: BytixBeacon(rssi: -54, deviceName: nil,
                                      deviceId: "ffd52f3", groupId: nil,
                                      realm: "cppk", shortIdentifier: "DBG-186090", metrics: nil,
                                      connectionState: .connected))
    }
}
