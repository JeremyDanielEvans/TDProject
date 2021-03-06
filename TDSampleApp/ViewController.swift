//
//  ViewController.swift
//  TDSampleApp
//
//  Created by Jeremy Evans on 2018-05-08.
//  Copyright © 2018 jde. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    //Datasource should be moved from 
    var searchData : SearchResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.delegate = self
        table.dataSource = self
        
        self.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Considered making this a protocol
    func fetchData() {
        let apiURL = ApiURL()
        guard let url = apiURL.queryURL(with: "apple") else {
            return
        }
        DownloadService.fetchData(fromURL: url) { (data) in
            //requires more error checking
            do {
                let decoder = JSONDecoder()
                self.searchData = try decoder.decode(SearchResults.self, from: data)
                DispatchQueue.main.async { () -> Void in
                    self.table.reloadData()
                }
            } catch  {
                print("Unable to parse JSON")
            }
        }
    }

}

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchData != nil {
            return (searchData?.numSections())!
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchData?.getTitle(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchData?.numRows(forSection: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SearchResultTableViewCell =  tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as! SearchResultTableViewCell
        
        let searchResult = searchData?.getRecord(indexPath: indexPath)
        if searchResult != nil {
            cell.configure(from: searchResult!)
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let searchResult = searchData?.getRecord(indexPath: indexPath) else {
            return
        }
        if let urlString = searchResult.url {
            if let url = URL(string: urlString) {
                let safariVC = SFSafariViewController(url: url )
                self.present(safariVC, animated: true, completion: nil)
            }
        }
    }
    
}
