import Vapor

extension Request {
    public var twitter: TwitterVaporClient {
        .init(request: self)
    }

    public struct TwitterVaporClient {
        let request: Request

        public func post(_ tweet: String) -> EventLoopFuture<ClientResponse> {
            self.request.application.twitter.post(tweet)
        }
    }
}
