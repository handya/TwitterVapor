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

    private let credentials: TwitterVaporCredentials

    private let client: Client

    private static let postURL: String = "https://api.twitter.com/1.1/statuses/update.json"

    // MARK: - Lifecycle

    init(credentials: TwitterVaporCredentials, client: Client) {
        self.credentials = credentials
        self.client = client
    }

    // MARK: - Functions

    public func post(_ tweet: String) -> EventLoopFuture<ClientResponse> {
        let url: URL = URL(string: "\(TwitterVapor.postURL)?status=\(tweet.urlEncodedString())")!
        let signature = OhhAuth.calculateSignature(url: url,
                                                   method: "POST",
                                                   parameter: [:],
                                                   consumerCredentials: credentials.consumer.asOhhAuth,
                                                   userCredentials: credentials.user.asOhhAuth)

        var headers: HTTPHeaders = HTTPHeaders()
        headers.add(name: "Authorization", value: signature)
        headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
        return client.post(URI(string: url.absoluteString), headers: headers)
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
