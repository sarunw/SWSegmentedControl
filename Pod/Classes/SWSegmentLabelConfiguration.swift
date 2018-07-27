//
//  File.swift
//  SWSegmentedControl
//
//  Created by Thomas LORNE on 27/07/2018.
//

import Foundation

public struct SWSegmentLabelConfiguration {
    
    var numberOfLines: Int?
    var textAlignment: NSTextAlignment?
    var lineBreakMode: NSLineBreakMode?
    var adjustsFontSizeToFitWidth: Bool?
    var minimumScaleFactor: CGFloat?
    
    public init(numberOfLines: Int? = nil,
                textAlignment: NSTextAlignment? = nil,
                lineBreakMode: NSLineBreakMode? = nil,
                adjustsFontSizeToFitWidth: Bool? = nil,
                minimumScaleFactor: CGFloat? = nil) {
        
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.lineBreakMode = lineBreakMode
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.minimumScaleFactor = minimumScaleFactor
    }
}
