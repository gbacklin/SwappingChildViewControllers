//
//  ViewController.swift
//  SwappingChildViewControllers
//
//  Created by Backlin,Gene on 7/2/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate {
    func setViewLabel(title: String)
}

class ViewController: UIViewController {
    @IBOutlet var viewLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    var currentViewController = BaseChildViewController()
    var blueViewController: BlueViewController?
    var redViewController: RedViewController?

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadChildViewControllers()
        displayContentViewController(controller: redViewController!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Utility
    
    func loadChildViewControllers() {
        redViewController = storyboard!.instantiateViewController(withIdentifier: "RedViewController") as? RedViewController
        blueViewController = storyboard!.instantiateViewController(withIdentifier: "BlueViewController") as? BlueViewController
        redViewController!.delegate = self
        blueViewController!.delegate = self
    }
    
    // MARK: - ContentView
    
    func displayContentViewController(controller: BaseChildViewController) {
        addChildViewController(controller)
        controller.view.frame = contentView.bounds
        contentView.addSubview(controller.view)
        
        controller.didMove(toParentViewController: self)
        currentViewController = controller
    }
    
    func cycleFromViewController(oldVC: BaseChildViewController, newVC: BaseChildViewController) {
        currentViewController = newVC
        currentViewController.delegate = self

        oldVC.willMove(toParentViewController: nil)
        addChildViewController(newVC)
        newVC.view.frame = oldVC.view.frame
        
        transition(from: oldVC, to: newVC, duration: 0.25, options: .transitionCrossDissolve, animations: nil) { (finished) in
            oldVC.removeFromParentViewController()
            newVC.didMove(toParentViewController: self)
        }
    }

    // MARK: - IBAction methods
    
    @IBAction func updateContentView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            cycleFromViewController(oldVC: currentViewController, newVC: redViewController!)
        case 1:
            cycleFromViewController(oldVC: currentViewController, newVC: blueViewController!)
        default:
            break
        }
    }
    
}

// MARK: - ViewControllerDelegate

extension ViewController: ViewControllerDelegate {
    func setViewLabel(title: String) {
        viewLabel.text = title
    }
}
