//
//  Merge.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 11/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

extension Publishers {

    /// A publisher created by applying the merge function to two upstream publishers.
    public struct Merge<A, B> : Publisher where A : Publisher, B : Publisher, A.Failure == B.Failure, A.Output == B.Output {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = A.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = A.Failure

        public let a: A
        public let b: B

        public init(_ a: A, _ b: B) {
            self.a = a
            self.b = b
            #if canImport(Combine)
            if #available(iOS 13, *),
                let aPublisher = a.observable as? Combine.AnyPublisher<A.Output, A.Failure>,
                let bPublisher = b.observable as? Combine.AnyPublisher<B.Output, B.Failure> {
                    observable = Combine.Publishers.Merge(aPublisher, bPublisher)
                        .eraseToAnyPublisher()
                return
            }
            #endif
            if let aObservable = a.observable as? Observable<A.Output>,
                    let bObservable = b.observable as? Observable<B.Output> {
                observable = Observable.merge(aObservable, bObservable)
            } else {
                fatalError("failed to init Merge")
            }
        }

        public func merge<P>(with other: P) -> Publishers.Merge3<A, B, P>
            where P : Publisher, B.Failure == P.Failure, B.Output == P.Output {
                return Publishers.Merge3(a, b, other)
        }

        public func merge<Z, Y>(with z: Z, _ y: Y) -> Publishers.Merge4<A, B, Z, Y>
            where Z : Publisher, Y : Publisher,
            B.Failure == Z.Failure, B.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output {
                return Publishers.Merge4(a, b, z, y)
        }

        public func merge<Z, Y, X>(with z: Z, _ y: Y, _ x: X) -> Publishers.Merge5<A, B, Z, Y, X>
            where Z : Publisher, Y : Publisher, X : Publisher,
            B.Failure == Z.Failure, B.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output,
            Y.Failure == X.Failure, Y.Output == X.Output {
                return Publishers.Merge5(a, b, z, y, x)
        }

        public func merge<Z, Y, X, W>(with z: Z, _ y: Y, _ x: X, _ w: W) -> Publishers.Merge6<A, B, Z, Y, X, W>
            where Z : Publisher, Y : Publisher, X : Publisher, W : Publisher,
            B.Failure == Z.Failure, B.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output,
            Y.Failure == X.Failure, Y.Output == X.Output,
            X.Failure == W.Failure, X.Output == W.Output {
                return Publishers.Merge6(a, b, z, y, x, w)
        }

        public func merge<Z, Y, X, W, V>(with z: Z, _ y: Y, _ x: X, _ w: W, _ v: V) -> Publishers.Merge7<A, B, Z, Y, X, W, V>
            where Z : Publisher, Y : Publisher, X : Publisher, W : Publisher, V : Publisher,
            B.Failure == Z.Failure, B.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output,
            Y.Failure == X.Failure, Y.Output == X.Output,
            X.Failure == W.Failure, X.Output == W.Output,
            W.Failure == V.Failure, W.Output == V.Output {
                return Publishers.Merge7(a, b, z, y, x, w, v)
        }

        public func merge<Z, Y, X, W, V, U>(with z: Z, _ y: Y, _ x: X, _ w: W, _ v: V, _ u: U) -> Publishers.Merge8<A, B, Z, Y, X, W, V, U>
            where Z : Publisher, Y : Publisher, X : Publisher, W : Publisher, V : Publisher, U : Publisher,
            B.Failure == Z.Failure, B.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output,
            Y.Failure == X.Failure, Y.Output == X.Output,
            X.Failure == W.Failure, X.Output == W.Output,
            W.Failure == V.Failure, W.Output == V.Output,
            V.Failure == U.Failure, V.Output == U.Output {
                return Publishers.Merge8(a, b, z, y, x, w, v, u)
        }
    }

    /// A publisher created by applying the merge function to three upstream publishers.
    public struct Merge3<A, B, C> : Publisher
        where A : Publisher, B : Publisher, C : Publisher,
        A.Failure == B.Failure, A.Output == B.Output,
    B.Failure == C.Failure, B.Output == C.Output {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = A.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = A.Failure

        public let a: A
        public let b: B
        public let c: C

        public init(_ a: A, _ b: B, _ c: C) {
            self.a = a
            self.b = b
            self.c = c
            #if canImport(Combine)
            if #available(iOS 13, *),
                let aPublisher = a.observable as? Combine.AnyPublisher<A.Output, A.Failure>,
                let bPublisher = b.observable as? Combine.AnyPublisher<B.Output, B.Failure>,
                let cPublisher = c.observable as? Combine.AnyPublisher<C.Output, C.Failure> {
                    observable = Combine.Publishers.Merge3(aPublisher, bPublisher, cPublisher)
                        .eraseToAnyPublisher()
                return
            }
            #endif
            if let aObservable = a.observable as? Observable<A.Output>,
                    let bObservable = b.observable as? Observable<B.Output>,
                    let cObservable = c.observable as? Observable<C.Output> {
                observable = Observable.merge(aObservable, bObservable, cObservable)
            } else {
                fatalError("failed to init Merge3")
            }
        }

        public func merge<P>(with other: P) -> Publishers.Merge4<A, B, C, P>
            where P : Publisher, C.Failure == P.Failure, C.Output == P.Output {
                return Publishers.Merge4(a, b, c, other)
        }

        public func merge<Z, Y>(with z: Z, _ y: Y) -> Publishers.Merge5<A, B, C, Z, Y>
            where Z : Publisher, Y : Publisher,
            C.Failure == Z.Failure, C.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output {
                return Publishers.Merge5(a, b, c, z, y)
        }

        public func merge<Z, Y, X>(with z: Z, _ y: Y, _ x: X) -> Publishers.Merge6<A, B, C, Z, Y, X>
            where Z : Publisher, Y : Publisher, X : Publisher,
            C.Failure == Z.Failure, C.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output,
            Y.Failure == X.Failure, Y.Output == X.Output {
                return Publishers.Merge6(a, b, c, z, y, x)
        }

        public func merge<Z, Y, X, W>(with z: Z, _ y: Y, _ x: X, _ w: W) -> Publishers.Merge7<A, B, C, Z, Y, X, W>
            where Z : Publisher, Y : Publisher, X : Publisher, W : Publisher,
            C.Failure == Z.Failure, C.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output,
            Y.Failure == X.Failure, Y.Output == X.Output,
            X.Failure == W.Failure, X.Output == W.Output {
                return Publishers.Merge7(a, b, c, z, y, x, w)
        }

        public func merge<Z, Y, X, W, V>(with z: Z, _ y: Y, _ x: X, _ w: W, _ v: V) -> Publishers.Merge8<A, B, C, Z, Y, X, W, V>
            where Z : Publisher, Y : Publisher, X : Publisher, W : Publisher, V : Publisher,
            C.Failure == Z.Failure, C.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output,
            Y.Failure == X.Failure, Y.Output == X.Output,
            X.Failure == W.Failure, X.Output == W.Output,
            W.Failure == V.Failure, W.Output == V.Output {
                return Publishers.Merge8(a, b, c, z, y, x, w, v)
        }
    }

    /// A publisher created by applying the merge function to four upstream publishers.
    public struct Merge4<A, B, C, D> : Publisher
        where A : Publisher, B : Publisher, C : Publisher, D : Publisher,
        A.Failure == B.Failure, A.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output,
    C.Failure == D.Failure, C.Output == D.Output {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = A.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = A.Failure

        public let a: A
        public let b: B
        public let c: C
        public let d: D

        public init(_ a: A, _ b: B, _ c: C, _ d: D) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            #if canImport(Combine)
            if #available(iOS 13, *),
                let aPublisher = a.observable as? Combine.AnyPublisher<A.Output, A.Failure>,
                let bPublisher = b.observable as? Combine.AnyPublisher<B.Output, B.Failure>,
                let cPublisher = c.observable as? Combine.AnyPublisher<C.Output, C.Failure>,
                let dPublisher = d.observable as? Combine.AnyPublisher<D.Output, D.Failure> {
                    observable = Combine.Publishers.Merge4(aPublisher, bPublisher, cPublisher, dPublisher)
                        .eraseToAnyPublisher()
                return
            }
            #endif
            if let aObservable = a.observable as? Observable<A.Output>,
                    let bObservable = b.observable as? Observable<B.Output>,
                    let cObservable = c.observable as? Observable<C.Output>,
                    let dObservable = d.observable as? Observable<D.Output> {
                observable = Observable.merge(aObservable, bObservable, cObservable, dObservable)
            } else {
                fatalError("failed to init Merge4")
            }
        }

        public func merge<P>(with other: P) -> Publishers.Merge5<A, B, C, D, P>
            where P : Publisher, D.Failure == P.Failure, D.Output == P.Output {
                return Publishers.Merge5(a, b, c, d, other)
        }

        public func merge<Z, Y>(with z: Z, _ y: Y) -> Publishers.Merge6<A, B, C, D, Z, Y>
            where Z : Publisher, Y : Publisher,
            D.Failure == Z.Failure, D.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output {
                return Publishers.Merge6(a, b, c, d, z, y)
        }

        public func merge<Z, Y, X>(with z: Z, _ y: Y, _ x: X) -> Publishers.Merge7<A, B, C, D, Z, Y, X>
            where Z : Publisher, Y : Publisher, X : Publisher,
            D.Failure == Z.Failure, D.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output,
            Y.Failure == X.Failure, Y.Output == X.Output {
                return Publishers.Merge7(a, b, c, d, z, y, x)
        }

        public func merge<Z, Y, X, W>(with z: Z, _ y: Y, _ x: X, _ w: W) -> Publishers.Merge8<A, B, C, D, Z, Y, X, W>
            where Z : Publisher, Y : Publisher, X : Publisher, W : Publisher,
            D.Failure == Z.Failure, D.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output,
            Y.Failure == X.Failure, Y.Output == X.Output,
            X.Failure == W.Failure, X.Output == W.Output {
                return Publishers.Merge8(a, b, c, d, z, y, x, w)
        }
    }

    /// A publisher created by applying the merge function to five upstream publishers.
    public struct Merge5<A, B, C, D, E> : Publisher
        where A : Publisher, B : Publisher, C : Publisher, D : Publisher, E : Publisher,
        A.Failure == B.Failure, A.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output,
        C.Failure == D.Failure, C.Output == D.Output,
    D.Failure == E.Failure, D.Output == E.Output {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = A.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = A.Failure

        public let a: A
        public let b: B
        public let c: C
        public let d: D
        public let e: E

        public init(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            self.e = e
            #if canImport(Combine)
            if #available(iOS 13, *),
                let aPublisher = a.observable as? Combine.AnyPublisher<A.Output, A.Failure>,
                let bPublisher = b.observable as? Combine.AnyPublisher<B.Output, B.Failure>,
                let cPublisher = c.observable as? Combine.AnyPublisher<C.Output, C.Failure>,
                let dPublisher = d.observable as? Combine.AnyPublisher<D.Output, D.Failure>,
                let ePublisher = e.observable as? Combine.AnyPublisher<E.Output, E.Failure> {
                    observable = Combine.Publishers.Merge5(aPublisher, bPublisher, cPublisher, dPublisher, ePublisher)
                        .eraseToAnyPublisher()
                return
            }
            #endif
            if let aObservable = a.observable as? Observable<A.Output>,
                    let bObservable = b.observable as? Observable<B.Output>,
                    let cObservable = c.observable as? Observable<C.Output>,
                    let dObservable = d.observable as? Observable<D.Output>,
                    let eObservable = e.observable as? Observable<E.Output> {
                observable = Observable.merge(aObservable, bObservable, cObservable, dObservable, eObservable)
            } else {
                fatalError("failed to init Merge5")
            }
        }

        public func merge<P>(with other: P) -> Publishers.Merge6<A, B, C, D, E, P>
            where P : Publisher, E.Failure == P.Failure, E.Output == P.Output {
                return Publishers.Merge6(a, b, c, d, e, other)
        }

        public func merge<Z, Y>(with z: Z, _ y: Y) -> Publishers.Merge7<A, B, C, D, E, Z, Y>
            where Z : Publisher, Y : Publisher,
            E.Failure == Z.Failure, E.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output {
                return Publishers.Merge7(a, b, c, d, e, z, y)
        }

        public func merge<Z, Y, X>(with z: Z, _ y: Y, _ x: X) -> Publishers.Merge8<A, B, C, D, E, Z, Y, X>
            where Z : Publisher, Y : Publisher, X : Publisher,
            E.Failure == Z.Failure, E.Output == Z.Output,
            Z.Failure == Y.Failure, Z.Output == Y.Output,
            Y.Failure == X.Failure, Y.Output == X.Output {
                return Publishers.Merge8(a, b, c, d, e, z, y, x)
        }
    }

    /// A publisher created by applying the merge function to six upstream publishers.
    public struct Merge6<A, B, C, D, E, F> : Publisher
        where A : Publisher, B : Publisher, C : Publisher, D : Publisher, E : Publisher, F : Publisher,
        A.Failure == B.Failure, A.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output,
        C.Failure == D.Failure, C.Output == D.Output,
        D.Failure == E.Failure, D.Output == E.Output,
    E.Failure == F.Failure, E.Output == F.Output {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = A.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = A.Failure

        public let a: A
        public let b: B
        public let c: C
        public let d: D
        public let e: E
        public let f: F

        public init(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            self.e = e
            self.f = f
            #if canImport(Combine)
            if #available(iOS 13, *),
                let aPublisher = a.observable as? Combine.AnyPublisher<A.Output, A.Failure>,
                let bPublisher = b.observable as? Combine.AnyPublisher<B.Output, B.Failure>,
                let cPublisher = c.observable as? Combine.AnyPublisher<C.Output, C.Failure>,
                let dPublisher = d.observable as? Combine.AnyPublisher<D.Output, D.Failure>,
                let ePublisher = e.observable as? Combine.AnyPublisher<E.Output, E.Failure>,
                let fPublisher = f.observable as? Combine.AnyPublisher<F.Output, F.Failure>{
                    observable = Combine.Publishers.Merge6(aPublisher,
                                                           bPublisher,
                                                           cPublisher,
                                                           dPublisher,
                                                           ePublisher,
                                                           fPublisher)
                        .eraseToAnyPublisher()
                return
            }
            #endif
            if let aObservable = a.observable as? Observable<A.Output>,
                    let bObservable = b.observable as? Observable<B.Output>,
                    let cObservable = c.observable as? Observable<C.Output>,
                    let dObservable = d.observable as? Observable<D.Output>,
                    let eObservable = e.observable as? Observable<E.Output>,
                    let fObservable = f.observable as? Observable<F.Output>{
                observable = Observable.merge(aObservable, bObservable, cObservable, dObservable, eObservable, fObservable)
            } else {
                fatalError("failed to init Merge6")
            }
        }

        public func merge<P>(with other: P) -> Publishers.Merge7<A, B, C, D, E, F, P>
            where P : Publisher, F.Failure == P.Failure, F.Output == P.Output {
                return Publishers.Merge7(a, b, c, d, e, f, other)
        }

        public func merge<Z, Y>(with z: Z, _ y: Y) -> Publishers.Merge8<A, B, C, D, E, F, Z, Y>
            where Z : Publisher, Y : Publisher, F.Failure == Z.Failure, F.Output == Z.Output, Z.Failure == Y.Failure, Z.Output == Y.Output {
                return Publishers.Merge8(a, b, c, d, e, f, z, y)
        }
    }

    /// A publisher created by applying the merge function to seven upstream publishers.
    public struct Merge7<A, B, C, D, E, F, G> : Publisher
        where A : Publisher, B : Publisher, C : Publisher, D : Publisher, E : Publisher, F : Publisher, G : Publisher,
        A.Failure == B.Failure, A.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output,
        C.Failure == D.Failure, C.Output == D.Output,
        D.Failure == E.Failure, D.Output == E.Output,
        E.Failure == F.Failure, E.Output == F.Output,
    F.Failure == G.Failure, F.Output == G.Output {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = A.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = A.Failure

        public let a: A
        public let b: B
        public let c: C
        public let d: D
        public let e: E
        public let f: F
        public let g: G

        public init(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            self.e = e
            self.f = f
            self.g = g
            #if canImport(Combine)
            if #available(iOS 13, *),
                let aPublisher = a.observable as? Combine.AnyPublisher<A.Output, A.Failure>,
                let bPublisher = b.observable as? Combine.AnyPublisher<B.Output, B.Failure>,
                let cPublisher = c.observable as? Combine.AnyPublisher<C.Output, C.Failure>,
                let dPublisher = d.observable as? Combine.AnyPublisher<D.Output, D.Failure>,
                let ePublisher = e.observable as? Combine.AnyPublisher<E.Output, E.Failure>,
                let fPublisher = f.observable as? Combine.AnyPublisher<F.Output, F.Failure>,
                let gPublisher = g.observable as? Combine.AnyPublisher<G.Output, G.Failure> {
                    observable = Combine.Publishers.Merge7(aPublisher,
                                                           bPublisher,
                                                           cPublisher,
                                                           dPublisher,
                                                           ePublisher,
                                                           fPublisher,
                                                           gPublisher)
                        .eraseToAnyPublisher()
                return
            }
            #endif
            if let aObservable = a.observable as? Observable<A.Output>,
                    let bObservable = b.observable as? Observable<B.Output>,
                    let cObservable = c.observable as? Observable<C.Output>,
                    let dObservable = d.observable as? Observable<D.Output>,
                    let eObservable = e.observable as? Observable<E.Output>,
                    let fObservable = f.observable as? Observable<F.Output>,
                    let gObservable = g.observable as? Observable<G.Output> {
                observable = Observable.merge(aObservable, bObservable, cObservable, dObservable, eObservable, fObservable, gObservable)
            } else {
                fatalError("failed to init Merge7")
            }
        }

        public func merge<P>(with other: P) -> Publishers.Merge8<A, B, C, D, E, F, G, P>
            where P : Publisher, G.Failure == P.Failure, G.Output == P.Output {
                return Publishers.Merge8(a, b, c, d, e, f, g, other)
        }
    }

    /// A publisher created by applying the merge function to eight upstream publishers.
    public struct Merge8<A, B, C, D, E, F, G, H> : Publisher
        where A : Publisher, B : Publisher, C : Publisher, D : Publisher, E : Publisher, F : Publisher, G : Publisher, H : Publisher,
        A.Failure == B.Failure, A.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output,
        C.Failure == D.Failure, C.Output == D.Output,
        D.Failure == E.Failure, D.Output == E.Output,
        E.Failure == F.Failure, E.Output == F.Output,
        F.Failure == G.Failure, F.Output == G.Output,
    G.Failure == H.Failure, G.Output == H.Output {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = A.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = A.Failure

        public let a: A
        public let b: B
        public let c: C
        public let d: D
        public let e: E
        public let f: F
        public let g: G
        public let h: H

        public init(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            self.e = e
            self.f = f
            self.g = g
            self.h = h
            #if canImport(Combine)
            if #available(iOS 13, *),
                let aPublisher = a.observable as? Combine.AnyPublisher<A.Output, A.Failure>,
                let bPublisher = b.observable as? Combine.AnyPublisher<B.Output, B.Failure>,
                let cPublisher = c.observable as? Combine.AnyPublisher<C.Output, C.Failure>,
                let dPublisher = d.observable as? Combine.AnyPublisher<D.Output, D.Failure>,
                let ePublisher = e.observable as? Combine.AnyPublisher<E.Output, E.Failure>,
                let fPublisher = f.observable as? Combine.AnyPublisher<F.Output, F.Failure>,
                let gPublisher = g.observable as? Combine.AnyPublisher<G.Output, G.Failure>,
                let hPublisher = h.observable as? Combine.AnyPublisher<H.Output, H.Failure> {
                    observable = Combine.Publishers.Merge8(aPublisher,
                                                           bPublisher,
                                                           cPublisher,
                                                           dPublisher,
                                                           ePublisher,
                                                           fPublisher,
                                                           gPublisher,
                                                           hPublisher)
                        .eraseToAnyPublisher()
                return
            }
            #endif
            if let aObservable = a.observable as? Observable<A.Output>,
                    let bObservable = b.observable as? Observable<B.Output>,
                    let cObservable = c.observable as? Observable<C.Output>,
                    let dObservable = d.observable as? Observable<D.Output>,
                    let eObservable = e.observable as? Observable<E.Output>,
                    let fObservable = f.observable as? Observable<F.Output>,
                    let gObservable = g.observable as? Observable<G.Output>,
                    let hObservable = h.observable as? Observable<H.Output> {
                observable = Observable.merge(aObservable, bObservable, cObservable, dObservable, eObservable, fObservable, gObservable, hObservable)
            } else {
                fatalError("failed to init Merge8")
            }
        }
    }

    public struct MergeMany<Upstream> : Publisher where Upstream : Publisher {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public let publishers: [Upstream]

        public init(_ upstream: Upstream...) {
            self.publishers = upstream
            #if canImport(Combine)
            if #available(iOS 13, *) {
                let mergedPublishers: [Combine.AnyPublisher<Upstream.Output, Upstream.Failure>] = upstream.map {
                    if let upstreamObservable = $0.observable as? Combine.AnyPublisher<Upstream.Output, Upstream.Failure> {
                        return upstreamObservable
                    } else {
                        fatalError("failed to init MergeMany")
                    }
                }
                observable = Combine.Publishers.MergeMany(mergedPublishers)
                    .eraseToAnyPublisher()
                return
            }
            #endif
            let merged: Observable<Upstream.Output> = Observable.merge(upstream.map {
                if let upstreamObservable = $0.observable as? Observable<Upstream.Output> {
                    return upstreamObservable
                } else {
                    fatalError("failed to init MergeMany")
                }
            })
            observable = merged
        }

        public init<S>(_ upstream: S)
            where Upstream == S.Element, S : Swift.Sequence {
                self.publishers = Array(upstream)
                #if canImport(Combine)
                if #available(iOS 13, *) {
                    let mergedPublishers: [Combine.AnyPublisher<Upstream.Output, Upstream.Failure>] = upstream.map {
                        if let upstreamObservable = $0.observable as? Combine.AnyPublisher<Upstream.Output, Upstream.Failure> {
                            return upstreamObservable
                        } else {
                            fatalError("failed to init MergeMany")
                        }
                    }
                    observable = Combine.Publishers.MergeMany(mergedPublishers)
                        .eraseToAnyPublisher()
                    return
                }
                #endif
                let merged: Observable<Upstream.Output> = Observable.merge(upstream.map {
                    if let upstreamObservable = $0.observable as? Observable<Upstream.Output> {
                        return upstreamObservable
                    } else {
                        fatalError("failed to init MergeMany")
                    }
                })
                observable = merged
        }

        public func merge(with other: Upstream) -> Publishers.MergeMany<Upstream> {
            var upstreams = publishers
            upstreams.append(other)
            return Publishers.MergeMany(upstreams)
        }
    }
}

extension Publisher {

    /// Combines elements from this publisher with those from another publisher, delivering an interleaved sequence of elements.
    ///
    /// The merged publisher continues to emit elements until all upstream publishers finish. If an upstream publisher produces an error, the merged publisher fails with that error.
    /// - Parameter other: Another publisher.
    /// - Returns: A publisher that emits an event when either upstream publisher emits an event.
    public func merge<P>(with other: P) -> Publishers.Merge<Self, P>
        where P : Publisher, Self.Failure == P.Failure, Self.Output == P.Output {
            return Publishers.Merge(self, other)
    }

    /// Combines elements from this publisher with those from two other publishers, delivering an interleaved sequence of elements.
    ///
    /// The merged publisher continues to emit elements until all upstream publishers finish. If an upstream publisher produces an error, the merged publisher fails with that error.
    ///
    /// - Parameters:
    ///   - b: A second publisher.
    ///   - c: A third publisher.
    /// - Returns:  A publisher that emits an event when any upstream publisher emits
    /// an event.
    public func merge<B, C>(with b: B, _ c: C) -> Publishers.Merge3<Self, B, C>
        where B : Publisher, C : Publisher,
        Self.Failure == B.Failure, Self.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output {
            return Publishers.Merge3(self, b, c)
    }

    /// Combines elements from this publisher with those from three other publishers, delivering
    /// an interleaved sequence of elements.
    ///
    /// The merged publisher continues to emit elements until all upstream publishers finish. If an upstream publisher produces an error, the merged publisher fails with that error.
    ///
    /// - Parameters:
    ///   - b: A second publisher.
    ///   - c: A third publisher.
    ///   - d: A fourth publisher.
    /// - Returns: A publisher that emits an event when any upstream publisher emits an event.
    public func merge<B, C, D>(with b: B, _ c: C, _ d: D) -> Publishers.Merge4<Self, B, C, D>
        where B : Publisher, C : Publisher, D : Publisher,
        Self.Failure == B.Failure, Self.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output,
        C.Failure == D.Failure, C.Output == D.Output {
            return Publishers.Merge4(self, b, c, d)
    }

    /// Combines elements from this publisher with those from four other publishers, delivering an interleaved sequence of elements.
    ///
    /// The merged publisher continues to emit elements until all upstream publishers finish. If an upstream publisher produces an error, the merged publisher fails with that error.
    ///
    /// - Parameters:
    ///   - b: A second publisher.
    ///   - c: A third publisher.
    ///   - d: A fourth publisher.
    ///   - e: A fifth publisher.
    /// - Returns: A publisher that emits an event when any upstream publisher emits an event.
    public func merge<B, C, D, E>(with b: B, _ c: C, _ d: D, _ e: E) -> Publishers.Merge5<Self, B, C, D, E>
        where B : Publisher, C : Publisher, D : Publisher, E : Publisher,
        Self.Failure == B.Failure, Self.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output,
        C.Failure == D.Failure, C.Output == D.Output,
        D.Failure == E.Failure, D.Output == E.Output {
        return Publishers.Merge5(self, b, c, d, e)
    }

    /// Combines elements from this publisher with those from five other publishers, delivering an interleaved sequence of elements.
    ///
    /// The merged publisher continues to emit elements until all upstream publishers finish. If an upstream publisher produces an error, the merged publisher fails with that error.
    ///
    /// - Parameters:
    ///   - b: A second publisher.
    ///   - c: A third publisher.
    ///   - d: A fourth publisher.
    ///   - e: A fifth publisher.
    ///   - f: A sixth publisher.
    /// - Returns: A publisher that emits an event when any upstream publisher emits an event.
    public func merge<B, C, D, E, F>(with b: B, _ c: C, _ d: D, _ e: E, _ f: F) -> Publishers.Merge6<Self, B, C, D, E, F>
        where B : Publisher, C : Publisher, D : Publisher, E : Publisher, F : Publisher,
        Self.Failure == B.Failure, Self.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output,
        C.Failure == D.Failure, C.Output == D.Output,
        D.Failure == E.Failure, D.Output == E.Output,
        E.Failure == F.Failure, E.Output == F.Output {
            return Publishers.Merge6(self, b, c, d, e, f)
    }

    /// Combines elements from this publisher with those from six other publishers, delivering an interleaved sequence of elements.
    ///
    /// The merged publisher continues to emit elements until all upstream publishers finish. If an upstream publisher produces an error, the merged publisher fails with that error.
    ///
    /// - Parameters:
    ///   - b: A second publisher.
    ///   - c: A third publisher.
    ///   - d: A fourth publisher.
    ///   - e: A fifth publisher.
    ///   - f: A sixth publisher.
    ///   - g: A seventh publisher.
    /// - Returns: A publisher that emits an event when any upstream publisher emits an event.
    public func merge<B, C, D, E, F, G>(with b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) -> Publishers.Merge7<Self, B, C, D, E, F, G>
        where B : Publisher, C : Publisher, D : Publisher, E : Publisher, F : Publisher, G : Publisher,
        Self.Failure == B.Failure, Self.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output,
        C.Failure == D.Failure, C.Output == D.Output,
        D.Failure == E.Failure, D.Output == E.Output,
        E.Failure == F.Failure, E.Output == F.Output,
        F.Failure == G.Failure, F.Output == G.Output {
            return Publishers.Merge7(self, b, c, d, e, f, g)
    }

    /// Combines elements from this publisher with those from seven other publishers, delivering an interleaved sequence of elements.
    ///
    /// The merged publisher continues to emit elements until all upstream publishers finish. If an upstream publisher produces an error, the merged publisher fails with that error.
    ///
    /// - Parameters:
    ///   - b: A second publisher.
    ///   - c: A third publisher.
    ///   - d: A fourth publisher.
    ///   - e: A fifth publisher.
    ///   - f: A sixth publisher.
    ///   - g: A seventh publisher.
    ///   - h: An eighth publisher.
    /// - Returns: A publisher that emits an event when any upstream publisher emits an event.
    public func merge<B, C, D, E, F, G, H>(with b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) -> Publishers.Merge8<Self, B, C, D, E, F, G, H>
        where B : Publisher, C : Publisher, D : Publisher, E : Publisher, F : Publisher, G : Publisher, H : Publisher,
        Self.Failure == B.Failure, Self.Output == B.Output,
        B.Failure == C.Failure, B.Output == C.Output,
        C.Failure == D.Failure, C.Output == D.Output,
        D.Failure == E.Failure, D.Output == E.Output,
        E.Failure == F.Failure, E.Output == F.Output,
        F.Failure == G.Failure, F.Output == G.Output,
        G.Failure == H.Failure, G.Output == H.Output {
            return Publishers.Merge8(self, b, c, d, e, f, g, h)
    }

    /// Combines elements from this publisher with those from another publisher of the same type, delivering an interleaved sequence of elements.
    ///
    /// - Parameter other: Another publisher of this publisher's type.
    /// - Returns: A publisher that emits an event when either upstream publisher emits
    /// an event.
    public func merge(with other: Self) -> Publishers.MergeMany<Self> {
        return Publishers.MergeMany(self, other)
    }
}
