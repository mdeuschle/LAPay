//
//  PDFVC.swift
//  LAPay
//
//  Created by Matt Deuschle on 12/11/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit
import PDFKit

class PDFVC: UIViewController {
    
    var jobClassLink: String?
    var color: UIColor?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Job Description"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        NSLayoutConstraint.activate([
            pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        guard let jobClassLink = jobClassLink, let url = URL(string: jobClassLink) else { return }
        
        if let document = PDFDocument(url: url) {
            pdfView.document = document
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let color = color {
            view.backgroundColor = color
        }
    }
}
