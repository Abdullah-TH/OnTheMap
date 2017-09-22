//
//  AlertControllerMaker.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/23/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import UIKit

class AlertControllerMaker
{
    static func showErrorMessage(_ message: String, inViewController vc: UIViewController)
    {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(action)
        vc.present(alertController, animated: true, completion: nil)
    }
}
