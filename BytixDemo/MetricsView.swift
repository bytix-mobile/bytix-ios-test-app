//
//  MetricsView.swift
//  BytixDemo
//
//  Created by Vladislav Mashkov on 18.03.2023.
//

import SwiftUI
import Bytix

struct MetricsView: View {
    
    let metrics: BytixBeacon.BytixMetrics?
    
    var body: some View {
        HStack(spacing: 0) {
            dataCell(sysName: "timer",
                     frame: .init(width: 15, height: 15),
                     data: timeToString()).opacity(0.5)
            Spacer()
            dataCell(sysName: "memorychip",
                     frame: .init(width: 15, height: 12),
                     data: memoryToKB()).opacity(0.5)
            Spacer()
            dataCell(sysName: "point.3.connected.trianglepath.dotted",
                     frame: .init(width: 16, height: 14),
                     data: "\(metrics?.clients ?? 0)").opacity(0.5)
            Spacer()
            dataCell(sysName: "sum",
                     frame: .init(width: 10, height: 15),
                     data: "\(metrics?.totalClients ?? 0)").opacity(0.5)
        }.padding([.leading, .trailing], 18)
    }
    
    func timeToString() -> String {
        guard let time = metrics?.uptime else { return "0" }
        
        let hour   = time / 3600
        let minute = time / 60 % 60
        let second = time % 60
        
        var resultString = ""
        
        if hour > 0                 { resultString += "\(hour) hr " }
        if minute > 0               { resultString += "\(minute) min" }
        if hour == 0 && minute == 0 { resultString += "\(second) sec" }
        
        return resultString
    }
    
    func memoryToKB() -> String {
        guard let memoryBytes = metrics?.freeHeap else { return "0" }
        return "\(memoryBytes / 1024)KB"
    }
    
    func dataCell(sysName: String, frame: CGSize, data: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: sysName)
                .resizable()
                .frame(width: frame.width, height: frame.height)
                .foregroundColor(Color(.label))
                .scaledToFit()
            Text(data)
        }
    }
}

struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView(metrics: nil)
    }
}
