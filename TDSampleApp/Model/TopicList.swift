//
//  TopicList.swift
//  TDSampleApp
//
//  Created by Jeremy Evans on 2018-05-08.
//  Copyright © 2018 jde. All rights reserved.
//

import Foundation

struct TopicList: Decodable {
    let name: String
    let topics: [Topic]
    
    enum CodingKeys : String, CodingKey {
        case name = "Name"
        case topics = "Topics"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        topics = try container.decode([Topic].self, forKey: .topics)
    }
    
}
