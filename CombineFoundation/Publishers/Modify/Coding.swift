//
//  Coding.swift
//  CombineFoundation
//
//  Created by Adamas Zhu on 15/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

public enum CodingError: Error {
    case decoding
    case encoding
}

public protocol TopLevelDecoder {
    
    associatedtype Input
    
    func decode<T>(_ type: T.Type, from: Self.Input) throws -> T where T : Decodable
}

public protocol TopLevelEncoder {
    
    associatedtype Output
    
    func encode<T>(_ value: T) throws -> Self.Output where T : Encodable
}

extension JSONDecoder: TopLevelDecoder {}
extension JSONEncoder: TopLevelEncoder {}

extension Publishers {
    
    public struct Decode<Upstream, Output, Coder> : Publisher where Upstream : Publisher, Output : Decodable, Coder : TopLevelDecoder, Upstream.Output == Coder.Input {
        
        public var observable: Any
        
        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Error
        
        public init(upstream: Upstream, decoder: Coder) {
            #if canImport(Combine)
            if #available(iOS 14, macOS 10.15, *),
                let publisher = upstream.observable as? Combine.AnyPublisher<Upstream.Output, Upstream.Failure> {
                let mappedObserable: Combine.AnyPublisher<Output, Failure> = publisher.tryMap({ value in
                    do {
                        return try decoder.decode(Output.self, from: value)
                    } catch {
                        throw CodingError.decoding
                    }
                }).eraseToAnyPublisher()
                observable = mappedObserable
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                let mappedObservable: Observable<Output> = upstreamObservable.map { value in
                    do {
                        return try decoder.decode(Output.self, from: value)
                    } catch {
                        throw CodingError.decoding
                    }
                }
                observable = mappedObservable
            } else {
                fatalError("failed to init Decode")
            }
        }
    }
    
    // public struct Encode<Upstream, Coder> : Publisher where Upstream : Publisher, Coder : TopLevelEncoder, Upstream.Output : Encodable {
    
    // public var observable: Observable<Coder.Output>
    
    /// The kind of errors this publisher might publish.
    ///
    /// Use `Never` if this `Publisher` does not publish errors.
    // public typealias Failure = Error
    
    /// The kind of values published by this publisher.
    // public typealias Output = Coder.Output
    
    // public init(upstream: Upstream, encoder: Coder)
    // }
}

extension Publisher {
    
    /// Decodes the output from upstream using a specified `TopLevelDecoder`.
    /// For example, use `JSONDecoder`.
    public func decode<Item, Coder>(type: Item.Type, decoder: Coder) -> Publishers.Decode<Self, Item, Coder> where Item : Decodable, Coder : TopLevelDecoder, Self.Output == Coder.Input {
        return Publishers.Decode(upstream: self, decoder: decoder)
    }
}


extension Publisher where Self.Output : Encodable {
    
    /// Encodes the output from upstream using a specified `TopLevelEncoder`.
    /// For example, use `JSONEncoder`.
    // public func encode<Coder>(encoder: Coder) -> Publishers.Encode<Self, Coder> where Coder : TopLevelEncoder
}
