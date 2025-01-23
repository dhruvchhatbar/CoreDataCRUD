//
//  StringConstants.swift
//  CoreDataCRUD
//
//  Created by Dhruv Chhatbar on 13/01/24.
//

import Foundation
import UIKit

struct StringConstants{
    static let userName = "username"
    static let password = "password"
    static let emailId = "email"
    static let entityName = "Users"
    static let primaryColor = #colorLiteral(red: 0.8425284624, green: 0.3609386086, blue: 0.1379078925, alpha: 1)
}
class DataModel{
    var userName : String = ""
    var password : String = ""
    var emailId : String = ""
    init(userName: String, password: String, emailId: String) {
        self.userName = userName
        self.password = password
        self.emailId = emailId
    }
}
