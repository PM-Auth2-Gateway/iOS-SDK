import XCTest
@testable import AuthPM

final class AuthPMTests: XCTestCase {
    
    var networkServiceMock = NetworkServiceMock()
    lazy var authSystem = AuthPM(appId: 123, deepLinkingScheme: "123", delegate: MockedDelegate())
    
    override func tearDown() {
        networkServiceMock.getUserProfileCallCounter = 0
        networkServiceMock.getServiceListCallCounter = 0
        networkServiceMock.getLinkComponentsCallCounter = 0
    }
    
    func testGetsAvailableServices() {
        authSystem.getServiceList(with: networkServiceMock)
        XCTAssertEqual(networkServiceMock.getServiceListCallCounter, 1)
    }

}

fileprivate class MockedDelegate: AuthPMDelegate {
    func didFinishAuthorization(with profile: UserProfile?) {
        return
    }
}
