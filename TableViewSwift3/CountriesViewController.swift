//
//  CountriesViewController.swift
//  TableViewSwift3
//
//  Created by Halfpenny on 28/03/2017.
//  Copyright © 2017 Ethan Halprin. All rights reserved.
//


//
// Flags image are free to use for personal and commercial projects and were taken from:
//
// http://365icon.com/icon-styles/ethnic/classic2/
//
import UIKit

//
// No need to conform to UITableViewDataSource, UITableViewDelegate
// as we inherit from UITableViewController who does
//
// What we need to add, is an `override` keyword to method signature
//
// Follow remarks !!
//
class CountriesViewController: UITableViewController
{
    //
    // The identifier for a cell, so when could dequeue it later (more 
    // efficient - no need to allocate again
    //
    // This ID ("TableViewCellID001") needs also to be set on Cell's Attribute
    // Inspector in Interface Builder
    //
    let cellReuseIdentifier = "TableViewCellID001"
    
    //
    // The Data Source to fill table with
    //
    var dataSource : [String] = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        cacheDataSource()
        
        //
        // Usually here we would do a reister:
        //
        
        // self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        //
        // This tells the table view how to create new cells. If a cell of the specified
        // type is not currently in a reuse queue, the table view uses the provided
        // information to create a new cell object automatically.
        // [ BY THE WAY: This register is from iOS 6 - designed to save you from the code
        // that checks cell is nil, when returning from deque operation]
        
        //
        // Why is it remarked here?
        //
        // In our case, cell defined on storyboard, and since the ID is already updated
        // there - the register in code is redundant (iOS know to register from the 
        // Interface Builder)
        //
        
        //
        // And if you have a custom class in a nib :
        //
        // public func registerNib(nib: UINib?, forCellWithReuseIdentifier identifier: String)
        //
    }
    
    func cacheDataSource()
    {
        let flagFilesURLs : [URL]? = Bundle.main.urls(forResourcesWithExtension:"png", subdirectory: nil)
        
        if let flagFilesURLs = flagFilesURLs
        {
            for url in flagFilesURLs
            {
                let filename = url.deletingPathExtension().lastPathComponent
                
                self.dataSource.append(filename)
            }
            
            print("Countries Names : \(self.dataSource)")
        }
    }
    
    //
    //====== UITableViewDataSource ==========================================
    //
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataSource.count
    }
    //
    // cellForRowAt
    //
    // Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    //
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    //
    @available(iOS 2.0, *)
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //
        // Get reused cell (newer dequeue method guarantees a cell is returned and
        // resized properly, assuming identifier is registered)
        //
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        //
        // Customize our own data to it
        //
        let countryName = self.dataSource[indexPath.row]
        
        cell.textLabel?.text = countryName.uppercased()
        cell.detailTextLabel?.text = countryName.lowercased()

        let flagImage = UIImage(named: countryName + ".png")
        
        if let flag = flagImage
        {
            cell.imageView?.image = flag
        }
        //
        // Now cell ready
        //
        return cell
    }
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    {
        return "Countries List"
    }
    //
    //====== UITableViewDelegate ==========================================
    //
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let alertController =  UIAlertController(title: "didSelectRowAt",
                                                 message: "You have selected " + self.dataSource[indexPath.row],
                                                 preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
