

import Foundation
import UIKit

struct ContactsViewModel: ParsingHandler {
    var id: String?
    var name: String?
    var image: String?
    var phoneNumber: String?
    var favourite: Bool
    var email: String?
    
    var viewModelArray = [ContactsViewModel]()
    
    // Dependency Injection
    init(coreDataModel: Contact) {
        self.id = coreDataModel.id
        self.name = coreDataModel.name
        self.image = coreDataModel.image
        self.phoneNumber = coreDataModel.phoneNumber
        self.email = coreDataModel.email
        self.favourite = coreDataModel.favourite
       
        }
    
}
