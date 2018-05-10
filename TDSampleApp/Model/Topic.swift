//
//  Topic.Swift
//  TDSampleApp
//
//  Created by Jeremy Evans on 2018-05-08.
//  Copyright © 2018 jde. All rights reserved.
//

import Foundation

struct Topic: Decodable {
    let url: String?
    let title: String?
    let icon : Icon?
    
    enum CodingKeys : String, CodingKey {
        case url = "FirstURL"
        case title = "Text"
        case icon = "Icon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        icon = try container.decode(Icon.self, forKey: .icon)
    }
}
