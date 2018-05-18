//
//  SWSegmentedControl.swift
//  Pods
//
//  Created by Sarun Wongpatcharapakorn on 1/27/16.
//
//

import UIKit

private let BadgeMargin: CGFloat = 5
private let DefaultTitleFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
private let DefaultBadgeFont = UIFont.systemFont(ofSize: 12)

@IBDesignable
open class SWSegmentedControl: UIControl {
    
    open weak var delegate: SWSegmentedControlDelegate?
    
    private var selectionIndicatorView: UIView?
    private var buttons: [SWSegmentedItem] = []
    public var items: [String] = ["First", "Second"] {
        didSet {
            _selectedSegmentIndex = 0
            
            if oldValue.count == items.count {
                // Same elements, layout no need to change, just update titles
                updateTitles()
            } else {
                // Change layout
                initButtons()
                initIndicator()
            }
        }
    }
    
    // Wait for a day UIFont will be inspectable
    @IBInspectable open var font: UIFont = DefaultTitleFont {
        didSet {
            self.configureView()
        }
    }
    
    @IBInspectable open var badgeFont: UIFont = DefaultBadgeFont {
        didSet {
            self.configureView()
        }
    }
    
    @IBInspectable open var titleColor: UIColor? {
        didSet {
            self.configureView()
        }
    }
    
    @IBInspectable open var unselectedTitleColor: UIColor? = UIColor.lightGray {
        didSet {
            self.configureView()
        }
    }
    
    @IBInspectable open var indicatorColor: UIColor? {
        didSet {
            self.configureView()
        }
    }
    
    @IBInspectable open var badgeColor: UIColor? {
        didSet {
            self.configureView()
        }
    }
    
    open var badgeContentInsets: UIEdgeInsets? {
        didSet {
            self.configureView()
        }
    }
    
    private var _selectedSegmentIndex: Int = 0
    
    @IBInspectable open var selectedSegmentIndex: Int {
        set {
            _selectedSegmentIndex = newValue
            
            self.configureIndicator()
            
            for button in buttons {
                button.isSelected = false
            }
            
            let selectedButton = buttons[selectedSegmentIndex]
            selectedButton.isSelected = true
        }
       
        get {
            return _selectedSegmentIndex
        }
    }
    
    private var indicatorXConstraint: NSLayoutConstraint?
    
    @IBInspectable open var indicatorThickness: CGFloat = 3 {
        didSet {
            self.indicatorHeightConstraint?.constant = self.indicatorThickness
        }
    }
    
    private var indicatorWidthConstraint: NSLayoutConstraint?
    
    @IBInspectable open var indicatorPadding: CGFloat = 0 {
        didSet {
            configureView()
        }
    }
    
    private var indicatorHeightConstraint: NSLayoutConstraint?
    
    var numberOfSegments: Int {
        return items.count
    }
    
    
    public init() {
        super.init(frame: CGRect.zero)
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
        super.init(frame: CGRect.zero)
        self.items = items
        self.commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clear
        self.initButtons()
        self.initIndicator()
    }
    
    open override func prepareForInterfaceBuilder() {

    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        // For autolayout
        self.configureIndicator()
    }
    
    private func updateTitles() {
        for (index, title) in items.enumerated() {
            let button = buttons[index]
            button.title = title
        }
    }
    
    private func initIndicator() {
        self.selectionIndicatorView?.removeFromSuperview()
        indicatorXConstraint = nil
        indicatorWidthConstraint = nil
        indicatorHeightConstraint = nil
        
        guard self.numberOfSegments > 0 else {
            return
        }
        
        let selectionIndicatorView = UIView()
        self.selectionIndicatorView = selectionIndicatorView
        
        selectionIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        selectionIndicatorView.backgroundColor = self.tintColor
        self.addSubview(selectionIndicatorView)
        
        let xConstraint = NSLayoutConstraint(item: selectionIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: self.xToItem, attribute: .centerX, multiplier: 1, constant: 0)
        self.indicatorXConstraint = xConstraint
        self.addConstraint(xConstraint)
        
        let yConstraint = NSLayoutConstraint(item: selectionIndicatorView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraint(yConstraint)
        
        let wConstraint = NSLayoutConstraint(item: selectionIndicatorView, attribute: .width, relatedBy: .equal, toItem: self.wToItem, attribute: .width, multiplier: 1, constant: -(2 * indicatorPadding))
        indicatorWidthConstraint = wConstraint
        self.addConstraint(wConstraint)
        
        let hConstraint = NSLayoutConstraint(item: selectionIndicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.indicatorThickness)
        self.indicatorHeightConstraint = hConstraint
        self.addConstraint(hConstraint)
    }
    
    private func initButtons() {
        for button in self.buttons {
            button.removeFromSuperview()
        }
        
        guard self.numberOfSegments > 0 else {
            return
        }
        
        
        var views = [String: AnyObject]()
        var xVisualFormat = "H:|"
        let yVisualFormat = "V:|[button0]|"
        var previousButtonName: String? = nil
        
        var buttons = [SWSegmentedItem]()
        
        defer {
            self.buttons = buttons
        }
        for index in 0..<self.numberOfSegments {
            let button = SWSegmentedItem()
            self.configureButton(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.title = titleForSegmentAtIndex(index)
            button.addTarget(self, action: #selector(SWSegmentedControl.didTapButton(_:)), for: .touchUpInside)
            button.isSelected = (index == selectedSegmentIndex)
            
            buttons.append(button)
            self.addSubview(button)
            
            let buttonName = "button\(index)"
            views[buttonName] = button
            if let previousButtonName = previousButtonName {
                xVisualFormat.append("[\(buttonName)(==\(previousButtonName))]")
            } else {
                xVisualFormat.append("[\(buttonName)]")
            }
            
            previousButtonName = buttonName
        }
        
        xVisualFormat.append("|")
        
        let xConstraints = NSLayoutConstraint.constraints(withVisualFormat: xVisualFormat, options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
        let yConstraints = NSLayoutConstraint.constraints(withVisualFormat: yVisualFormat, options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(xConstraints)
        NSLayoutConstraint.activate(yConstraints)
    }
    
    open func removeAllSegments() {
        items = []
    }
    
    open func setTitle(_ title: String, forSegmentAt index: Int) {
        guard index < items.count else {
            return
        }
        
        items[index] = title
        
        let button = buttons[index]
        button.title = title
    }
    
    open func setBadge(_ badge: String?, forSegmentAt index: Int) {
        guard index < buttons.count else {
            return
        }
        
        let button = buttons[index]
        button.badge = badge
    }
    
    open func titleForSegmentAtIndex(_ segment: Int) -> String? {
        guard segment < self.items.count else {
            return nil
        }
        
        return self.items[segment]
    }
    
    open func setSelectedSegmentIndex(_ index: Int, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.1, animations: {
                self.selectedSegmentIndex = index
                self.layoutIfNeeded()
            })
        } else {
            self.selectedSegmentIndex = index
        }
    }
    
    override open func tintColorDidChange() {
        super.tintColorDidChange()
        
        self.configureView()
    }
    
    // MARK: - Appearance
    private func configureView() {
        self.configureIndicator()
        self.configureButtons()
    }
    
    private func colorToUse(_ color: UIColor?) -> UIColor {
        return color ?? self.tintColor
    }
    
    private func configureIndicator() {
        self.indicatorXConstraint?.constant =  CGFloat(self.selectedSegmentIndex) * self.itemWidth
        indicatorWidthConstraint?.constant = -(2 * indicatorPadding)
        self.selectionIndicatorView?.backgroundColor = self.colorToUse(self.indicatorColor)
    }
    
    private func configureButtons() {
        for button in buttons {
            self.configureButton(button)
        }
    }
    
    private func configureButton(_ button: SWSegmentedItem) {
        button.badgeView.label.font = self.badgeFont
        button.textLabel.font = self.font
        button.setTitleColor(self.colorToUse(self.titleColor), for: .selected)
        button.setTitleColor(self.unselectedTitleColor, for: .normal)
        button.badgeColor = colorToUse(badgeColor)
        button.badgeContentInsets = badgeContentInsets
    }
    
    // MARK: - Actions
    @objc func didTapButton(_ button: SWSegmentedItem) {
        guard let index = self.buttons.index(of: button) else {
            return
        }
        
        if let shouldSelectItem = delegate?.segmentedControl?(self, canSelectItemAtIndex: index),
           shouldSelectItem == false {
            
            return
        }
        
        delegate?.segmentedControl?(self, willDeselectItemAtIndex: selectedSegmentIndex)
        delegate?.segmentedControl?(self, willSelectItemAtIndex: index)
        
        self.setSelectedSegmentIndex(index)
        self.sendActions(for: .valueChanged)
        
        delegate?.segmentedControl?(self, didDeselectItemAtIndex: selectedSegmentIndex)
        delegate?.segmentedControl?(self, didSelectItemAtIndex: index)
    }
    
    // MARK: - Layout Helpers
    private var xToItem: UIView {
        return self.buttons[0]
    }
    
    private var wToItem: UIView {
        
        return self.buttons[0]
    }
    
    private var itemWidth: CGFloat {
        return self.bounds.size.width / CGFloat(self.numberOfSegments)
    }
}
