//
//  SWSegmentedControl.swift
//  Pods
//
//  Created by Sarun Wongpatcharapakorn on 1/27/16.
//
//

import UIKit

@IBDesignable
public class SWSegmentedControl: UIControl {
    
    private var selectionIndicatorView: UIView!
    private var buttons: [UIButton]?
    private var items: [String] = ["First", "Second"]
    
    @IBInspectable public var font: UIFont = UIFont.systemFontOfSize(UIFont.systemFontSize()) // Wait for a day UIFont will be inspectable
    @IBInspectable public var titleColor: UIColor? {
        didSet {
            self.configureView()
        }
    }
    @IBInspectable public var indicatorColor: UIColor? {
        didSet {
            self.configureView()
        }
    }
    
    @IBInspectable public var selectedSegmentIndex: Int = 0 {
        didSet {
            self.configureIndicator()
        }
    }
    private var indicatorXConstraint: NSLayoutConstraint!
    
    @IBInspectable public var indicatorThickness: CGFloat = 3 {
        didSet {
            self.indicatorHeightConstraint.constant = self.indicatorThickness
        }
    }
    private var indicatorHeightConstraint: NSLayoutConstraint!
    
    var numberOfSegments: Int {
        return items.count
    }
    
    public init() {
        super.init(frame: CGRectZero)
        self.commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    public init(items: [String]) {
        super.init(frame: CGRectZero)
        self.items = items
        self.commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clearColor()
        self.initButtons()
        self.initIndicator()
    }
    
    public override func prepareForInterfaceBuilder() {

    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // For autolayout
        self.configureIndicator()
    }
    
    private func initIndicator() {
        guard self.numberOfSegments > 0 else { return }
        
        let selectionIndicatorView = UIView()
        self.selectionIndicatorView = selectionIndicatorView
        
        selectionIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        selectionIndicatorView.backgroundColor = self.tintColor
        self.addSubview(selectionIndicatorView)
        
        let xConstraint = NSLayoutConstraint(item: selectionIndicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: self.xToItem, attribute: .CenterX, multiplier: 1, constant: 0)
        self.indicatorXConstraint = xConstraint
        self.addConstraint(xConstraint)
        
        let yConstraint = NSLayoutConstraint(item: selectionIndicatorView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        self.addConstraint(yConstraint)
        
        let wConstraint = NSLayoutConstraint(item: selectionIndicatorView, attribute: .Width, relatedBy: .Equal, toItem: self.wToItem, attribute: .Width, multiplier: 1, constant: 0)
        self.addConstraint(wConstraint)
        
        let hConstraint = NSLayoutConstraint(item: selectionIndicatorView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: self.indicatorThickness)
        self.indicatorHeightConstraint = hConstraint
        self.addConstraint(hConstraint)
    }
    
    private func initButtons() {
        guard self.numberOfSegments > 0 else { return }
        
        var views = [String: AnyObject]()
        var xVisualFormat = "H:|"
        let yVisualFormat = "V:|[button0]|"
        var previousButtonName: String? = nil
        
        var buttons = [UIButton]()
        defer {
            self.buttons = buttons
        }
        for index in 0..<self.numberOfSegments {
            let button = UIButton(type: .Custom)
            self.configureButton(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(self.titleForSegmentAtIndex(index), forState: .Normal)
            button.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
            
            buttons.append(button)
            self.addSubview(button)
            
            let buttonName = "button\(index)"
            views[buttonName] = button
            if let previousButtonName = previousButtonName {
                xVisualFormat.appendContentsOf("[\(buttonName)(==\(previousButtonName))]")
            } else {
                xVisualFormat.appendContentsOf("[\(buttonName)]")
            }
            
            previousButtonName = buttonName
        }
        
        xVisualFormat.appendContentsOf("|")
        
        let xConstraints = NSLayoutConstraint.constraintsWithVisualFormat(xVisualFormat, options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: views)
        let yConstraints = NSLayoutConstraint.constraintsWithVisualFormat(yVisualFormat, options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activateConstraints(xConstraints)
        NSLayoutConstraint.activateConstraints(yConstraints)
    }
    
    public func titleForSegmentAtIndex(segment: Int) -> String? {
        guard segment < self.items.count else {
            return nil
        }
        
        return self.items[segment]
    }
    
    public func setSelectedSegmentIndex(index: Int, animated: Bool = true) {
        if animated {
            UIView.animateWithDuration(0.1, animations: {
                self.selectedSegmentIndex = index
                self.layoutIfNeeded()
            })
        } else {
            self.selectedSegmentIndex = index
        }
    }
    
    override public func tintColorDidChange() {
        super.tintColorDidChange()
        
        self.configureView()
    }
    
    // MARK: - Appearance
    private func configureView() {
        self.configureIndicator()
        self.configureButtons()
    }
    
    private func colorToUse(color: UIColor?) -> UIColor {
        return color ?? self.tintColor
    }
    
    private func configureIndicator() {
        self.indicatorXConstraint.constant =  CGFloat(self.selectedSegmentIndex) * self.itemWidth
        self.selectionIndicatorView.backgroundColor = self.colorToUse(self.indicatorColor)
    }
    
    private func configureButtons() {
        guard let buttons = self.buttons else {
            return
        }
        
        for button in buttons {
            self.configureButton(button)
        }
    }
    
    private func configureButton(button: UIButton) {
        button.titleLabel?.font = self.font
        button.setTitleColor(self.colorToUse(self.titleColor), forState: .Normal)

    }
    
    // MARK: - Actions
    func didTapButton(button: UIButton) {
        guard let index = self.buttons?.indexOf(button) else {
            return
        }
        self.setSelectedSegmentIndex(index)
        self.sendActionsForControlEvents(.ValueChanged)
    }
    
    // MARK: - Layout Helpers
    private var xToItem: UIView {
        return self.buttons![self.selectedSegmentIndex]
    }
    
    private var wToItem: UIView {
        
        return self.buttons![self.selectedSegmentIndex]
    }
    
    private var itemWidth: CGFloat {
        return self.bounds.size.width / CGFloat(self.numberOfSegments)
    }
}
