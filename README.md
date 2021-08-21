# CombineFoundation

<p align="center">
<img src="https://github.com/adamaszhu/CombineFoundation/raw/master/Resources/logo.png" width="220">
<br /><br />
<img src="https://img.shields.io/badge/platforms-iOS%208.0-333333.svg" />
</p>

CombineFoundation gives developers the ability to use Combine syntax on iOS below 13. In other word, CombineFoundation makes Combine available on iOS 12 to 8.
The way that we do this is to create a wrapper around RxSwift to offer Combine syntax.

**Q: What's the benefit of CombineFoundation?**

**A**: Developers can write Combine code now for their applications to support all the iOS from 15 to 8 and when the time is right, they can do a global find and replace to replace all the `import CombineFoundation` by `import Combine` and everything will just work.

## How to use
```swift
import CombineFoundation

let subscriber = Subscribers.Sink<Int, Never>(
    receiveCompletion: { completion in
        print(completion)
    }) { value in
        print(value)
    }
Publishers
      .Sequence<[Int], Never>(sequence: [1, 2, 3, 4])
      .receive(subscriber: subscriber)
```

## Snippet
To bridge CombineFoundation with ReactiveSwift, please use this snippet [CombineFoundation+Convertable.swift](Snippet/CombineFoundation+Convertable.swift)

For ReactiveSwift 5.x please use this snippet [CombineFoundation+ReactiveSwift5.swift](Snippet/CombineFoundation+ReactiveSwift5.swift)

## WIP

### Publisher
- [x] receive<S\>(subscriber: S)
- [x] eraseToAnyPublisher

#### AnyPublisher
- [x] init<P\>(_ publisher: P)

#### Just
- [x] init

#### HandleEvents
- [x] init
- [x] handleEvents

#### Map
- [x] map
- [x] tryMap

#### MapError
- [x] init(upstream: Upstream, transform: @escaping (Upstream.Failure) -> Failure)
- [x] init(upstream: Upstream, _ map: @escaping (Upstream.Failure) -> Failure)
- [x] mapError

### Publishers
#### TryMap
- [x] map
- [x] tryMap

#### Map
- [x] init(upstream: Upstream, transform: @escaping (Upstream.Output) -> Output)
- [x] map
- [x] tryMap

#### Sequence
- [x] init
- [x] map


- [x] append(_ publisher: Publishers.Sequence<Elements, Failure>)
- [x] append<S\>(_ elements: S)
- [x] append(_ elements: Publishers.Sequence<Elements, Failure>.Output...)
- [x] prepend(_ publisher: Publishers.Sequence<Elements, Failure>)
- [x] prepend<S\>(_ elements: S)
- [x] prepend(_ elements: Publishers.Sequence<Elements, Failure>.Output...)


- [ ] allSatisfy
- [ ] tryAllSatisfy
- [ ] collect
- [ ] compactMap
- [ ] contains
- [ ] tryContains
- [ ] drop
- [ ] dropFirst
- [ ] filter
- [ ] ignoreOutput
- [ ] prefix(_ maxLength: Int)
- [ ] prefix(while predicate: (Elements.Element) -> Bool)
- [ ] reduce
- [ ] tryReduce
- [ ] replaceNil
- [ ] scan
- [ ] setFailureType

### Subject
- [x] behaviourSubject
- [ ] send(_ value: Self.Output)
- [ ] send(completion: Subscribers.Completion<Self.Failure>)
- [ ] send(subscription: Subscription)

#### CurrentValueSubject
- [x] init
- [ ] send(subscription: Subscription)
- [ ] send(_ input: Output)
- [ ] send(completion: Subscribers.Completion<Failure>)

### Subscribers
#### Completion
- [x] finished
- [x] failure(Failure)

### Subscriber
- [ ] receive(subscription: Subscription)
- [ ] receive(_ input: Self.Input)
- [ ] receive(completion: Subscribers.Completion<Self.Failure>)

#### Sink
- [x] init
- [ ] disposable
- [ ] receiveValue
- [ ] receiveCompletion
- [ ] receive(subscription: Subscription)
- [ ] receive(_ value: Input) -> Subscribers.Demand
- [ ] receive(completion: Subscribers.Completion<Failure>)
- [ ] cancel

### Cancellable
- [x] cancel

#### Subscription
- [x] request

### And more ...
|RxSwift|Combine|Notes|
|-------|-------|-----|
|ConnectableObservableType|ConnectablePublisher||
|Driver|BindableObject(SwiftUI)|Both guarantee no failure, but Driver guarantees delivery on Main Thread. In Combine, SwiftUI recreates the entire view hierarchy on the Main Thread, instead.|
|Single|Future|They're only similar in the sense of single emission, but Future shares resources and executes immediately (very strange behavior)|
|bind(to:)|assign(to: on:)|Assign uses a KeyPath which is really nice and useful. RxSwift needs a Binder / ObserverType to bind.|
|buffer|buffer||
|combineLatest|combineLatest, tryCombineLatest||
|compactMap|compactMap, tryCompactMap||
|debounce|debounce||
|deferred|Publishers.Deferred||
|delay|delay||
|elementAt|output(at:)||
|flatMapLatest|switchToLatest||
|ignoreElements|ignoreOutput||
|merge|merge, tryMerge||
|merge(maxConcurrent:)|flatMap(maxPublishers:)||
|multicast|multicast||
|publish|makeConnectable||
|reduce|reduce, tryReduce||
|refCount|autoconnect||
|scan|scan, tryScan||
|share|share|There’s no replay or scope in Combine. Could be “faked” with multicast.|
|startWith|prepend||
|subscribeOn|subscribe(on:)|RxSwift uses Schedulers. Combine uses RunLoop, DispatchQueue, and OperationQueue.|
|takeUntil|prefix(untilOutputFrom:)||
|throttle|throttle||
|timeout|timeout||
|timer|Timer.publish||
|toArray()|collect()||
|window|collect(Publishers.TimeGroupingStrategy)|Combine has a TimeGroupingStrategy.byTimeOrCount that could be used as a window.|
