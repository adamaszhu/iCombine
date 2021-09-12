/// HTTPClientType.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import iCombine
import Foundation

/// Define a HTTPClient
public protocol HTTPClientType {
    
    /// Request an object
    ///
    /// - Parameters:
    ///   - request: The URL request
    ///   - businessErrorTypes: All types of BusinessError that should be detected
    /// - Returns: An object publisher
    func requestObject<Object: Decodable>(
        with request: URLRequest,
        promoting businessErrorTypes: [BusinessError.Type]) -> AnyPublisher<Object?, HTTPError>
    
    /// Request a list of objects
    ///
    /// - Parameters:
    ///   - request: The URL request
    ///   - businessErrorTypes: All types of BusinessError that should be detected
    /// - Returns: An object list publisher
    func requestObjects<Object: Decodable>(
        with request: URLRequest,
        promoting businessErrorTypes: [BusinessError.Type]) -> AnyPublisher<[Object]?, HTTPError>
    
    /// Request a data block
    ///
    /// - Parameter request: The URL request
    /// - Returns: A data publisher
    func requestData(with request: URLRequest) -> AnyPublisher<Data?, HTTPError>
    
    /// Request an object
    ///
    /// - Parameters:
    ///   - url: The URL
    ///   - method: The HTTP method
    ///   - header: The HTTP header
    ///   - parameters: The URL parameters
    ///   - body: The request body
    ///   - bodyType: The type of the request body
    ///   - businessErrorTypes: All types of BusinessError that should be detected
    /// - Returns: An object publisher
    func requestObject<Object: Decodable>(
        from url: URL,
        using method: RequestMethod,
        attaching header: RequestHeader?,
        attaching parameters: URLParameters?,
        with body: RequestBody?,
        as bodyType: RequestBodyType?,
        promoting businessErrorTypes: [BusinessError.Type]) -> AnyPublisher<Object?, HTTPError>
    
    /// Request a list of objects
    ///
    /// - Parameters:
    ///   - url: The URL
    ///   - method: The HTTP method
    ///   - header: The HTTP header
    ///   - parameters: The URL parameters
    ///   - body: The request body
    ///   - bodyType: The type of the request body
    ///   - businessErrorTypes: All types of BusinessError that should be detected
    /// - Returns: An object list publisher
    func requestObjects<Object: Decodable>(
        from url: URL,
        using method: RequestMethod,
        attaching header: RequestHeader?,
        attaching parameters: URLParameters?,
        with body: RequestBody?,
        as bodyType: RequestBodyType?,
        promoting businessErrorTypes: [BusinessError.Type]) -> AnyPublisher<[Object]?, HTTPError>
    
    /// Request a data block
    ///
    /// - Parameters:
    ///   - url: The URL
    ///   - method: The HTTP method
    ///   - header: The HTTP header
    ///   - parameters: The URL parameters
    ///   - body: The request body
    ///   - bodyType: The type of the request body
    /// - Returns: A data publisher
    func requestData(
        from url: URL,
        using method: RequestMethod,
        attaching header: RequestHeader?,
        attaching parameters: URLParameters?,
        with body: RequestBody?,
        as bodyType: RequestBodyType?) -> AnyPublisher<Data?, HTTPError>
}
