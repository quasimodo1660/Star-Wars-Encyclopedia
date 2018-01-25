//
//  AddItemViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Peisure on 1/23/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var contentLabel: UITextView!
    @IBOutlet weak var beginDate: UIDatePicker!
    
    var delegate:addItemDelegate?
    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        delegate?.addItem(self, with: titleLabel.text!, contentLabel.text, and: beginDate.date, by: sender)
    }
    
    
    @IBAction func datechangeValue(_ sender: UIDatePicker) {
        
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


protocol addItemDelegate: class {
    func addItem(_ controller: AddItemViewController, with toDoTitle:String,_ content:String,and beginDate:Date,by sender:UIBarButtonItem)
}
