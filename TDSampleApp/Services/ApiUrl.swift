//
//  ApiUrl.swift
//  TDSampleApp
//
//  Created by Jeremy Evans on 2018-05-09.
//  Copyright © 2018 jde. All rights reserved.
//

import Foundation

/**
 URL Scheme
 
 - Http: Standard Internet protocol request
 - Https: Secure Internet protocol request
 */
public enum Scheme : String {
    case Http = "http"
    case Https = "https"
    
    var description : String {
        switch self {
        case .Http: return "http";
        case .Https: return "https";
        }
    }
}

/**
 This enum allows us to target different implementations of the API
 
 - Production: Public facing API
 - QA: Internal API with test data
 - Development: New features for developing
 
 Currently no QA or Development servers exist
 */
public enum Server : String {
    case Production
    case QA
    case Development
    
    var description : String {
        switch self {
        case .QA, .Development, .Production: return "api.duckduckgo.com"
        }
    }
}
/**
 Available formats
 
 - JSON
 - XML
 
 */
public enum Format : String {
    case Json = "json"
    case XML = "xml"
    var description : String {
        let formatString = "&format=%@&pretty=1"
        switch self {
        case .Json: return String.init(format: formatString, "json")
        case .XML: return String.init(format: formatString, "xml")
        }
    }
}

public enum QueryType : String {
    case None
    case Search
    
    var description : String {
        switch self {
        case .None : return ""
        case .Search: return "?q=%@"
        }
    }
}
protocol ApiURLType {
    var server: Server {set get}
    var scheme: Scheme {set get}
    var format: Format {set get}
    var queryType: QueryType {set get}
}

extension ApiURLType {
    var apiURL : URL! {
        return URL.init(string: urlString)
    }
    
    var urlString : String {
        return buildURL()
    }
    
    func buildURL() -> String {
        var buildString : String
        buildString = scheme.description
        buildString += "://"
        buildString += server.description
        buildString += "/"
        buildString += queryType.description
        buildString += format.description
        
        return buildString
    }
    func queryURLString(with search : String) -> String {
        return String.init(format: self.buildURL(), search)
    }
    func queryURL(with search : String) -> URL? {
        return URL.init(string: self.queryURLString(with: search))
    }
}
public class ApiURL : ApiURLType, CustomStringConvertible, CustomDebugStringConvertible {
    
    //ApiQuery protocol variables
    public var server: Server = .Development
    public var scheme: Scheme = .Http
    public var queryType: QueryType = .Search
    public var loadLocal : Bool = false
    public var format: Format = .Json
    
    // CustomStringConvertible protocol variables
    public var description: String {
        return self.buildURL()
    }
    // CustomDebugStringConvertible protocol variables
    public var debugDescription: String {
        return "Scheme: \(self.scheme.description)\nServer: \(self.server.description)\nTarget: \(self.queryType.description)\nFormat: \(self.format.description))"
    }
    
    // Initializer default for different app targets
    public init() {
        #if DEVELOPMENT
        self.server = Server .Development
        #elseif QA
        self.server = Server .QA
        #else
        server = Server .Production
        #endif
    }
}
