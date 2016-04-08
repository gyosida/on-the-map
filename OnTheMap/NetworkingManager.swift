//
//  NetworkingManager.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/11/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class NetworkingManager {
    
    private let sharedSession = NSURLSession.sharedSession()
    private let scheme: String
    private let host: String
    private let reduceDataLength: Bool
    
    convenience init(host: String) {
        self.init(scheme: "https", host: host)
    }
    
    convenience init(scheme: String, host: String) {
        self.init(scheme: scheme, host: host, reduceDataLength: false)
    }
    
    init(scheme: String, host: String, reduceDataLength: Bool) {
        self.scheme = scheme
        self.host = host
        self.reduceDataLength = reduceDataLength
    }
    
    func makeHttpRequest(httpMethod: HTTPMethod, resourcePath: String, queryParams: [String:AnyObject]?, bodyParameters:[String: AnyObject]?, completionHandler: (result: AnyObject?, error: NSError?) -> Void) {
        let urlRequest = self.createURLRequest(httpMethod, resourcePath: resourcePath, queryParams: queryParams, bodyParameters: bodyParameters, headers: nil)
        self.makeHttpRequest(urlRequest, completionHandler: completionHandler)
    }
    
    func makeHttpRequest(request: NSMutableURLRequest, completionHandler: (result: AnyObject?, error: NSError?) -> Void) {
        let task = self.sharedSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let error = self.responseWithErrors(response, error: error) {
                completionHandler(result: nil, error: error)
            } else {
                if let parsedResult = self.rawDataToObject(data!) {
                    print("------------ JSON Response ------------")
                    print("\(parsedResult)")
                    performUIUpdatesOnMain({ () -> Void in
                        completionHandler(result: parsedResult, error: nil)
                    })
                } else {
                    let error = NSError(domain: "makeHttpPOSTRequest", code: 1, userInfo: [NSLocalizedDescriptionKey : "Could not parse the raw json"])
                    performUIUpdatesOnMain({ () -> Void in
                        completionHandler(result: nil, error: error)
                    })
                }
            }
        }
        task.resume()
    }
    
    func createURLRequest(method: HTTPMethod, resourcePath: String, queryParams: [String:AnyObject]?, bodyParameters:[String: AnyObject]?, headers: [String: String]?) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: self.buildUrl(resourcePath, queryParams: queryParams))
        request.HTTPMethod = method.rawValue
        if let bodyParameters = bodyParameters {
            request.HTTPBody = self.bodyDictionaryToJsonAsData(bodyParameters)
            print("------------ JSON Body Request ------------")
            print(String(data: request.HTTPBody!, encoding: NSUTF8StringEncoding))
        }
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func subtituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }
    
    private func buildUrl(resourcePath: String, queryParams: [String:AnyObject]?) -> NSURL {
        let urlComponent = NSURLComponents()
        urlComponent.scheme = self.scheme
        urlComponent.host = self.host
        urlComponent.path = resourcePath ?? ""
        if let queryParams = queryParams {
            if !queryParams.isEmpty {
                var queryItems = [NSURLQueryItem]()
                for (key, value) in queryParams {
                    let queryItem = NSURLQueryItem(name: key, value: "\(value)")
                    queryItems.append(queryItem)
                }
                urlComponent.queryItems = queryItems
            }
        }
        let url = urlComponent.URL!
        print("------------ URL ------------")
        print(url)
        return url
    }
    
    private func responseWithErrors(response: NSURLResponse?, error: NSError?) -> NSError? {
        guard error == nil else {
            return NSError(domain: "responseWithNoErrors", code: 1, userInfo: [NSLocalizedDescriptionKey : "\(error)"])
        }
        guard let httpResponse = response as? NSHTTPURLResponse where httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            return NSError(domain: "responseWithErrors", code: 1, userInfo: [NSLocalizedDescriptionKey : "Your request returned a status code other than 2xx"])
        }
        return nil
    }
    
    private func rawDataToObject(var data: NSData) -> AnyObject? {
        do {
            if self.reduceDataLength {
                data = data.subdataWithRange(NSMakeRange(5, data.length - 5))
            }
            return try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            return nil
        }
    }
    
    private func bodyDictionaryToJsonAsData(body: [String:AnyObject]) -> NSData? {
        do {
            return try NSJSONSerialization.dataWithJSONObject(body, options: .PrettyPrinted)
        } catch {
            return nil
        }
    }
    
}

enum HTTPMethod : String {
    case GET
    case POST
    case PUT
}
