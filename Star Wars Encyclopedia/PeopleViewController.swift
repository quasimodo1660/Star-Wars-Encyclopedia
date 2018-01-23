//
//  ViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Peisure on 1/22/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {
    var people = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        StarWarsModel.getAllPeople(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
            data, response, error in
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        for person in results {
                            let personDict = person as! NSDictionary
                            self.people.append(personDict)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Something went wrong")
            }
        })
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
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row]["name"] as? String
        // return the cell so that it can be rendered
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "personSegue"{
            print("here")
            let detail = segue.destination as! detailsViewController
            if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell){
                detail.label1 = "Name: \(String(describing: people[indexPath.row]["name"]!))"
                detail.label2 = "Gender: \(String(describing: people[indexPath.row]["gender"]!))"
                detail.label3 = "Birth Year: \(String(describing: people[indexPath.row]["birth_year"]!))"
                detail.label4 = "Mass: \(String(describing: people[indexPath.row]["mass"]!))"
            }
        }
        
    }
}

