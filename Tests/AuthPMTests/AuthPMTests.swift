import XCTest
@testable import AuthPM

final class AuthPMTests: XCTestCase {
    
    var networkServiceMock = NetworkServiceMock()
    lazy var authSystem = AuthPM(appId: 123, deepLinkingScheme: "123", delegate: MockedDelegate())
    
    override func tearDown() {
        networkServiceMock.clearCounters()
    }
    
    func testGetsAvailableServices() {
        authSystem.getServiceList(with: networkServiceMock)
        XCTAssertEqual(networkServiceMock.serviceListCallCounter, 1)
    }
}

fileprivate class MockedDelegate: AuthPMDelegate {
    func didFinishAuthorization(with profile: UserProfile?) {
        return
    }
}
