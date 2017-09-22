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
        if StudentLocation.studentLocations.isEmpty
        {
            refreshStudentLocations()
        }
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
        return StudentLocation.studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell")! as! StudentLocationTableViewCell
        let location = StudentLocation.studentLocations[indexPath.row]
        cell.icon.image = #imageLiteral(resourceName: "icon_pin")
        cell.title.text = "\(location.firstName) \(location.lastName)"
        cell.subtitle.text = location.mediaURL
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let location = StudentLocation.studentLocations[indexPath.row]
        openURLInbrowser(url: URL(string: location.mediaURL))
    }
}










