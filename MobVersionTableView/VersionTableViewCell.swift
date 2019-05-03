//
//  VersionTableViewCell.swift
//  MobVersionTableView
//
//  Created by Kibur on 5/01/19.
//  Copyright © 2019 Kibur. All rights reserved.
//

import UIKit

class VersionTableViewCell: UITableViewCell {
    
     //MARK: Properties 
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
