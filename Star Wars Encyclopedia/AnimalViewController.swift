//
//  AnimalViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Peisure on 1/24/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

class AnimalViewController: UIViewController,addAAnimal{
    
    
    
    func addOne(_ controller: addAnimals, with name: String, and gender: String) {
        <#code#>
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aaa"{
            let target = segue.destination as! addAnimals
            target.delegate = self
        }
        
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
