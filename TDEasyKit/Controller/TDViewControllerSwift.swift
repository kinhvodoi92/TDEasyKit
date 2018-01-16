//
//  TDViewController.swift
//  TDEasyKit
//
//  Created by Duc Dang on 4/24/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

import UIKit

@objc
protocol TDNavigationBarDelegate : NSObjectProtocol {
    @objc
    func pressedBack(_ navigationBar: TDNavigationBar)
}

/**
 Custom NavigationBar
 Contain: LeftContainer, CenterContainer, RightContainer
 AutoLayout
 Default Height: 44
 */
class TDNavigationBar : UIView {
    var delegate: TDNavigationBarDelegate?

    var navigationBarHeight : CGFloat = TDConstant.navigationBarHeight

    var isHidesBackButton : Bool = false

    var centerItemsSpacing : CGFloat = 10

    /// Back, Menu, Left Actions,...
    let leftContainer : UIView = {
        let node = UIView()
        node.layer.masksToBounds = true
        return node
    }()

    /// Title,....
    let centerContainer : UIView = {
        let node = UIView()
        node.layer.masksToBounds = true
        return node
    }()

    let centerView : UIView = {
        let view = UIView()
        return view
    }()

    /// More Actions, Menu,.....
    let rightContainer : UIView = {
        let node = UIView()
        node.layer.masksToBounds = true
        return node
    }()

    private let backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "icon_bar_back_green", in: TDConstant.bundle, compatibleWith: nil), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()
    }

    func setup() {
        self.backgroundColor = TDConstant.navigationBarColor

        self.addSubview(backButton)
        self.addSubview(leftContainer)
        self.addSubview(centerContainer)
        self.addSubview(rightContainer)

        centerContainer.addSubview(centerView)

        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }

    func setLeftViews(_ views: [UIView]?) {
        self.setViews(views, for: leftContainer)
    }

    func setCenterViews(_ views: [UIView]?) {
        self.setCenterViews(views, spacing: 0)
    }

    func setCenterViews(_ views: [UIView]?, spacing: CGFloat) {
        centerItemsSpacing = spacing

        centerView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }

        guard let list = views else {
            self.layoutSubviews()
            return
        }

        list.forEach { (view) in
            centerView.addSubview(view)
        }

        self.layoutSubviews()
    }

    func setRightViews(_ views: [UIView]?) {
        self.setViews(views, for: rightContainer)
    }

    /// Thay the cac view vao Container
    ///
    /// - Parameter views: danh sach cac subviews
    func setViews(_ views: [UIView]?, for container: UIView) {
        container.subviews.forEach { (view) in
            view.removeFromSuperview()
        }

        guard let list = views else {
            self.layoutSubviews()
            return
        }

        list.forEach { (view) in
            container.addSubview(view)
        }

        self.layoutSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layoutLeftContainer()
        self.layoutRightContainer()

        backButton.frame = CGRect(x: 0, y: 0, width: isHidesBackButton ? 0 : navigationBarHeight, height: navigationBarHeight)
        leftContainer.frame = CGRect(x: backButton.frame.maxX, y: 0, width: leftContainer.frame.width, height: navigationBarHeight)
        rightContainer.frame = CGRect(x: self.frame.width - rightContainer.frame.width, y: 0, width: rightContainer.frame.width, height: navigationBarHeight)

        centerContainer.frame = CGRect(x: leftContainer.frame.maxX, y: 0, width: rightContainer.frame.minX - leftContainer.frame.maxX, height: navigationBarHeight)

        self.layoutCenterContainer()
    }

    func layoutLeftContainer()
    {
        self.layoutContainer(leftContainer)
    }

    /// Can giua navigationbar
    func layoutCenterContainer()
    {
        var width : CGFloat = 0
        centerView.subviews.forEach { (view) in
            view.frame = CGRect(x: width, y: (navigationBarHeight - view.frame.height) / 2, width: view.frame.width, height: view.frame.height)
            width += view.frame.width + centerItemsSpacing
        }

        width -= centerItemsSpacing

        var rect = centerView.frame
        rect.size.width = width
        rect.size.height = navigationBarHeight
        rect.origin.x = (self.frame.width - width) / 2
        rect = self.convert(rect, to: centerContainer)

        rect.origin.y = 0

        print(rect)
        centerView.frame = rect
    }

    func layoutRightContainer()
    {
        self.layoutContainer(rightContainer)
    }

    func layoutContainer(_ container : UIView) {
        var width : CGFloat = 0
        container.subviews.forEach { (view) in
            view.frame = CGRect(x: width, y: 0, width: navigationBarHeight, height: navigationBarHeight)
            width += navigationBarHeight
        }

        var rect = container.frame
        rect.size.width = width
        container.frame = rect
    }
}

extension TDNavigationBar {
    func back() {
        if let delegate = self.delegate, delegate.responds(to: #selector(TDNavigationBarDelegate.pressedBack(_:))) {
            delegate.pressedBack(self)
        }
    }
}

open class TDViewController: UIViewController, TDObjectProtocol, TDNavigationBarDelegate {
    var _leftViews : [UIView]?
    /// set list of left views
    open var leftViews: [UIView]? {
        set (value) {
            _leftViews = value
            navigationBar.setLeftViews(value)
        }

        get {
            return self._leftViews
        }
    }

    var _rightViews : [UIView]?
    /// set list of right views
    open var rightViews: [UIView]? {
        set (value) {
            _rightViews = value
            navigationBar.setRightViews(value)
        }

        get {
            return self._rightViews
        }
    }

    var _titleViews : [UIView]?
    /// set single center view
    open var titleViews: [UIView]? {
        set (value) {
            _titleViews = value
            navigationBar.setCenterViews(value)
        }

        get {
            return self._titleViews
        }
    }

    var _titleView : UIView?
    /// set single center view
    open var titleView: UIView? {
        set (value) {
            _titleView = value

            self.titleViews = value != nil ? [value!] : nil
        }

        get {
            return self._titleView
        }
    }

    let titleLabel : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()

    var _title : String?
    /// Override set Title function
    open override var title: String? {
        set (value) {
            _title = value

            self.setTitle(value, font: UIFont.systemFont(ofSize: 14))
        }

        get {
            return self._title
        }
    }

    /// set visible/invisible back button
    open var isHidesBackButton : Bool {
        set (value) {
            navigationBar.isHidesBackButton = value
        }

        get {
            return navigationBar.isHidesBackButton
        }
    }

    /**
     Custom NavigationBar for Each ViewController
     */
    let navigationBar: TDNavigationBar = {
        let view = TDNavigationBar()
        view.backgroundColor = TDConstant.navigationBarColor
        return view
    }()

    /**
     StatusBar Background for Each ViewController
     */
    private let statusBar: UIView = {
        let view = UIView()
        view.layer.zPosition = 10
        view.backgroundColor = TDConstant.navigationBarColor
        return view
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.delegate = self

        self.view.addSubview(navigationBar)
        self.view.addSubview(statusBar)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        statusBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIApplication.shared.isStatusBarHidden ? 0 : 20)
        navigationBar.frame = CGRect(x: 0, y: statusBar.frame.minY + statusBar.frame.height, width: self.view.frame.width, height: navigationBar.navigationBarHeight)
    }
}

extension TDViewController {
    /// Detect back button pressed
    ///
    /// - Parameter navigationBar: navigationBar contain the back button
    func pressedBack(_ navigationBar: TDNavigationBar) {
        guard let navi = self.navigationController,
            let topViewController = navi.topViewController,
            topViewController.isEqual(self),
            navigationBar.isEqual(self.navigationBar) else {
                return
        }

        navi.popViewController(animated: true)
    }
}

extension TDViewController {
    /// Set Center bar view with items spacing
    ///
    /// - Parameters:
    ///   - views: List of views
    ///   - spacing: spacing between views
    open func setTitleViews(_ views: [UIView]?, spacing: CGFloat) {
        navigationBar.setCenterViews(views, spacing: spacing)
    }

    open func setTitle(_ title: String?, font: UIFont) {
        titleLabel.text = title
        titleLabel.font = font
        
        titleLabel.sizeToFit()

        if titleView == nil {
            titleView = titleLabel
        }
    }
}
