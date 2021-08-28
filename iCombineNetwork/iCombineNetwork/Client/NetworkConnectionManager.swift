/// NetworkConnectionPublisher.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import SystemConfiguration

/// Define a NetworkConnectionManager
public protocol NetworkConnectionManagerType {
    
    /// If there is a network connection or not
    var isConnected: Bool { get }
}

/// Manage the network connection
public struct NetworkConnectionManager: NetworkConnectionManagerType {
    
    public var isConnected: Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    /// Initialize the manager
    public init() {}
}
