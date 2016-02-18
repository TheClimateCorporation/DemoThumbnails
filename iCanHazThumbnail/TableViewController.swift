//
//  TableViewController.swift
//  iCanHazThumbnail
//
//  Created by Aditya Rao on 2/17/16.
//  Copyright © 2016 Aditya Rao. All rights reserved.
//

import UIKit

class TableViewController : UITableViewController {
    
    var fieldStore : FieldStore!
    var fields =  [Field]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fieldStore.fetchAllFields() { () -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.fields = self.fieldStore.getAllFields()
                self.tableView.reloadData()
            })
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return self.fields.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        var cell = self.tableView.dequeueReusableCellWithIdentifier("FieldCell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "FieldCell")
        }
        
        let field = self.fields[indexPath.row]
        
        cell!.textLabel?.text = field.name
        cell!.detailTextLabel?.text = "\(field.acres) acres"
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // pass any object as parameter, i.e. the tapped row
        performSegueWithIdentifier("ShowField", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If the triggered segue is the "ShowItem" segue
        print("preparing for segue" + segue.identifier!)
        if segue.identifier == "ShowField" {
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                let detailViewController
                    = segue.destinationViewController as! DetailViewController
                detailViewController.fieldStore = self.fieldStore
                detailViewController.startIndex = row
            }
        }
    }
}