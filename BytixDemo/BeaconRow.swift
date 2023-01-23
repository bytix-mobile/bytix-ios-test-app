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
        HStack {
            
            Image("beacon")
                .resizable()
                .frame(width: 64, height: 64)
                .padding(.leading, 8)
            
            VStack(alignment: .leading) {
                if isInfoResponsed {
                    Text("Device id: \(beacon.deviceId!)")
                        .foregroundColor(.green)
                        .font(.system(size: 15)).bold()
                } else {
                    Text("No info about device")
                        .foregroundColor(.red)
                        .font(.system(size: 15)).bold()
                }
                
                HStack(alignment: .center) {
                    Text(beacon.connectionState.rawValue)
                        .foregroundColor(beaconConnected ? .green : .gray)
                }
                
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(beacon.approximateDistance)
                    .font(.system(size: 12).bold())
                    .foregroundColor(.accentColor)
                Text(String(beacon.rssi))
                    .font(.system(size: 10))
            }.padding(.trailing, 8)
            
        }
        .padding([.top, .bottom], 8)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(beaconDisconnected ? Color.red : beaconConnected ? Color.green : Color.gray, lineWidth: 2)
        )
        
            
    }
}

struct BeaconRow_Previews: PreviewProvider {
    static var previews: some View {
        BeaconRow(beacon: .init(rssi: -71,
                                deviceId: "2",
                                connectionState: .connected))
    }
}
