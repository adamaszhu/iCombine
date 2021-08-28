/// ServerError.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

/// Standard HTTP status code error thrown by the server
public enum ServerError: Int, Error {
    
    case badRequestError = 400
    case unauthorized = 401
    case authenticationTimeout = 419
    case unknownResponse = 422
    case internalServer = 500
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case other = 0
    
    /// Convert a http status code into a ServerError.
    ///
    /// - Parameter code: The http status code.
    public init?(code: Int) {
        if let error = ServerError(rawValue: code) {
            self = error
            return
        }
        if 200..<400 ~= code {
            return nil
        } else {
            self = .other
        }
    }
}
