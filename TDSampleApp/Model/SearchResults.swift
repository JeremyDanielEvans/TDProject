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
    
    func numSections() -> Int {
        var sectionCount = 0
        if topic.count > 0 {
            sectionCount += 1
        }
        if topics.count > 0 {
            sectionCount += topics.count
        }
        return sectionCount
    }
    
    func numRows(forSection section : Int) -> Int {
        var rowCount = 0
        
        if section == 0 {
            rowCount = topic.count
        } else if section > 0 {
            let list = topics[section-1]
            rowCount = list.topics.count
        }
        
        return rowCount
    }
    
    func getTitle(forSection section : Int) -> String {
        var title = ""
        
        if section > 0 {
            let list = topics[section-1]
            title = list.name
        }
        
        return title
    }
    
    func getRecord(indexPath : IndexPath) -> Topic {
        if indexPath.section == 0 {
            return topic[indexPath.row]
        } else {
            let list = topics[indexPath.section-1]
           return list.topics[indexPath.row]
        }
    }
    
}
