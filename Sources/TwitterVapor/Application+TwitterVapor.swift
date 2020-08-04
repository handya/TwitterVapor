import Vapor

extension Application {
    public var twitter: TwitterVaporClient {
        .init(application: self)
    }

    public struct TwitterVaporClient {
        let application: Application

        struct ConfigurationKey: StorageKey {
            typealias Value = TwitterVaporCredentials
        }

        public var credentials: TwitterVaporCredentials? {
            get {
                self.application.storage[ConfigurationKey.self]
            }
            nonmutating set {
                self.application.storage[ConfigurationKey.self] = newValue
            }
        }

        var client: TwitterVapor {
            guard let credentials = self.credentials else {
                fatalError("TwitterVapor not configured. Use app.twitter.configuration = ...")
            }
            return .init(credentials: credentials, client: application.client)
        }

        public func post(_ tweet: String) -> EventLoopFuture<ClientResponse> {
            self.client.post(tweet)
        }
    }
}
