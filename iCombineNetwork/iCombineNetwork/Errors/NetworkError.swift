/// NetworkError.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import Foundation

/// Generic network error thrown by URLSession
public enum NetworkError: Int, Error {
    
    case connection = -1009 // NSURLErrorNotConnectedToInternet
    case timeout = -1001 // NSURLErrorTimedOut
    case other = 0
    
    /// Convert an error returned by the URLSession into a NetworkError.
    ///
    /// - Parameter code: The returned error.
    public init(error: Error) {
        if let error = error as NSError? {
            self = NetworkError(rawValue: error.code) ?? .other
        } else {
            self = .other
        }
    }
}
