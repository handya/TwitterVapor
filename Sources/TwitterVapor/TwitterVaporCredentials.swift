//
//  File.swift
//  
//
//  Created by Andrew Farquharson on 4/08/20.
//

import OhhAuth

public struct TwitterVaporCredentials {
    public let consumer: TwitterVaporCredential
    public let user: TwitterVaporCredential

    public init(consumer: TwitterVaporCredential, user: TwitterVaporCredential) {
        self.consumer = consumer
        self.user = user
    }
}

public struct TwitterVaporCredential {
    public let key: String
    public let secret: String

    public init(key: String, secret: String) {
        self.key = key
        self.secret = secret
    }

    var asOhhAuth: OhhAuth.Credentials {
        return (key: key, secret: secret)
    }
}
