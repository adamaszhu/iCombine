/// RequestBodyType.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

/// The body type of a HTTP request
public enum RequestBodyType: String {
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
}

public extension RequestBodyType {
    
    /// The contentType field required by a request header
    var contentType: String {
        return rawValue
    }
}
