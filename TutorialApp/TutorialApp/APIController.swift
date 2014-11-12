//
//  APIController.swift
//  TutorialApp
//
//  Created by Vivan Kumar on 12/11/2014.
//  Copyright (c) 2014 Vivan Kumar. All rights reserved.
//

import Foundation

class APIController{
    
    var delegate: APIControllerProtocol?
    
    init(){
        
    }
    
    func searchItunesFor(searchTerm: String) {
        
        // Multiple search terms seperated by "+"
        let iTunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Escape URL unfriendly stuff
        if let escapedSearchTerm = iTunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            let urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
            let url = NSURL(string: urlPath)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
                if(error != nil) {
                    println(error.localizedDescription)
                }
                var err: NSError?
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                if(err != nil){
                    println("JSON Error \(err!.localizedDescription)")
                }
                
                let results: NSArray = jsonResult["results"] as NSArray
                self.delegate?.didReceiveAPICallResults(jsonResult)
            })
            
            task.resume()
        }
    }

}

protocol APIControllerProtocol{
    func didReceiveAPICallResults(results: NSDictionary)
}