//
//  ViewController.swift
//  SWSegmentedControl
//
//  Created by Sarun Wongpatcharapakorn on 01/27/2016.
//  Copyright (c) 2016 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit
import SWSegmentedControl

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: SWSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Init with-out autolayout
        let sc = SWSegmentedControl(items: ["A", "B", "C"])
        sc.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        var center = self.view.center;
        center.y = 40
        sc.center = center
        sc.autoresizingMask = [.FlexibleWidth, .FlexibleBottomMargin]
        sc.selectedSegmentIndex = 2
        self.view.addSubview(sc)

        // Init with autolayout
        let sc2 = SWSegmentedControl(items: ["A", "B", "C"])
        sc2.selectedSegmentIndex = 1
        sc2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sc2)
        
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[sc2]|", options: [], metrics: nil, views: ["sc2": sc2])
        NSLayoutConstraint.activateConstraints(constraints)
        
        let constraints2 = NSLayoutConstraint.constraintsWithVisualFormat("V:[sc2(44)]", options: [], metrics: nil, views: ["sc2": sc2])
        NSLayoutConstraint.activateConstraints(constraints2)
        
        let centerY = NSLayoutConstraint(item: sc2, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0)
        self.view.addConstraint(centerY)        
    }

    @IBAction func didTapButton(sender: AnyObject) {
        self.segmentedControl.setSelectedSegmentIndex(1)
    }

    @IBAction func didTapNoAnimation(sender: AnyObject) {
        self.segmentedControl.selectedSegmentIndex = 1
    }
    
    @IBAction func segmentedChanged(sender: SWSegmentedControl) {
        print("select: \(sender.selectedSegmentIndex)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

