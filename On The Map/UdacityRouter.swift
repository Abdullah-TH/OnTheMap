//
//  UdacityClient.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/17/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//
//  Networking Architecture inspired by Almofire

import Foundation

enum UdacityRouter
{
    // Possible requests 
    case createSession(username: String, password: String)
    case deleteSession
    case publicUserData(userID: String)
    
    // Base URL
    static let baseURLString = "https://www.udacity.com/api/"
    
    // Method 
    var method: String {
        switch self
        {
        case .createSession:
            return "POST"
        case .deleteSession:
            return "DELETE"
        case .publicUserData(userID: _):
            return "GET"
        }
    }
    
    // Relative path
    var relativePath: String {
        switch self
        {
        case .createSession, .deleteSession:
            return "session"
        case .publicUserData(userID: let id):
            return "users/\(id)"
        }
    }
    
    // Parameters
    var parameters: Data? {
        var parametersDictionary = [String: Any]()
        
        switch self
        {
        case .createSession(username: let user, password: let pass):
            parametersDictionary["udacity"] = ["username": user, "password": pass]
        default:
            break
        }
        
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
        var url = URL(string: UdacityRouter.baseURLString)!
        url = url.appendingPathComponent(relativePath)
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Headers 
        switch self
        {
        case .createSession(username: _, password: _):
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        case .deleteSession:
            var xsrfCookie: HTTPCookie? = nil
            let sharedCookieStorage = HTTPCookieStorage.shared
            for cookie in sharedCookieStorage.cookies!
            {
                if cookie.name == "XSRF-TOKEN"
                {
                    xsrfCookie = cookie
                }
            }
            if let xsrfCookie = xsrfCookie
            {
                request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
            }
        default:
            break 
        }
        
        request.httpBody = parameters
        
        return request
    }
}













