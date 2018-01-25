//
//  AnimalViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Peisure on 1/24/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit
import CoreData

class AnimalViewController: UIViewController,addAAnimal{
    
    var allAnimals = [Animals]()
//    var male = [Animals]()
//    var female = [Animals]()
    
    @IBOutlet weak var showTable: UITableView!
    
    let manageAnimalsDate = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    func addOne(_ controller: addAnimals, with name: String, and gender: String) {
        print("zheli")
        let animal = NSEntityDescription.insertNewObject(forEntityName: "Animals", into: manageAnimalsDate) as! Animals
        animal.name = name
        animal.gender = gender
        allAnimals.append(animal)
        do{
            try manageAnimalsDate.save()
        }
        catch{
            print("\(error)")
        }
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        showTable.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aaa"{
            let target = segue.destination as! addAnimals
            target.delegate = self
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        showTable.dataSource = self
        showTable.delegate = self
//        let animal = allAnimals.removeLast()
//        manageAnimalsDate.delete(animal)
//        do{
//                        try manageAnimalsDate.save()
//                    }
//                    catch{
//                        print("\(error)")
//                    }
//        print(allAnimals.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Animals")
        do{
            let animals = try manageAnimalsDate.fetch(request)
            allAnimals = animals as! [Animals]
        }
        catch{
            print("\(error)")
        }
    }
    
    
    func fetchByFilter(_ type:String){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Animals")
        request.predicate = NSPredicate(format: "gender == %@", type)
        do{
            let animals = try manageAnimalsDate.fetch(request)
            allAnimals = animals as! [Animals]
        }
        catch{
            print("\(error)")
        }
    }
    
    @IBAction func filterButton(_ sender: UIButton) {
        print(sender.titleLabel!.text!)
        fetchByFilter((sender.titleLabel!.text!))
        showTable.reloadData()
    }
    
    @IBAction func showAllButton(_ sender: Any) {
        fetchAllItems()
        showTable.reloadData()
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension AnimalViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAnimals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ACell", for: indexPath)
        cell.textLabel?.text = allAnimals[indexPath.row].name
        return cell
    }
    
    
}

class addAnimals: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var gender: UILabel!
    
    var delegate:addAAnimal?
    
    @IBAction func switchChange(_ sender: UISwitch) {
        if sender.isOn{
            gender.text = "Male"
        }
        else{
            gender.text = "Female"
        }
        
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        delegate?.addOne(self, with: name.text!, and: gender.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


protocol addAAnimal:class {
    func addOne(_ controller: addAnimals, with name:String, and gender:String)
}
