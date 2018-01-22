//
//  FilmsViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Peisure on 1/22/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

class FilmsViewController: UITableViewController {
    var films = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // specify the url that we will be sending the GET Request to
        let url = URL(string: "http://swapi.co/api/films/")
        // create a URLSession to handle the request tasks
        let session = URLSession.shared
        // create a "data task" to make the request and run the completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let nextPages = jsonResult["next"]{
                        print(type(of:nextPages))
                    }
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSArray
                        for reuslt in resultsArray{
                            let person = reuslt as! NSDictionary
                            self.films.append(person["title"] as! String)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print(error)
            }
        })
        
        // execute the task and wait for the response before
        // running the completion handler. This is async!
        task.resume()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return films.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = films[indexPath.row]
        // return the cell so that it can be rendered
        return cell
    }

}
