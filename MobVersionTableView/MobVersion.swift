//
//  Version.swift
//  CreateATableView

//  This class is the object representation of the table cells

//  Created by Kibur Girum on 5/02/19.
//  Copyright © 2019 Kibur. All rights reserved.
//

import UIKit

class MobVersion: NSObject {
    
    
    //MARK: Properties
    
    var name: String!
    var id: String!
    var locale: String!
    var version: String!
    
    //MARK: Initialization
    
    init?(name: String, id: String, locale: String, version: String) {
        
        // The all properties must not be empty
        // Initialize stored properties.
        self.name = name
        self.id = id
        self.locale = locale
        self.version = version
    }
    
}
