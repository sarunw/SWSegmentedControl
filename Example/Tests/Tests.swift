import UIKit
import XCTest
import SWSegmentedControl
import FBSnapshotTestCase

class Tests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        
//        recordMode = true
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNoPadding() {
        // This is an example of a functional test case.
        let sc = SWSegmentedControl(items: ["A", "B", "C"])
        sc.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        
        FBSnapshotVerifyView(sc)
    }
    
    func testPadding() {
        // This is an example of a functional test case.
        let sc = SWSegmentedControl(items: ["A", "B", "C"])
        sc.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        sc.indicatorPadding = 10
        
        FBSnapshotVerifyView(sc)
    }
    
}
