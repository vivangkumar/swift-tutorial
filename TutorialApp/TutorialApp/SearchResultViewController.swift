//
//  ViewController.swift
//  TutorialApp
//
//  Created by Vivan Kumar on 12/11/2014.
//  Copyright (c) 2014 Vivan Kumar. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, APIControllerProtocol {
    
    @IBOutlet var appsTableView: UITableView?
    var api = APIController()
    var tableData = []
    let activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.api.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Test Cell")
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        cell.textLabel.text = rowData["trackName"] as? String
        
        let urlString: NSString = rowData["artworkUrl60"] as NSString
        let imgURL: NSURL? = NSURL(string: urlString)
        
        let imgData = NSData(contentsOfURL: imgURL!)
        cell.imageView.image = UIImage(data: imgData!)
        
        let formattedPrice: NSString = rowData["formattedPrice"] as NSString
        cell.detailTextLabel?.text = formattedPrice
        return cell
    }
    
    func didReceiveAPICallResults(results: NSDictionary) {
        var resultsArray: NSArray = results["results"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            
            self.hideLoadingView()
            self.tableData = resultsArray
            self.appsTableView!.reloadData()
        })
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if (!searchText.isEmpty){
            showLoadingView()
            api.searchItunesFor(searchText)
        }
        else{
            println("Here")
        }
    }
    
    func showLoadingView(){
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoadingView(){
        self.activityIndicator.stopAnimating()
    }

}

