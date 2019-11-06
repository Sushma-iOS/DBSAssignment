

import XCTest
@testable import DBS_Assignment

class DBS_AssignmentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testContactsViewModel() {
        let contactModel = Contact(context: CoredataManager.shared.context)
        contactModel.name = "DBS"
        contactModel.phoneNumber = "+91 9876456789"
        contactModel.image = "Contact1"
        contactModel.id = "2145"
        let contactViewModel = ContactsViewModel(coreDataModel: contactModel)
        
        XCTAssertEqual(contactModel.phoneNumber, contactViewModel.phoneNumber)
    }

    

}
