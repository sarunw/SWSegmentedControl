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
        
        let sc = SWSegmentedControl(items: ["A", "B", "C"])
        sc.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        
        self.view.addSubview(sc)
        
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

