//
//  UdacityUser.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/19/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import Foundation

struct UdacityUser
{
    static var currentUdacityUser: UdacityUser!
    
    var firstName: String
    var lastName: String
    var key: String
    
    init?(userDictionary: [String: Any])
    {
        if let firstName = userDictionary["first_name"] as? String,
           let lastName = userDictionary["last_name"] as? String,
           let key = userDictionary["key"] as? String
        {
            self.firstName = firstName
            self.lastName = lastName
            self.key = key
        }
        else
        {
            return nil 
        }
    }
}






















