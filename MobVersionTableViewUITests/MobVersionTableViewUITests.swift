//
//  MobVersionTableViewUITests.swift
//  MobVersionTableViewUITests
//
//  Created by Kibur on 5/02/19.
//  Copyright © 2019 Kibur. All rights reserved.
//

import XCTest

class MobVersionTableViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        // stop if a failure was encountered
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /**
      tests if the table is displayed
    */
    func testTableDisplay() {
        app.launch()
        
        // Make sure if the table is diplayed
        XCTAssertTrue(app.isTableDisplayed)
    }
    
    /**
      reset the app after finsed launging
    */
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        if CommandLine.arguments.contains("--uitesting") {
            resetState()
        }
        
        // ...Finish setting up the app
        
        return true
    }
    
    /**
      Clears out app user defaults
    */
    func resetState()
    {
        let defaultsName = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: defaultsName)
    }
    
}


/**
 Add extension to check UI view status
 */
extension XCUIApplication {
    var isTableDisplayed: Bool {
        //var elementLabels = [String]()
        //for i in 0..<otherElements.count {
           // elementLabels.append (otherElements.element(boundBy: i).identifier)
        //}
        //print (elementLabels)
        return otherElements["Mobile Content Version"].exists
        
    }
    //ADD MORE CHECKS HERE
}

