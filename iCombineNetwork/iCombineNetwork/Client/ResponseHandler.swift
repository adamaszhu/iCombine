/// ResponseHandler.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import iCombine
import Foundation

public extension URLSession.CombineDataTaskPublisher {
    
    /// Map a URLError generated by DataTaskPublisher into a NetworkError
    func mapNetworkError() -> AnyPublisher<DataTaskResponse, HTTPError> {
        return mapError { error in
            let networkError = NetworkError(error: error)
            return HTTPError.network(networkError)
        }
        .eraseToAnyPublisher()
    }
}

public extension AnyPublisher where Output == DataTaskResponse, Failure == HTTPError {
    
    /// Catch BusinessErrors from the response
    ///
    /// - Parameter businessErrorTypes: A list of BusinessError.Type
    /// - Returns: A new publisher filtered out BusinessErrors
    func catchBusinessError(_ businessErrorTypes: [BusinessError.Type]) -> AnyPublisher<DataTaskResponse, HTTPError> {
        return tryMap { response in
                for businessErrorType in businessErrorTypes {
                    if let businessError = businessErrorType.init(response: response) {
                        throw HTTPError.business(businessError)
                    }
                }
                return response
            }
            .eraseToAnyPublisher()
            .mapHTTPError()
    }
    
    /// Catch ServerErrors form the status code
    ///
    /// - Returns: A new publisher filtered out ServerErrors
    func catchServerError() -> AnyPublisher<DataTaskResponse, HTTPError> {
        return tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse else {
                    throw HTTPError.unknown
                }
                if let serverError = ServerError(code: httpResponse.statusCode) {
                    throw HTTPError.server(serverError)
                }
                return response
            }
            .eraseToAnyPublisher()
            .mapHTTPError()
    }

    /// Decode the response into an object
    func decodeObject<Object: Decodable>() -> AnyPublisher<Object?, HTTPError> {
        return tryMap { response in
                guard !response.data.isEmpty else {
                    return nil
                }
                do {
                    return try JSONDecoder().decode(Object.self, from: response.data)
                } catch {
                    throw HTTPError.decoding
                }
            }
            .eraseToAnyPublisher()
            .mapHTTPError()
    }

    /// Decode the response into an object array
    func decodeObjects<Object: Decodable>() -> AnyPublisher<[Object]?, HTTPError> {
        return tryMap { response in
                guard !response.data.isEmpty else {
                    return nil
                }
                do {
                    return try JSONDecoder().decode([Object].self, from: response.data)
                } catch {
                    throw HTTPError.decoding
                }
            }
            .eraseToAnyPublisher()
            .mapHTTPError()
    }
}

internal extension AnyPublisher where Failure == Error {
    
    func mapHTTPError() -> AnyPublisher<Output, HTTPError> {
        return mapError { error in
                let error = error as? HTTPError
                return error ?? .unknown
            }
            .eraseToAnyPublisher()
    }
}
