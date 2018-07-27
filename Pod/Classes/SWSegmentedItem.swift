//
//  SWSegmentedItem.swift
//  SWSegmentedControl
//
//  Created by Sarun Wongpatcharapakorn on 5/17/18.
//

import Foundation

private let BadgeMargin: CGFloat = 5

class SWSegmentedItem: UIButton {
    
    var title: String? {
        didSet {
            textLabel.text = title
        }
    }
    var badge: String? {
        didSet {
            badgeView.label.text = badge
            if badge != nil {
                badgeView.isHidden = false
            } else {
                badgeView.isHidden = true
            }
        }
    }
    
    var badgeColor: UIColor? {
        didSet {
            configureView()
        }
    }
    
    var badgeContentInsets: UIEdgeInsets? {
        didSet {
            self.configureView()
        }
    }
    
    override func setTitleColor(_ color: UIColor?, for state: UIControlState) {
        super.setTitleColor(color, for: state)
        
        configureView()
    }
    
    var textLabel = UILabel()
    var badgeView = SWBadgeView()

    override var isSelected: Bool {
        didSet {
            configureView()
        }
    }
    
    private func configureView() {
        if isSelected {
            textLabel.textColor = titleColor(for: .selected)
        } else {
            textLabel.textColor = titleColor(for: .normal)
        }
        
        badgeView.badgeColor = badgeColor ?? titleColor(for: .selected)
        badgeView.contentInsets = badgeContentInsets
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
    
    private func commonInit() {
        let customView = UIView(frame: bounds)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.isUserInteractionEnabled = false
        
        addSubview(customView)
        addConstraints([
            NSLayoutConstraint(item: customView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: customView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: customView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(textLabel)
        
        if #available(iOS 9.0, *) {
            addConstraints([
                textLabel.leadingAnchor.constraint(greaterThanOrEqualTo: customView.leadingAnchor, constant: 0),
                textLabel.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
                textLabel.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
                textLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 0),
                textLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0)
                ])
        } else {
            // Fallback on earlier versions
            addConstraints([
                NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: customView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: customView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: customView, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: customView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: textLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: customView, attribute: .bottom, multiplier: 1, constant: 0)
                ])
        }
        
        badgeView.isHidden = true
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(badgeView)

        addConstraints([
            NSLayoutConstraint(item: badgeView, attribute: .leading, relatedBy: .equal, toItem: textLabel, attribute: .trailing, multiplier: 1, constant: BadgeMargin),
            NSLayoutConstraint(item: badgeView, attribute: .centerY, relatedBy: .equal, toItem: textLabel, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: badgeView, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: customView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }
}
