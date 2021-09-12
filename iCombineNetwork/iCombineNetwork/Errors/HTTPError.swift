/// HTTPError.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

/// Any error throwned by a HTTPClient
public enum HTTPError: Error {
    case unknown
    case decoding
    case encoding
    case url
    case network(_ error: NetworkError)
    case server(_ error: ServerError)
    case business(_ error: BusinessError)
}

extension HTTPError: Equatable {
    
    public static func == (lhs: HTTPError, rhs: HTTPError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown),
             (.decoding, .decoding),
             (.encoding, .encoding),
             (.url, .url):
            return true
        case (.network(let lhsNetworkError), .network(let rhsNetworkError)):
            return lhsNetworkError == rhsNetworkError
        case (.server(let lhsServerError), .server(let rhsServerError)):
            return lhsServerError == rhsServerError
        default:
            return false
        }
    }
}
