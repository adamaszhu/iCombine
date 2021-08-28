
/// HTTPClient.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import iCombine

/// Manage HTTP requests
open class HTTPClient: HTTPClientType {
    
    private let networkConnectionManager: NetworkConnectionManagerType
    private let session: URLSession
    
    /// Intiialize the client
    ///
    /// - Parameters:
    ///   - session: The URLSession configured, including SSL pinning
    ///   - networkConnectionManager: The network connection status manager
    public init(session: URLSession = URLSession.shared,
                networkConnectionManager: NetworkConnectionManagerType = NetworkConnectionManager()) {
        self.networkConnectionManager = networkConnectionManager
        self.session = session
    }
    
    public func requestObject<Object: Decodable>(
        with request: URLRequest,
        promoting businessErrorTypes: [BusinessError.Type] = []) -> AnyPublisher<Object?, HTTPError> {
        guard networkConnectionManager.isConnected else {
            return Fail<Object?, HTTPError>(error: .network(.connection))
                .eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: request)
            .mapNetworkError()
            .catchBusinessError(businessErrorTypes)
            .catchServerError()
            .decodeObject()
    }
    
    public func requestObjects<Object: Decodable>(
        with request: URLRequest,
        promoting businessErrorTypes: [BusinessError.Type] = []) -> AnyPublisher<[Object]?, HTTPError> {
        guard networkConnectionManager.isConnected else {
            return Fail<[Object]?, HTTPError>(error: .network(.connection))
                .eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: request)
            .mapNetworkError()
            .catchBusinessError(businessErrorTypes)
            .catchServerError()
            .decodeObjects()
    }
    
    public func requestData(with request: URLRequest) -> AnyPublisher<Data?, HTTPError> {
        guard networkConnectionManager.isConnected else {
            return Fail<Data?, HTTPError>(error: .network(.connection))
                .eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: request)
            .mapNetworkError()
            .catchServerError()
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    public func requestObject<Object: Decodable>(
        from url: URL,
        using method: RequestMethod,
        attaching header: RequestHeader? = nil,
        attaching parameters: URLParameters? = nil,
        with body: RequestBody? = nil,
        as bodyType: RequestBodyType? = nil,
        promoting businessErrorTypes: [BusinessError.Type] = []) -> AnyPublisher<Object?, HTTPError> {
        do {
            let request = try self.request(from: url, using: method, attaching: header, attaching: parameters, with: body, as: bodyType)
            return requestObject(with: request, promoting: businessErrorTypes)
        } catch HTTPError.encoding {
            return Fail<Object?, HTTPError>(error: .encoding)
                .eraseToAnyPublisher()
        } catch HTTPError.url {
            return Fail<Object?, HTTPError>(error: .url)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Object?, HTTPError>(error: .unknown)
                .eraseToAnyPublisher()
        }
    }
    
    public func requestObjects<Object: Decodable>(
        from url: URL,
        using method: RequestMethod,
        attaching header: RequestHeader? = nil,
        attaching parameters: URLParameters? = nil,
        with body: RequestBody? = nil,
        as bodyType: RequestBodyType? = nil,
        promoting businessErrorTypes: [BusinessError.Type] = []) -> AnyPublisher<[Object]?, HTTPError> {
        do {
            let request = try self.request(from: url, using: method, attaching: header, attaching: parameters, with: body, as: bodyType)
            return requestObjects(with: request, promoting: businessErrorTypes)
        } catch HTTPError.encoding {
            return Fail<[Object]?, HTTPError>(error: .encoding)
                .eraseToAnyPublisher()
        } catch HTTPError.url {
            return Fail<[Object]?, HTTPError>(error: .url)
                .eraseToAnyPublisher()
        } catch {
            return Fail<[Object]?, HTTPError>(error: .unknown)
                .eraseToAnyPublisher()
        }
    }
    
    public func requestData(
        from url: URL,
        using method: RequestMethod,
        attaching header: RequestHeader?,
        attaching parameters: URLParameters?,
        with body: RequestBody?,
        as bodyType: RequestBodyType?) -> AnyPublisher<Data?, HTTPError> {
        do {
            let request = try self.request(from: url, using: method, attaching: header, attaching: parameters, with: body, as: bodyType)
            return requestData(with: request)
        } catch HTTPError.url {
            return Fail<Data?, HTTPError>(error: .url)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Data?, HTTPError>(error: .unknown)
                .eraseToAnyPublisher()
        }
    }
    
    private func request(from url: URL,
                         using method: RequestMethod,
                         attaching header: RequestHeader?,
                         attaching parameters: URLParameters?,
                         with body: RequestBody?,
                         as bodyType: RequestBodyType?) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header
        
        if let parameters = parameters {
            guard let url = url.attaching(parameters) else {
                throw HTTPError.url
            }
            request.url = url
        }
        
        if let body = body, let bodyType = bodyType  {
            request.allHTTPHeaderFields?["Content-Type"] = bodyType.contentType
            guard let data = body.data(as: bodyType) else {
                throw HTTPError.encoding
            }
            request.httpBody = data
        }
        
        return request
    }
}

/// The response type of a HTTP request
public typealias DataTaskResponse = URLSession.CombineDataTaskPublisher.Output



