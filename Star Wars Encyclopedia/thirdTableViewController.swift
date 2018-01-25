//
//  thirdTableViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Peisure on 1/23/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit
import CoreData

class thirdTableViewController: UITableViewController,addItemDelegate {
    
    var items = [Todolist]()
    var items2 = [Todolist]()
    
    
    
    
    
    var sectionTitle = ["To do","Finished"]

    let manageDatabase = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    func addItem(_ controller: AddItemViewController, with toDoTitle: String, _ content: String, and beginDate: Date, by sender: UIBarButtonItem) {
        if sender.tag == 0{
            dismiss(animated: true, completion: nil)
        }
        else{
            let item = NSEntityDescription.insertNewObject(forEntityName: "Todolist", into: manageDatabase) as! Todolist
            item.toDoTitle = toDoTitle
            item.content = content
            item.beginDate = beginDate
            item.finish = false
            items2.append(item)
            do{
                try manageDatabase.save()
            }
            catch{
                print("\(error)")
            }
            dismiss(animated: true, completion: nil)
            fetchAllItems()
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem"{
            let navi = segue.destination as! UINavigationController
            let target = navi.topViewController as! AddItemViewController
            target.delegate = self
        }
        
    }
   
   
    
    
   

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.reloadData()
        print(items.count)
        print(items2.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitle.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return items2.count
        }
        else{
            return items.count
        }
       
    }
    
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todolist")
        request.predicate = NSPredicate(format: "finish == %@", NSNumber(value: true))
        do{
            let result = try manageDatabase.fetch(request)
            items = result as! [Todolist]
        }
        catch{
            print("\(error)")
        }
        request.predicate = NSPredicate(format: "finish == %@", NSNumber(value: false))
        do{
            let result = try manageDatabase.fetch(request)
            items2 = result as! [Todolist]
        }
        catch{
            print("\(error)")
        }
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CCell") as! CCell
        if indexPath.section == 0{
            cell.title.text = items2[indexPath.row].toDoTitle
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let myDate = items2[indexPath.row].beginDate
            cell.datetitle.text = formatter.string(from: myDate!)
            cell.content.text = items2[indexPath.row].content
        }
        if indexPath.section == 1{
            cell.title.text = items[indexPath.row].toDoTitle
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let myDate = items[indexPath.row].beginDate
            cell.datetitle.text = formatter.string(from: myDate!)
            cell.content.text = items[indexPath.row].content
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item:Todolist?
        if indexPath.section == 0{
            item = items2[indexPath.row]
        }
        else{
            item = items[indexPath.row]
        }
        if item?.finish == false{
            item?.finish = true
        }
        else{
            item?.finish = false
        }
        do{
            try manageDatabase.save()
        }
        catch{
            print("\(error)")
        }
        fetchAllItems()
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


class CCell: UITableViewCell{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var datetitle: UILabel!
    @IBOutlet weak var content: UILabel!
    
}














