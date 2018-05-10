//
//  Icon.swift
//  TDSampleApp
//
//  Created by Jeremy Evans on 2018-05-08.
//  Copyright © 2018 jde. All rights reserved.
//

import Foundation

struct Icon: Decodable {
    let height : Int?
    let width : Int?
    let url : String?
    
    enum CodingKeys : String, CodingKey {
        case height = "Height"
        case width = "Width"
        case url = "URL"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            let heightValue = try container.decode(String.self, forKey: .height)
            height = Int(heightValue)
        } catch {
            height = try container.decode(Int.self, forKey: .height)
        }
        
        do {
            let widthValue = try container.decode(String.self, forKey: .width)
            width = Int(widthValue)
        } catch {
            width = try container.decode(Int.self, forKey: .height)
        }
        
        url = try container.decode(String.self, forKey: .url)
    }
    
    func getURL() -> URL? {
        return URL.init(string: self.url!)
    }
}
