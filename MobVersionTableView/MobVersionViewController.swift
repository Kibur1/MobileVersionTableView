//
//  MobVersionViewControllViewController.swift
//  MobVersionTableView
//
//  Created by Kibur Girum on 05/02/19.
//  Copyright © 2019 Kibur. All rights reserved.
//

import UIKit

class MobVersionViewController: UIViewController {
    
    ///MARK: title Labels for the Movile Version View
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var versionTitle: UILabel!
    @IBOutlet weak var localTitle: UILabel!
    @IBOutlet weak var idTitle: UILabel!
    
     ///MARK: Properties for the Movile Version View
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    var version: MobVersion!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Mobile Version"
        guard let detailV = version else {
             fatalError("MobVersionViewController recieved a nil MobVersion Object")
        }
        // Do any additional setup after loading the view.
        nameLabel.text = detailV.name
        idLabel.text = detailV.id
        localLabel.text = detailV.locale
        versionLabel.text = detailV.version
        
        formatAndDisplay()
    }
    
    /**
     format and display the labels
    */
    func formatAndDisplay()
    {
        
        nameLabel.textAlignment = .center;
        idLabel.textAlignment = .center;
        localLabel.textAlignment = .center;
        versionLabel.textAlignment = .center;
        
        
        nameTitle.textAlignment = .center;
        idTitle.textAlignment = .center;
        localTitle.textAlignment = .center;
        versionTitle.textAlignment = .center;
        
        // Do any additional setup after loading the view.
        nameTitle.text = "Name"
        idTitle.text = "Id"
        localTitle.text = "Local"
        versionTitle.text = "Version"
    }
    

}
