//
//  VersionTableViewController.swift
//  MobVersionTableView
//
//  Created by Kibur on 5/01/19.
//  Copyright © 2019 Kibur. All rights reserved.
//

import UIKit



class VersionTableViewController: UITableViewController {
    
    //mobile initialize default URL
    var url = "https://mservice.bankofamerica.com/mgateway/xservice/bootstrap/mobileContentInitializeBootstrap/v1/APPLE_HANDSET"
    
    //the dataSet to populate our TableView
    var dataSet = [MobVersion]()
    
    //the current selected cell data wich would be send to the MobVersionViewController during segue
    var detailToSend: MobVersion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //sets up the view title
        self.title = "Mobile Content Version"
        
        //for testing purpose
        view.accessibilityIdentifier = "tableView"
        
        get_data_from_url(url)
        
    }
    
    /**
      sets up the number of sections
    */
    func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     sets up the number of rows(cells)
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // return the number of rows
        return dataSet.count
        
    }
    
    /**
      creates the custom table header with approperiate header titles and add it to
      the view
    */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        
        v.backgroundColor = .white
        
        //setting the height of the table header
        tableView.estimatedSectionHeaderHeight = 40.0
        
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 10, y: 5, width: tableView.frame.width - 5, height: 30))
        //setting up the titles
        segmentedControl.insertSegment(withTitle: "Name", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Id", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Local", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "Version", at: 3, animated: false)
        v.addSubview(segmentedControl)
        return v
    }
    
    /**
     this functioun override the tableView function to populate our TableView
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "viewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VersionTableViewCell  else {
            print(indexPath)
            fatalError("The dequeued cell is not an instance of MobVersionTableViewCell.")
        }
        
        // Fetches the appropriate  MobVersion for the data source layout.
        let version = dataSet[indexPath.row]
        
        //assign values to the cell labels
        cell.nameLabel.text = version.name
        cell.idLabel.text = version.id
        cell.localLabel.text = version.locale
        cell.versionLabel.text = version.version
        return cell
    }
    
    
    
    /**
      extract data from the passed url using session configuration
     
      @param the url link
    */
    public func get_data_from_url(_ link:String)
    {
        // create a session configuration
        let session = URLSession.shared
        
        let scriptUrl = url;
        if let url = URL(string:scriptUrl){
            var urlRequest = URLRequest(url: url)
            
            urlRequest.setValue("en-US", forHTTPHeaderField: "Accept-Language")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("APPLE" , forHTTPHeaderField:"device-type")
            urlRequest.setValue("SMRTPH", forHTTPHeaderField:"platformType")
            
            // make calls with the session manager
            session.dataTask(with: urlRequest){(data: Data?,response: URLResponse?, error: Error?) -> Void in
                if let error = error as NSError?
                {
                    //prints Log error with the domain dame
                    NSLog("--------------------------------------------------------")
                    NSLog("task transport error %@ / %d", error.domain, error.code)
                    NSLog("--------------------------------------------------------")
                    
                    print("--------------------------------------------------------")
                    print("task transport error \(error.domain) / \(error.code)")
                    print("--------------------------------------------------------")
                    return
                }
                
                if let responseData = data
                {
                    self.extract_json(responseData)
                    
                }
                
                }.resume()
            
        }
        
    }
    
    /**
      extracts the passed json object and add the values to the dataSet that will be used to populate the tabel
      view
      @param data a json object
    */
    private func extract_json(_ data: Data)
    {
         //keys to get access to the Content based the json response
        let key1 = "mobileContentInitializeBootstrapResponse"
        let key2 = "mobileContentVersion"
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
            let data = json?[key1] as? [String: Any]
            let value = data?[key2] as? [Any]
            
            var name: String
            var id: String
            var locale: String
            var version: String
            for case let result in value!
            {
                let content = result as? [String: Any]
                //print(content!["id"] as Any)
                name = content!["name"]! as! String
                id = content!["id"]! as! String
                locale = content!["locale"]! as! String
                version = content!["version"]! as! String
                guard let version = MobVersion(name: name, id: id, locale: locale, version: version) else {
                    fatalError("Unable to instantiate meal1")
                }
                dataSet.append(version);
                
            }
            
        }catch {
            print("Error info: \(error)")
            print("Could not serialize")
            
        }
        //referssh the able view after task is finished
        DispatchQueue.main.async(execute: {self.do_table_refresh()})
        
        
        
    }
    
    /**
      reloads the table view
    */
    func  do_table_refresh()
    {
        tableView.reloadData()
    }
    
    
    /**
     Performs segue to showVersionSegue(identifer for the MobVersionViewControlller)
     when a table cell is clicked
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //choses the selected Version from the dataSet
        detailToSend = dataSet[indexPath.row]
        performSegue(withIdentifier: "showVersionSegue", sender: detailToSend)
    }
    
    /**
 
     sets the datailToSend to the selected Version during segue preparetion
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MobVersionViewController, let detailToSend = sender as? MobVersion {
            vc.version = detailToSend
        }
    }
    
    /**
    * sets up mobile initialize URL
    */
    func setUrl(url: String)
    {
        self.url = url;
    }
    
}
