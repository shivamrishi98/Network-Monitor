//
//  NetworkMonitor.swift
//  NetworkMonitor
//
//  Created by Shivam Rishi on 10/03/21.
//

import Foundation
import Network

final class NetworkMonitor {
    
    private var monitor: NWPathMonitor?

    public private(set) var isConnected:Bool = false
    
    public private(set) var connectionType:ConnectionType = .unknown
    public private(set) var lowDataMode:Bool = false
    public private(set) var hotspotMode:Bool = false

    
    public enum ConnectionType:String {
        case cellular = "Cellular"
        case wifi = "Wifi"
        case ethernet = "Ethernet"
        case unknown = "Unknown"
    }
    
    
    public func startMonitoring() {
        monitor = NWPathMonitor()
        
        guard let monitor = monitor else {
            return
        }
        
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            self?.checkLowDataMode(path)
            self?.checkForHotspot(path)
            NotificationCenter.default.post(name: NSNotification.Name("connectionType"),
                                            object: nil)
        }
    }
    
    public func stopMonitoring() {
        monitor?.cancel()
        monitor = nil
    }
    
    private func getConnectionType(_ path:NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
        
    }
    
    private func checkLowDataMode(_ path:NWPath) {
        lowDataMode = path.isConstrained
    }
    
    private func checkForHotspot(_ path:NWPath) {
        hotspotMode = path.isExpensive
    }
    
}
