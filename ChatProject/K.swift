//
//  K.swift
//  ChatProject
//
//  Created by Çiğdem Alan on 8.12.2023.
//

import Foundation

 
struct K {
    
    static let logInSegue = "logInToChat"
    static let registerSegue = "registerToChat"
    static let cellIdentifier = "reuseableCell"
    static let cellNibName  = "TableViewCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
