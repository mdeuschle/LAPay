//
//  Alert.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/20/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

enum ErrorMessage: String {
    case error = "An unknown error occured"
    case noDescription = "Job Description Not Available"
}

struct Alert {
    let viewController: UIViewController
    func show(message: ErrorMessage){
        let alertController = UIAlertController(title: "Oops",
                                                message: message.rawValue,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
}


