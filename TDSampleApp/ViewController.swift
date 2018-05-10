//
//  ViewController.swift
//  TDSampleApp
//
//  Created by Jeremy Evans on 2018-05-08.
//  Copyright © 2018 jde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        let apiURL = ApiURL()
        guard let url = apiURL.queryURL(with: "apple") else {
            return
        }
        DownloadService.fetchData(fromURL: url) { (data) in
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(SearchResults.self, from: data)
            } catch  {
                print("Unable to parse JSON")
            }
        }
    }

}

