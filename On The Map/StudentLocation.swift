//
//  StudentLocation.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/14/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import Foundation

struct StudentLocation
{
    var objectID: String
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
    var createdAt: String
    var updatedAt: String
    
    init?(studentLocationsDictionary: [String: Any])
    {
        if let objectID = studentLocationsDictionary["objectId"] as? String,
           let uniqueKey = studentLocationsDictionary["uniqueKey"] as? String,
           let firstName = studentLocationsDictionary["firstName"] as? String,
           let lastName = studentLocationsDictionary["lastName"] as? String,
           let mapString = studentLocationsDictionary["mapString"] as? String,
           let mediaURL = studentLocationsDictionary["mediaURL"] as? String,
           let latitude = studentLocationsDictionary["latitude"] as? Double,
           let longitude = studentLocationsDictionary["longitude"] as? Double,
           let createdAt = studentLocationsDictionary["createdAt"] as? String,
           let updatedAt = studentLocationsDictionary["updatedAt"] as? String
        {
            self.objectID = objectID
            self.uniqueKey = uniqueKey
            self.firstName = firstName
            self.lastName = lastName
            self.mapString = mapString
            self.mediaURL = mediaURL
            self.latitude = latitude
            self.longitude = longitude
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }
        else
        {
            return nil 
        }
    }
}
