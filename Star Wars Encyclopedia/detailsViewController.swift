//
//  detailsViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Peisure on 1/22/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController {
    
    var label1:String?
    var label2:String?
    var label3:String?
    var label4:String?
    
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l4: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        l1.text = label1
        l2.text = label2
        l3.text = label3
        l4.text = label4
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
