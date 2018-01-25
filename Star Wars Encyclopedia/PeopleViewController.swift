//
//  ViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Peisure on 1/22/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController ,switchDelegate{
    
    
    var people = [NSDictionary]()
    var names = ["Liam","Chaoi","Emily"]
    var sessionTitle = ["People","Classmate"]
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sessionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
           return people.count
        }
        else{
            return names.count+1
        }
        // return the count of people in our data array
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        var cell:UITableViewCell?
        var cell2:CustomCell?
        // set the default cell label to the corresponding element in the people array
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
            if indexPath.row < 5{
                cell?.textLabel?.text = people[indexPath.row]["name"] as? String
            }
            else{
                cell = tableView.dequeueReusableCell(withIdentifier: "personCell3", for: indexPath)
                cell?.textLabel?.text = people[indexPath.row]["name"] as? String
                cell?.detailTextLabel?.text = people[indexPath.row]["gender"] as? String
            }
            
        }
        else{
//            cell = tableView.dequeueReusableCell(withIdentifier: "personCell2", for: indexPath)
            if indexPath.row == 0{
                cell2 = (tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell)
                cell2?.delegate = self
                cell2?.textLabel?.text = "This switch is on!"
                return cell2!
            }
            else{
                cell = tableView.dequeueReusableCell(withIdentifier: "personCell2")
                cell?.textLabel?.text = names[indexPath.row - 1 ]
            }
            
            
            
        }
        // return the cell so that it can be rendered
        return cell!
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
    
    func change(_ sender: CustomCell, with item: UISwitch) {
        print("here")
        if item .isOn{
            sender.textLabel?.text = "This switch is on!"
            sender.textLabel?.textColor = UIColor.black
        }
        else{
            sender.textLabel?.text = "This switch is off!"
            sender.textLabel?.textColor = UIColor.red
        }
    }
}


class CustomCell:UITableViewCell{
    weak var delegate:switchDelegate?
    @IBOutlet weak var si: UISwitch!
    @IBAction func swithItem(_ sender: UISwitch) {
        delegate?.change(self, with: sender)
    }
}

protocol switchDelegate:class {
    func change(_ sender:CustomCell,with item:UISwitch)
}

