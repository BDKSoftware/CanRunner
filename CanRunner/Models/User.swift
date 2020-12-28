//
//  User.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/20/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//
class User {
    
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
