//
//  NeworkMonitor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.06.2022.
//

import Network

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    private var isReachable: Bool { status == .satisfied }
    
    private init() {}
    
    func monitorInternetConnection(_ compleation: @escaping (Bool) -> ()) {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self.status = path.status
            if self.isReachable {
                print("DEBUG::: status is \(self.status)")
                DispatchQueue.main.async {
                    compleation(true)
                }
            } else {
                print("DEBUG::: status is \(self.status)")
                DispatchQueue.main.async {
                    compleation(false)
                }
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    
}
