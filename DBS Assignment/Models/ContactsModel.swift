

import Foundation

struct ContactsModel: Decodable {
    var id: String
    var name: String
    var phoneNumber: String
    var email: String
    var favourite: Bool
    var image: String
}
