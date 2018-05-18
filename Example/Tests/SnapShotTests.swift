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
        
//        recordMode = true
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
    
    func testSegmentedControlWithBadge() {
        let rect = CGRect(x: 0, y: 0, width: 320, height: 44)
        let view = SWSegmentedControl(items: ["A", "B", "C"])
        view.frame = rect
        view.setBadge("1", forSegmentAt: 0)
        
        FBSnapshotVerifyView(view)
    }
    
    func testBadgeFollowTint() {
        let rect = CGRect(x: 0, y: 0, width: 320, height: 44)
        let view = SWSegmentedControl(items: ["A", "B", "C"])
        view.frame = rect
        view.tintColor = .green
        view.setBadge("1", forSegmentAt: 0)
        
        FBSnapshotVerifyView(view)
    }
    
    func testBadgeFollowTintColor() {
        let rect = CGRect(x: 0, y: 0, width: 320, height: 44)
        let view = SWSegmentedControl(items: ["A", "B", "C"])
        view.frame = rect
        view.tintColor = .green
        view.titleColor = .red
        view.setBadge("1", forSegmentAt: 0)
        
        FBSnapshotVerifyView(view)
    }
    
    func testChangeBadgeFont() {
        let rect = CGRect(x: 0, y: 0, width: 320, height: 44)
        let view = SWSegmentedControl(items: ["A", "B", "C"])
        view.frame = rect
        view.badgeFont = UIFont.boldSystemFont(ofSize: 10)
        view.setBadge("1", forSegmentAt: 0)
        
        FBSnapshotVerifyView(view)
    }
    
    func testChangeBadgeColor() {
        let rect = CGRect(x: 0, y: 0, width: 320, height: 44)
        let view = SWSegmentedControl(items: ["A", "B", "C"])
        view.frame = rect
        view.badgeColor = .orange
        view.setBadge("1", forSegmentAt: 0)
        
        FBSnapshotVerifyView(view)
    }
    
    func testChangeBadgeInsets() {
        let rect = CGRect(x: 0, y: 0, width: 320, height: 44)
        let view = SWSegmentedControl(items: ["A", "B", "C"])
        view.frame = rect
        view.badgeContentInsets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
        view.setBadge("1", forSegmentAt: 0)
        
        FBSnapshotVerifyView(view)
    }
    
}
