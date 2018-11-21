//
//  Alert.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/20/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

struct Alert {
    let viewController: UIViewController
    func show(){
        let alertController = UIAlertController(title: "Oops",
                                                message: "An error occured",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
}


