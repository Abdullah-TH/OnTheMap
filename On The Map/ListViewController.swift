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

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

}

extension ListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell")
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "StudentLocationCell")
        }
        return cell!
    }
}

extension ListViewController: UITableViewDelegate
{
    
}
