//
//  ListViewController.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/14/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import UIKit

class ListViewController: OnTheMapViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        refreshStudentLocations()
    }
    
    override func activityIndicatorShouldStartAnimating()
    {
        activityIndicator.startAnimating()
    }
    
    override func activityIndicatorShouldStopAnimating()
    {
        activityIndicator.stopAnimating()
    }
    
    override func shouldRefereshData()
    {
        tableView.reloadData()
    }

}

extension ListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let locations = studentLocations
        {
            return locations.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell")
        if cell == nil
        {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "StudentLocationCell")
            if let locations = studentLocations
            {
                let location = locations[indexPath.row]
                
                cell?.imageView?.image = #imageLiteral(resourceName: "icon_pin")
                cell?.textLabel?.text = "\(location.firstName) \(location.lastName)"
                cell?.detailTextLabel?.text = location.mediaURL
                cell?.detailTextLabel?.textColor = UIColor.gray
            }
        }
        return cell!
    }
}

extension ListViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let location = studentLocations?[indexPath.row]
        {
            openURLInbrowser(url: URL(string: location.mediaURL))
        }
        
    }
}










