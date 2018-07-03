//
//  RedViewController.swift
//  SwappingChildViewControllers
//
//  Created by Backlin,Gene on 7/2/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class RedViewController: BaseChildViewController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        delegate!.setViewLabel(title: "RedViewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
