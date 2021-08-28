/// RequestBody.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import Foundation

/// The body sent along with a HTTP request
public enum RequestBody {
    
    case dictionary(_ dictionary: [String: Any])
    case array(_ array: [Any])
    case data(_ data: Data)
    
    /// Convert the body to a Data object
    ///
    /// - Parameter bodyType: The type of the body
    /// - Returns: The encoded data object
    public func data(as bodyType: RequestBodyType) -> Data? {
        switch (self, bodyType) {
        case (let .data(data), _):
            return data
        case (let .array(array), _):
            return try? JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
        case (let .dictionary(dictionary), .json):
            return try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        case (let .dictionary(dictionary), .form):
            return dictionary.form.data(using: .utf8)
        }
    }
}
