//
//  MobVersionTableViewTests.swift
//  MobVersionTableViewTests
//  test Case for MobVersionTableView
//  Created by kibur on 5/2/19.

/**  Copyright © 2019 Kibur. All rights reserved.
*/

import XCTest
@testable import MobVersionTableView

class MobVersionTableViewTests: XCTestCase {
    
    var versionTableObj: VersionTableViewController?
    
    override func setUp() {
        versionTableObj = VersionTableViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        versionTableObj = nil
    }

    /**
      tests the get_data_from_url function
     */
   func testGet_data_from_url()
   {
    var url = ""
    //versionTableObj.setUrl(url: url)
    url = "https://mservice.bankofamerica.com/mgateway/xservice/bootstrap/mobileContentInitializeBootstrap/v1/APPLE_HANDSET"
     self.versionTableObj?.get_data_from_url(url)
     XCTAssertNotNil(versionTableObj?.dataSet)
     XCTAssertEqual(self.versionTableObj?.dataSet.count, 0)
    }
    //test cases
    
    

}
