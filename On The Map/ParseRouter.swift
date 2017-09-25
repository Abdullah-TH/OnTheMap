//
//  ParseClient.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/17/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//
//  Networking Architecture inspired by Almofire

import Foundation

enum ParseRouter
{
    // Possible requests
    case getStudentLocations(limit: Int)
    case getAStudentLocation
    case createAStudentLocation(uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double)
    case updateAStudentLocation(objectID: String)
    
    // Base URL
    static let baseURLString = "https://parse.udacity.com"
    
    // Method
    var method: String {
        switch self
        {
        case .getStudentLocations, .getAStudentLocation:
            return "GET"
        case .createAStudentLocation:
            return "POST"
        case .updateAStudentLocation:
            return "PUT"
        }
    }
    
    // Relative path
    var relativePath: String {
        switch self
        {
        case .getStudentLocations, .getAStudentLocation, .createAStudentLocation:
            return "/parse/classes/StudentLocation"
        case .updateAStudentLocation(let objectID):
            return "/parse/classes/StudentLocation/\(objectID)"
        }
    }
    
    // Query Items
    var quryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        switch self
        {
        case .getStudentLocations(let limit):
            items.append(URLQueryItem(name: "limit", value: "\(limit)"))
        default:
            break
        }
        return items
    }
    
    // Parameters
    var parameters: Data? {
        
        var parametersDictionary = [String: Any]()
        
        switch self
        {
        case .createAStudentLocation(let uniqueKey, let firstName, let lastName, let mapString, let mediaURL, let latitude, let longitude):
            parametersDictionary["uniqueKey"] = uniqueKey
            parametersDictionary["firstName"] = firstName
            parametersDictionary["lastName"] = lastName
            parametersDictionary["mapString"] = mapString
            parametersDictionary["mediaURL"] = mediaURL
            parametersDictionary["latitude"] = latitude
            parametersDictionary["longitude"] = longitude
            break
        default:
            break
        }
        
        // if there are no parameters, must return nil. Empty dictionary may cause the HTTP request to fail
        if parametersDictionary.isEmpty
        {
            return nil
        }
        else
        {
            let data = try? JSONSerialization.data(withJSONObject: parametersDictionary, options: .prettyPrinted)
            return data
        }
    }
    
    func asUrlRequest() -> URLRequest
    {
        var urlComponents = URLComponents(string: ParseRouter.baseURLString)
        urlComponents?.path = relativePath
        urlComponents?.queryItems = quryItems
        let url = urlComponents?.url
        print(urlComponents ?? "nil")
        print(url ?? "nil")
        var request = URLRequest(url: url!)
        request.httpMethod = method
        
        // Headers
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        switch self
        {
        case .createAStudentLocation(_, _, _, _, _, _, _):
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        default:
            break
        }
        
        request.httpBody = parameters
        
        return request
    }
}













