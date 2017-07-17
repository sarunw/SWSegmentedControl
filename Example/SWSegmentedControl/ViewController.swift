//
//  ViewController.swift
//  SWSegmentedControl
//
//  Created by Sarun Wongpatcharapakorn on 01/27/2016.
//  Copyright (c) 2016 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit
import SWSegmentedControl

class ViewController: UIViewController, SWSegmentedControlDelegate {

    @IBOutlet weak var segmentedControl: SWSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Init with-out autolayout
        let sc = SWSegmentedControl(items: ["A", "B", "C"])
        sc.delegate = self
        sc.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        var center = self.view.center;
        center.y = 40
        sc.center = center
        sc.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        sc.selectedSegmentIndex = 2
        self.view.addSubview(sc)

        // Init with autolayout
        let sc2 = SWSegmentedControl(items: ["A", "B", "C"])
        sc2.selectedSegmentIndex = 1
        sc2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sc2)
        
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[sc2]|", options: [], metrics: nil, views: ["sc2": sc2])
        NSLayoutConstraint.activate(constraints)
        
        let constraints2 = NSLayoutConstraint.constraints(withVisualFormat: "V:[sc2(44)]", options: [], metrics: nil, views: ["sc2": sc2])
        NSLayoutConstraint.activate(constraints2)
        
        let centerY = NSLayoutConstraint(item: sc2, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraint(centerY)        
    }

    @IBAction func didTapButton(_ sender: AnyObject) {
        self.segmentedControl.setSelectedSegmentIndex(1)
    }

    @IBAction func didTapNoAnimation(_ sender: AnyObject) {
        self.segmentedControl.selectedSegmentIndex = 1
    }
    
    @IBAction func segmentedChanged(_ sender: SWSegmentedControl) {
        print("select: \(sender.selectedSegmentIndex)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - SWSegmentedControlDelegate
    func segmentedControl(_ control: SWSegmentedControl, willSelectItemAtIndex index: Int) {
        print("will select \(index)")
    }
    
    func segmentedControl(_ control: SWSegmentedControl, didSelectItemAtIndex index: Int) {
        print("did select \(index)")
    }
    
    func segmentedControl(_ control: SWSegmentedControl, willDeselectItemAtIndex index: Int) {
        print("will deselect \(index)")
    }
    
    func segmentedControl(_ control: SWSegmentedControl, didDeselectItemAtIndex index: Int) {
        print("did deselect \(index)")
    }
    
    func segmentedControl(_ control: SWSegmentedControl, canSelectItemAtIndex index: Int) -> Bool {
        if index == 1 {
            return false
        }
        
        return true
    }
}

