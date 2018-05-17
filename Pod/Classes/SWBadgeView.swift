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
    }
    
    private func commonInit() {
        backgroundColor = tintColor
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        if #available(iOS 9.0, *) {
            addConstraints([
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: HorizontalPadding),
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -HorizontalPadding),
                label.topAnchor.constraint(equalTo: topAnchor, constant: VerticalPadding),
                label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -VerticalPadding)
                ])
        } else {
            // Fallback on earlier versions
            addConstraints([
                NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: HorizontalPadding),
                NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -HorizontalPadding),
                NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: VerticalPadding),
                NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -VerticalPadding)
            ])
        }
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
