import XCTest
@testable import AppwriteTools

final class AppwriteToolsTests: XCTestCase {
    
    func testEmailValidation() {
        let email = "test@test.test"
        
        let valid = email.isValidEmail
        
        XCTAssertEqual(true, valid)
    }
    
}
