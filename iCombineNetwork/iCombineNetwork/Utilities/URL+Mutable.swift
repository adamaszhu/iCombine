/// URL+Mutable.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import Foundation

internal extension URL {
    
    func attaching(_ parameters: URLParameters) -> URL? {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        // We have to do this because URLComponents will not encode the '+' into "%2B" in the query string
        components.percentEncodedQuery = components.percentEncodedQuery?
            .replacingOccurrences(of: String.plus, with: String.encodedPlus)
        
        return components.url
    }
}
