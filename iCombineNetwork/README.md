# iCombineNetwork
iCombineNetwork provides simple interfaces for making a network call using iCombine.

# Sample

## Test JSON file
`https://swapi.co/api`

## JSON model
```
struct StarWars: Decodable {
    let films: String
}
```

## Retrieve data from the JSON file
```
let client = HTTPClient(session: URLSession.shared)
let url = URL(string: "https://swapi.co/api")!
let subscriber = Subscribers.Sink<StarWars?, HTTPError>(
    receiveCompletion: { print($0) },
    receiveValue: { print($0?.films ?? "") })
let publisher: AnyPublisher<StarWars?, HTTPError> = client.requestObject(from: url, using: .get)
publisher.subscribe(subscriber)
```
