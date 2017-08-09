//
//  SnapShotTests.swift
//  SWSegmentedControl
//
//  Created by Sarun Wongpatcharapakorn on 8/9/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import SWSegmentedControl

class SnapShotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSegmentedControl() {
        let rect = CGRect(x: 0, y: 0, width: 320, height: 44)
        let view = SWSegmentedControl(items: ["A", "B", "C"])
        view.frame = rect
        
        FBSnapshotVerifyView(view)
    }
    
    func testSetTitle() {
        let rect = CGRect(x: 0, y: 0, width: 320, height: 44)
        let view = SWSegmentedControl(items: ["A", "B", "C"])
        view.frame = rect
        
        view.setTitle("Alphabet", forSegmentAt: 0)
        
        FBSnapshotVerifyView(view)
    }
    
    
}
