//
//  SearchResults.swift
//  TDSampleApp
//
//  Created by Jeremy Evans on 2018-05-08.
//  Copyright © 2018 jde. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let title: String
    let homepageURL: String
    let topics : [TopicList]
    let topic : [Topic]
    
    enum CodingKeys : String, CodingKey {
        case title = "Heading"
        case homepageURL = "AbstractURL"
        case related = "RelatedTopics"
        case topics = "Topics"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        homepageURL = try container.decode(String.self, forKey: .homepageURL)
        
        var relatedArray = try container.nestedUnkeyedContainer(forKey: .related)
        var topicArray: [Topic] = []
        var topicsArray: [TopicList] = []
        
        while !relatedArray.isAtEnd {
            do {
                let topicData = try? relatedArray.decode(Topic.self)
                if let topic = topicData {
                    topicArray.append(topic)
                } else {
                    let topicsData = try? relatedArray.decode(TopicList.self)
                    if let topics = topicsData {
                        topicsArray.append(topics)
                    }
                }
            }
        }
        topic = topicArray
        topics = topicsArray
    }
}
