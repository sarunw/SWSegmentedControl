//
//  SWBadgeView.swift
//  FBSnapshotTestCase
//
//  Created by Sarun Wongpatcharapakorn on 5/17/18.
//

import Foundation

private let VerticalPadding: CGFloat = 2
private let HorizontalPadding: CGFloat = 5

public class SWBadgeView: UIView {
    
    public var label = UILabel()
    
    public var badgeColor: UIColor? {
        didSet {
            configureView()
        }
    }
    
    public var contentInsets: UIEdgeInsets? {
        didSet {
            configureView()
        }
    }
    
    private var topLayoutConstraint: NSLayoutConstraint!
    private var leadingLayoutConstraint: NSLayoutConstraint!
    private var trailingLayoutConstraint: NSLayoutConstraint!
    private var bottomLayoutConstraint: NSLayoutConstraint!
    
    private var colorToUse: UIColor {
        return badgeColor ?? tintColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func configureView() {
        backgroundColor = colorToUse
        
        let contentInsets = self.contentInsets ?? UIEdgeInsets(top: VerticalPadding, left: HorizontalPadding, bottom: VerticalPadding, right: HorizontalPadding)
        
        leadingLayoutConstraint.constant = contentInsets.left
        trailingLayoutConstraint.constant = contentInsets.right
        topLayoutConstraint.constant = contentInsets.top
        bottomLayoutConstraint.constant = contentInsets.bottom
        
        layoutIfNeeded()
    }
    
    private func commonInit() {
        backgroundColor = tintColor
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        leadingLayoutConstraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: HorizontalPadding)
        trailingLayoutConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: HorizontalPadding)
        topLayoutConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: VerticalPadding)
        bottomLayoutConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: VerticalPadding)
        addConstraints([
            leadingLayoutConstraint,
            trailingLayoutConstraint,
            topLayoutConstraint,
            bottomLayoutConstraint
        ])
    }
    
    override public func tintColorDidChange() {
        super.tintColorDidChange()
        configureView()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let minLength = min(bounds.size.width, bounds.size.height)
        layer.cornerRadius = minLength / 2
    }
}
