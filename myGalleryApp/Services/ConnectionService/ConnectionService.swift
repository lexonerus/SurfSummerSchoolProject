//
//  ConnectionService.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 20.08.2022.
//

import Foundation
import Network

class ConnectionService {
    
    // MARK: Properties
    static let shared            = ConnectionService()
    let monitor                  = NWPathMonitor()
    private(set) var isConnected = false
    
    // MARK: Methods
    func startMonitoring() {
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Connected")
                self.isConnected = true
            } else {
                print("No connection")
                self.isConnected = false
            }

            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
}
