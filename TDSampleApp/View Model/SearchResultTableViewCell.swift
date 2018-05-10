//
//  SearchResultTableViewCell.swift
//  TDSampleApp
//
//  Created by Jeremy Evans on 2018-05-09.
//  Copyright © 2018 jde. All rights reserved.
//

import Foundation

import UIKit

class SearchResultTableViewCell : UITableViewCell, TableCellProtocol {
    
    static var identifier: String = "searchResult"
    @IBOutlet weak var iconImage : UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(from record:Topic){
        descriptionLabel.text = record.title
        let url = record.icon?.getURL()
        if url != nil {
            getImage(from: url!)
        }
        
        setupAccessibility()
    }
    func setupAccessibility(){
        descriptionLabel.isAccessibilityElement = false
        self.isAccessibilityElement = true
        self.accessibilityValue = "\(String(describing: descriptionLabel?.text))"
        self.accessibilityTraits = UIAccessibilityTraitButton
        //FIXME: String literals should read from Localized source
        self.accessibilityHint = "Double-tap for details"
    }

    func getImage(from url: URL) {
        DownloadService.fetchData(fromURL: url) { (data) in
            DispatchQueue.main.async() {
                self.iconImage.image = UIImage(data: data)
            }
        }
    }
}
