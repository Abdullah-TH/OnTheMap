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
    case getStudentLocations
    case getAStudentLocation
    case createAStudentLocation
    case updateAStudentLocation(objectID: String)
    
    // Base URL
    static let baseURLString = "https://parse.udacity.com/parse/classes/"
    
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
            return "StudentLocation"
        case .updateAStudentLocation(let objectID):
            return "StudentLocation/\(objectID)"
        }
    }
    
    // Parameters
    var parameters: Data? {
        let parametersDictionary = [String: Any]()
        
        let data = try? JSONSerialization.data(withJSONObject: parametersDictionary, options: .prettyPrinted)
        return data
    }
    
    func asUrlRequest() -> URLRequest
    {
        var url = URL(string: ParseRouter.baseURLString)!
        url = url.appendingPathComponent(relativePath)
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Headers
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        request.httpBody = parameters
        
        return request
    }
}













