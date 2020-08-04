# TwitterVapor

![Swift Tests](https://github.com/handya/TwitterVapor/workflows/Swift%20Tests/badge.svg) ![SwiftLint](https://github.com/handya/TwitterVapor/workflows/SwiftLint/badge.svg)

Use TwitterVapor to easily send tweets from your vapor server. This is a work in progress and currently only supports sending tweets to one account.

### Setup:
```swift
    let consumerCredentials = TwitterVaporCredential(key: Environment.get("CONSUMER_KEY")!, secret: Environment.get("CONSUMER_SECRET")!)
    let userCredentials = TwitterVaporCredential(key: Environment.get("USER_KEY")!, secret: Environment.get("USER_SECRET")!)
    app.twitter.credentials = TwitterVaporCredentials(consumer: consumerCredentials, user: userCredentials)
```

### Usage:
```swift
    func postTweet(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let tweet = req.query[String.self, at: "tweet"] else {
            throw Abort(.badRequest)
        }
        return req.twitter.post(tweet).transform(to: .ok)
    }
```

### Dependencies:
- [OhhAuth](https://github.com/handya/OhhAuth) - Modified to use [SwiftCrypto](https://github.com/apple/swift-crypto.git)
- [Vapor 4](https://github.com/vapor/vapor)

Currently used for [@RivrForiOS](https://twitter.com/rivrforios)