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
                .font(.system(size: 18, weight: .medium))
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
            .font(.system(size: 14, weight: .regular))
            .padding(.bottom, 8)
            
        }
    }
    
    func SignalPanel() -> some View {
        VStack {
            Text(rssiText)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(beacon.approximateDistance == .close ? Color("beaconCloseColor") : beacon.approximateDistance == .near ? Color("beaconMediumColor") : Color("beaconFarColor"))
                .padding(.trailing, 16)
                .padding(.top, 8)
            Spacer()
        }
    }
    
    var rssiText: String {
        if let rssi = beacon.rssi {
            return "\(rssi) dBm"
        } else {
            return "---"
        }
    }
}

struct BeaconRow_Previews: PreviewProvider {
    static var previews: some View {
        BeaconRow(beacon: BytixBeacon(rssi: -54, deviceName: nil,
                                      deviceId: "ffd52f3", groupId: nil,
                                      realm: "cppk",
                                      connectionState: .connected))
    }
}
