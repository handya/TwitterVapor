//
//  TwitterVapor.swift
//  TwitterVapor
//
//  Created by Andrew Farquharson on 7/05/20.
//

import Vapor
import OhhAuth

public class TwitterVapor {

    // MARK: - Properties

    private let credentials: Credentials

    private let client: Client

    private static let postURL: String = "https://api.twitter.com/1.1/statuses/update.json"

    // MARK: - Lifecycle

    init(credentials: Credentials, client: Client) {
        self.credentials = credentials
        self.client = client
    }

    // MARK: - Functions

    public func post(_ tweet: String) -> EventLoopFuture<ClientResponse> {
        let url: URL = URL(string: "\(TwitterVapor.postURL)?status=\(tweet.urlEncodedString())")!
        let signature = OhhAuth.calculateSignature(url: url,
                                                   method: "POST",
                                                   parameter: [:],
                                                   consumerCredentials: credentials.consumer.ohhAuthCredentials,
                                                   userCredentials: credentials.user.ohhAuthCredentials)

        var headers: HTTPHeaders = .init()
        headers.add(name: "Authorization", value: signature)
        headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
        return client.post(URI(string: url.absoluteString), headers: headers)
    }
}

// MARK: - Credentials

public extension TwitterVapor {
    struct Credentials {
        public let consumer: Credential
        public let user: Credential

        public init(consumer: Credential, user: Credential) {
            self.consumer = consumer
            self.user = user
        }
    }

    struct Credential {
        public let key: String
        public let secret: String

        public init(key: String, secret: String) {
            self.key = key
            self.secret = secret
        }

        var ohhAuthCredentials: OhhAuth.Credentials {
            return (key: key, secret: secret)
        }
    }
}

private extension String {
    func urlEncodedString() -> String {
        var allowedCharacterSet: CharacterSet = .urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\n:#/?@!$&'()*+,;=")
        allowedCharacterSet.insert(charactersIn: "[]")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? ""
    }
}
