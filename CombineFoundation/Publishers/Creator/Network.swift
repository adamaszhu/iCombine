//
//  Network.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 11/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

extension URLSession {

    public struct CombineDataTaskPublisher : Publisher {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = (data: Data, response: URLResponse)

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = URLError

        public init(request: URLRequest, session: URLSession) {
            #if canImport(Combine)
            if #available(iOS 13, *) {
                observable = URLSession.DataTaskPublisher(request: request, session: session)
                    .map { (data: $0.data, response: $0.response as URLResponse) }
                    .eraseToAnyPublisher()
                return
            }
            #endif
            observable = session.rx.response(request: request)
            .map { (data: $0.data, response: $0.response as URLResponse) }
        }
    }
}

extension URLSession {

    /// Returns a publisher that wraps a URL session data task for a given URL.
    ///
    /// The publisher publishes data when the task completes, or terminates if the task fails with an error.
    /// - Parameter url: The URL for which to create a data task.
    /// - Returns: A publisher that wraps a data task for the URL.
    public func dataTaskPublisher(for url: URL) -> URLSession.CombineDataTaskPublisher {
        let request = URLRequest(url: url)
        return URLSession.CombineDataTaskPublisher(request: request, session: self)
    }

    /// Returns a publisher that wraps a URL session data task for a given URL request.
    ///
    /// The publisher publishes data when the task completes, or terminates if the task fails with an error.
    /// - Parameter request: The URL request for which to create a data task.
    /// - Returns: A publisher that wraps a data task for the URL request.
    public func dataTaskPublisher(for request: URLRequest) -> URLSession.CombineDataTaskPublisher {
        return URLSession.CombineDataTaskPublisher(request: request, session: self)
    }
}
