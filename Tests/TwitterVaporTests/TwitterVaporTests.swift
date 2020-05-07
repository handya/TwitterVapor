import XCTVapor

class TwitterVaporTests: XCTestCase {

    func testApplication() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
    }
}

