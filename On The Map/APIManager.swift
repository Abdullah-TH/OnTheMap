//
//  APIManager.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/17/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import Foundation

class APIManager
{
    static let session = URLSession.shared
    
    static func loginToUdacity(username: String, password: String, completionHandler: @escaping (_ sessionID: String?, _ error: NSError?) -> Void)
    {
        let request = UdacityRouter.createSession(username: username, password: password).asUrlRequest()
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ errorMessage: String)
            {
                print(errorMessage)
                let userInfo = [NSLocalizedDescriptionKey : errorMessage]
                DispatchQueue.main.async {
                    completionHandler(nil, NSError(domain: "loginToUdacity", code: 1, userInfo: userInfo))
                }
            }
            
            guard (error == nil) else
            {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else
            {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else
            {
                sendError("No data was returned by the request!")
                return
            }
            
            // Skip the first 5 characters of the response that Udacity puts for "security purpose"
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            
            do
            {
                let jsonObject = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as? [String: Any]
                
                guard let json = jsonObject else
                {
                    sendError("cannot cast json to [String: Any]")
                    return
                }
                
                guard let sessionDictionary = json["session"] as? [String: Any] else
                {
                    sendError("cannot find key 'session' in the json result")
                    return
                }
                
                guard let sessionID = sessionDictionary["id"] as? String else
                {
                    sendError("cannot find the session id")
                    return
                }
                
                DispatchQueue.main.async {
                    completionHandler(sessionID, nil)  /*** HAPPY END! ***/
                }
            }
            catch let error
            {
                sendError("cannot pars json: \(error)")
            }

        }
        
        task.resume()
    }
    
    static func logoutFromUdacity(completionHandler: @escaping (_ results: String?, _ error: Error?) -> Void)
    {
        let request = UdacityRouter.deleteSession.asUrlRequest()
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ errorMessage: String)
            {
                print(errorMessage)
                let userInfo = [NSLocalizedDescriptionKey : errorMessage]
                DispatchQueue.main.async {
                    completionHandler(nil, NSError(domain: "loginToUdacity", code: 1, userInfo: userInfo))
                }
            }
            
            guard (error == nil) else
            {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else
            {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else
            {
                sendError("No data was returned by the request!")
                return
            }
            
            // Skip the first 5 characters of the response that Udacity puts for "security purpose"
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            
            do
            {
                let jsonObject = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as? [String: Any]
                
                guard let json = jsonObject else
                {
                    sendError("cannot cast json to [String: Any]")
                    return
                }
                
                guard let sessionDictionary = json["session"] as? [String: Any] else
                {
                    sendError("cannot find key 'session' in the json result")
                    return
                }
                
                guard let sessionID = sessionDictionary["id"] as? String else
                {
                    sendError("cannot find the session id")
                    return
                }
                
                DispatchQueue.main.async {
                    completionHandler(sessionID, nil)  /*** HAPPY END! ***/
                }
            }
            catch let error
            {
                sendError("cannot pars json: \(error)")
            }
            
        }
        
        task.resume()
    }
    
    static func getStudentLocations(completionHandler: @escaping (_ results: [StudentLocation]?, _ error: Error?) -> Void)
    {
        let request = ParseRouter.getStudentLocations.asUrlRequest()
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ errorMessage: String)
            {
                print(errorMessage)
                let userInfo = [NSLocalizedDescriptionKey : errorMessage]
                DispatchQueue.main.async {
                    completionHandler(nil, NSError(domain: "getStudentLocations", code: 1, userInfo: userInfo))
                }
            }
            
            guard (error == nil) else
            {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else
            {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else
            {
                sendError("No data was returned by the request!")
                return
            }
            
            do
            {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]

                guard let json = jsonObject else
                {
                    sendError("cannot cast json to [String: Any]")
                    return
                }
                
                guard let results = json["results"] as? [[String: Any]] else
                {
                    sendError("cannot parse json 'results' key")
                    return
                }
                
                var studentLocations = [StudentLocation]()
                for (index, studentLocationsDictionary) in results.enumerated()
                {
                    if let studentLocation = StudentLocation(studentLocationsDictionary: studentLocationsDictionary)
                    {
                        studentLocations.append(studentLocation)
                    }
                    else
                    {
                        print("\nThis student location cannot be parsed: \(results[index])\n")
                    }
                }
                
                DispatchQueue.main.async {
                    completionHandler(studentLocations, nil) /*** HAPPY END! ***/
                }
            }
            catch let error
            {
                sendError("cannot pars json: \(error)")
            }
            
        }
        
        task.resume()
    }
}










