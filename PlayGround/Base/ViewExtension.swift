//
//  ViewExtension.swift
//  PlayGround
//
//  Created by kim jason on 26/10/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

// Created by Daniel Kim on 2018. 4. 23..
// Copyright (c) 2018 rootone. All rights reserved.
//

import Foundation
import UIKit
import Material
import SnapKit
import Localize_Swift


//Extensions
//Todo - 나중에 한번에 묶어서 정리 해야 합니다.

extension UIView {
    /// A helper function to add multiple subviews.
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
        }
    }

    func startBlink() {
        UIView.animate(withDuration: 0.8,
                delay:0.0,
                options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
                animations: { self.alpha = 0 },
                completion: nil)
    }

    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}

extension UIViewController {
    /// A helper function to add child view controller.
    func add(childViewController: UIViewController) {
        childViewController.willMove(toParent: self)
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
}

extension UIViewController {
    func presentationView(vc:UIViewController, animated:Bool) {
        if #available(iOS 13.0, *) {
            vc.modalPresentationStyle = .fullScreen
        }
        self.present(vc,animated: true)
    }
    
    func presentationViewOverContentContext(vc:UIViewController, animated:Bool) {
        if #available(iOS 13.0, *) {
            vc.modalPresentationStyle = .overCurrentContext
        }
        self.present(vc,animated: true)
    }
    
    
}


extension UINavigationController {
    func popToRootViewControllerWithHandler(completion: @escaping () -> ()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToRootViewController(animated: true)
        CATransaction.commit()
    }

    func showVerfy() {
        log?.debug("showVerfy")
    }


    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

extension UIView {
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue.x
            frame.origin.y = newValue.y
            self.frame = frame
        }
    }
    public var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size.width = newValue.width
            frame.size.height = newValue.height
            self.frame = frame
        }
    }
    public var rect: CGRect {
        get {
            return self.frame
        }
        set {
            self.frame = newValue
        }
    }
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    public var centerY: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
}

extension UIView {
    func origin(_ point: CGPoint) {
        frame.origin.x = point.x
        frame.origin.y = point.y
    }
}

var kIndexPathPointer = "kIndexPathPointer"
var changedIndexPathPointer = "changedIndexPathPointer"

extension UIFont {
    class func mediumSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
    }

    class func semiboldSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.semibold)
    }

    class func nanumFont(ofSize fontSize: Double) -> UIFont {
        return Font(.installed(.NanumBarunGothic), size: .custom(fontSize)).instance
    }

    class func nanumFontBold(ofSize fontSize: Double) -> UIFont {
        return Font(.installed(.NanumBarunGothicBold), size: .custom(fontSize)).instance
    }

}

extension UICollectionView {
    func setToIndexPath(_ indexPath: IndexPath) {
        objc_setAssociatedObject(self, &kIndexPathPointer, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func toIndexPath() -> IndexPath {
        let index = self.contentOffset.x / self.frame.size.width
        if index > 0 {
            return IndexPath(row: Int(index), section: 0)
        } else if let indexPath = objc_getAssociatedObject(self, &kIndexPathPointer) as? IndexPath {
            return indexPath
        } else {
            return IndexPath(row: 0, section: 0)
        }
    }

    func fromPageIndexPath() -> IndexPath {
        let index: Int = Int(self.contentOffset.x / self.frame.size.width)
        return IndexPath(row: index, section: 0)
    }
}

extension UITableView {
    func setToIndexPath(_ indexPath: IndexPath) {
        objc_setAssociatedObject(self, &changedIndexPathPointer, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func toIndexPath() -> IndexPath {
        if let indexPath = objc_getAssociatedObject(self, &changedIndexPathPointer) as? IndexPath {
            return indexPath
        } else {
            return IndexPath(row: 0, section: 0)
        }
    }

    func setChangedIndexPath(_ indexPath: IndexPath) {
        objc_setAssociatedObject(self, &kIndexPathPointer, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func changedIndexPath() -> IndexPath {
        if let indexPath = objc_getAssociatedObject(self, &kIndexPathPointer) as? IndexPath {
            return indexPath
        } else {
            return IndexPath(row: 0, section: 0)
        }
    }

    func fromPageIndexPath() -> IndexPath {
        let index: Int = Int(self.contentOffset.x / self.frame.size.width)
        return IndexPath(row: index, section: 0)
    }
}


extension UIViewController {
    class func fromNib<T: UIViewController>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }

    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(UIViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

private let minimumHitArea = CGSize(width: 44, height: 44)

extension UIButton {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // if the button is hidden/disabled/transparent it can't be hit
        if self.isHidden || !self.isUserInteractionEnabled || self.alpha < 0.01 {
            return nil
        }

        // increase the hit frame to be at least as big as minimumHitArea
        let buttonSize = self.bounds.size
        let widthToAdd = max(minimumHitArea.width - buttonSize.width, 0)
        let heightToAdd = max(minimumHitArea.height - buttonSize.height, 0)
        let largerFrame = self.bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)

        // perform hit test on larger frame
        return (largerFrame.contains(point)) ? self : nil
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    class func loadFromNib(_ nibName: String) -> UIView? {
        guard let nibs = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil) else {
            return nil
        }
        return nibs[0] as? UIView
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 3785411784
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag
                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}

extension RaisedButton {

    func textNoShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}

extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributedString = NSMutableAttributedString(string: text)
            
            let paragraphStyle = NSMutableParagraphStyle()
            
            paragraphStyle.lineSpacing = lineHeight
            
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            
            self.attributedText = attributedString
        }
    }
    
    func addCharactersSpacing(_ value: CGFloat = 1.15) {
        if let textString = text {
            let attrs: [NSAttributedString.Key: Any] = [.kern: value]
            attributedText = NSAttributedString(string: textString, attributes: attrs)
        }
    }

    func makeOutLine(oulineColor: UIColor, foregroundColor: UIColor) {
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor: oulineColor,
            NSAttributedString.Key.foregroundColor: foregroundColor,
            NSAttributedString.Key.strokeWidth: -4.0,
            NSAttributedString.Key.font: self.font
            ] as [NSAttributedString.Key: Any]
        self.attributedText = NSMutableAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
    }

    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)

            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))

            attributedText = attributedString
        }
    }
    
    func recognizeFont() {
        //ini이후에 폰트가 적혔을 경우, 알아서 폰트를 판단 해준다.
        if let title = self.text {
            let locale = title.guessLanguage()
            var isKorean = false
            
            if (locale == "한국어") {
                isKorean = true
            }
            let fontSize = self.fontSize
            if (isKorean) {
                self.font = Font(.installed(.NanumBarunGothic), size: .custom(Double(fontSize))).instance
            } else {
                self.font = UIFont.systemFont(ofSize: fontSize)
            }
        }
    }

}


extension UIAlertController {


    static func showMessage(_ message: String) {
        showAlert(title: "", message: message, actions: [UIAlertAction(title: "OK", style: .cancel, handler: nil)])
    }

    static func showAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for action in actions {
                alert.addAction(action)
            }
            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController, let presenting = navigationController.topViewController {
                presenting.present(alert, animated: true, completion: nil)
            }
        }
    }
}

//UICollectionView Extension
extension UICollectionView {
    fileprivate class SettingBatchContext {
        typealias BlockToExecuteBatch = () -> Void
        var isToExecuteBatch: Bool = false
        var blocksToExecuteBatch: [BlockToExecuteBatch] = []
    }

    fileprivate struct StaticVariable {
        static var settingBatchContextKey = "settingBatchContextKey"
    }

    fileprivate var settingBatchContext: SettingBatchContext {
        if let sbc = objc_getAssociatedObject(self,
                &StaticVariable.settingBatchContextKey)
                as? SettingBatchContext {
            return sbc
        } else {
            let sbc: SettingBatchContext = SettingBatchContext()
            objc_setAssociatedObject(self,
                    &StaticVariable.settingBatchContextKey, sbc,
                    objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return sbc
        }
    }

    func beginUpdates() {
        settingBatchContext.isToExecuteBatch = true
    }

    func endUpdates() {
        performBatchUpdates({ [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.settingBatchContext.blocksToExecuteBatch
                    .forEach({ $0() })
        }, completion: { [weak self] (_) in
            guard let weakSelf = self else {
                return
            }
            weakSelf.settingBatchContext.isToExecuteBatch = false
            weakSelf.settingBatchContext.blocksToExecuteBatch.removeAll()
        })
    }

    func reload(itemsAt: [IndexPath]) {
        if settingBatchContext.isToExecuteBatch {
            settingBatchContext.blocksToExecuteBatch.append({ [weak self]
            in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.reloadItems(at: itemsAt)
            })
        } else {
            reloadItems(at: itemsAt)
        }
    }

    func insert(itemsAt: [IndexPath]) {
        if settingBatchContext.isToExecuteBatch {
            settingBatchContext.blocksToExecuteBatch.append({ [weak self]
            in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.insertItems(at: itemsAt)
            })
        } else {
            insertItems(at: itemsAt)
        }
    }

    func delete(itemsAt: [IndexPath]) {
        if settingBatchContext.isToExecuteBatch {
            settingBatchContext.blocksToExecuteBatch.append({ [weak self]
            in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.deleteItems(at: itemsAt)
            })
        } else {
            deleteItems(at: itemsAt)
        }
    }
}

extension CALayer {
    func applySketchShadow(
            color: UIColor = UIColor(hexString: ""),
            alpha: Float = 0.5,
            x: CGFloat = 0,
            y: CGFloat = 1,
            blur: CGFloat = 1,
            spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension RaisedButton {

    
    func generateConfirmRaisedbutton() -> RaisedButton {
        let raisedButton = RaisedButton(title: "ok".localized(), titleColor: BBMainBackgroundColor)
        raisedButton.pulseColor = BBGrey3Color
        raisedButton.backgroundColor = BBMainBackgroundColor
        raisedButton.isUserInteractionEnabled = true
        raisedButton.layer.zPosition = 0;
        raisedButton.layer.shadowColor = BBMainBackgroundColor.cgColor
        raisedButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        raisedButton.layer.shadowOpacity = 0.0
        raisedButton.layer.masksToBounds = false
        return raisedButton
    }
    
    
    func setCellBackgroundRaisedButton() -> RaisedButton {
        let raisedButton = RaisedButton(title: "", titleColor: BBMainBackgroundColor)
        raisedButton.pulseColor = BBGrey3Color
        raisedButton.backgroundColor = BBMainBackgroundColor
        raisedButton.isUserInteractionEnabled = true
        raisedButton.layer.zPosition = 0;
        raisedButton.layer.shadowColor = BBMainBackgroundColor.cgColor
        raisedButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        raisedButton.layer.shadowOpacity = 0.0
        raisedButton.layer.masksToBounds = false
        return raisedButton
    }

    func setAlertLabelImageRaisedButton(title: String, image: UIImage) -> RaisedButton {
        var raisedButton = RaisedButton()
        raisedButton = RaisedButton(title: title, titleColor: BBBlackColor)
        raisedButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        raisedButton.pulseColor = BBGreyColor
        raisedButton.image = image
        raisedButton.backgroundColor = BBWhiteColor
        raisedButton.layer.masksToBounds = true
        raisedButton.layer.borderColor = .none
        raisedButton.layer.borderWidth = 0
        raisedButton.layer.cornerRadius = 0
        raisedButton.layer.zPosition = 1
        raisedButton.isUserInteractionEnabled = true
        return raisedButton
    }
}

class ZPositionZeroLayer: CALayer {
    override var zPosition: CGFloat {
        get {
            return 0
        }
        set {
        }
    }
}

extension UIView {
    func makeCorner(withRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.isOpaque = false
    }
}

extension UIDatePicker {

    func setLimit(forCalendarComponent component: Calendar.Component, minimumUnit min: Int, maximumUnit max: Int) {

        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)

        guard let timeZone = TimeZone(identifier: "KST") else {
            return
        }
        calendar.timeZone = timeZone

        var components: DateComponents = DateComponents()
        components.calendar = calendar

        components.setValue(-min, for: component)
        if let maxDate: Date = calendar.date(byAdding: components, to: currentDate) {
            self.maximumDate = maxDate
        }

        components.setValue(-max, for: component)
        if let minDate: Date = calendar.date(byAdding: components, to: currentDate) {
            self.minimumDate = minDate
        }
    }
}


extension UIWindow {

    func switchRootViewController(_ viewController: UIViewController, animated: Bool = true, duration: TimeInterval = 0.5, options: UIView.AnimationOptions = .transitionCrossDissolve, completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = BaseNavigationController(rootViewController: viewController)
            return
        }

        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = BaseNavigationController(rootViewController: viewController)
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}

extension UIScrollView {
    /// Sets content offset to the top.
    func resetScrollPositionToTop() {
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
}


/// Functions

func setLabel(title: String = "", size: CGFloat = 12, textColor: UIColor = BBBlackColor, textAlign: NSTextAlignment = .center, numberOfLines: Int = 1, isBold: Bool = false, isSemiBold: Bool = false, isLight: Bool = false,
              bgColor: UIColor? = .clear)
                -> UILabel {
    let locale = title.guessLanguage()
    var isKorean = false
    
    if (locale == "한국어") {
        isKorean = true
    }

    let label = UILabel()
    label.text = title

    if (isBold) {
        if (isKorean) {
            let fontSize: Double = Double(size)
            label.font = Font(.installed(.NanumBarunGothicBold), size: .custom(fontSize)).instance
        } else {
            label.font = UIFont.boldSystemFont(ofSize: size)
        }
    } else {
        if (isKorean) {
            let fontSize: Double = Double(size)
            label.font = Font(.installed(.NanumBarunGothic), size: .custom(fontSize)).instance
        } else {
            label.font = UIFont.systemFont(ofSize: size)
        }
    }
    if (isSemiBold) {
        if (isKorean) {
            let fontSize: Double = Double(size)
            label.font = Font(.installed(.NanumBarunGothicBold), size: .custom(fontSize)).instance
        } else {
            label.font = UIFont.semiboldSystemFont(ofSize: size)
        }
    }
    if (isLight) {
        if (isKorean) {
            let fontSize: Double = Double(size)
            label.font = Font(.installed(.NanumBarunGothicLight), size: .custom(fontSize)).instance
        } else {
            label.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.light)
        }
    }

    label.textColor = textColor
    label.backgroundColor = bgColor
    label.textAlignment = textAlign
    label.numberOfLines = numberOfLines
    return label
}

// StatusBar의 색상을 어디서든 바꿀 수 있도록 해야 한다.
func changeStatusBar(color: UIColor) {
//    guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
//        return
//    }
//
//    statusBar.backgroundColor color
}

func setIconButton(named: String, tintColor: UIColor? = nil) -> IconButton {
    if (tintColor != nil) {
        return IconButton(image: UIImage(named: named)?.imageWithColor(newColor: tintColor))
    }
    return IconButton(image: UIImage(named: named))
}


func setWalletMainCell(cell: UICollectionViewCell) {
    cell.backgroundColor = BBWhiteColor
    cell.layer.masksToBounds = false
    cell.layer.cornerRadius = CGFloat(4.0)
    cell.layer.borderWidth = CGFloat(1.0)
    cell.layer.borderColor = BBIvoryColor.withAlphaComponent(0.25).cgColor
    cell.layer.applySketchShadow(color: BBBlackColor, alpha: 0.1, x: 0, y: 1, blur: 1, spread: 0)
}


extension UIView {

}


extension UITextView {
    func centerY() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }

    
}


class CustomTextField: TextField {

    override func caretRect(for position: UITextPosition) -> CGRect {
        var rect = super.caretRect(for: position)
        let size = CGSize(width: 10, height: 50)
        // Calculating center y
        let y = rect.origin.y - (size.height - rect.size.height)/2
        rect = CGRect(origin: CGPoint(x: rect.origin.x, y: y), size: size)
        return rect
    }
}

func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
   
    return newImage
}


// Font

struct Font {

    enum FontType {
        case installed(FontName)
        case custom(String)
        case system
        case systemBold
        case systemItatic
        case systemWeighted(weight: Double)
        case monoSpacedDigit(size: Double, weight: Double)
    }

    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }

    enum FontName: String {
        case NanumBarunGothic = "NanumBarunGothicOTF"
        case NanumBarunGothicBold = "NanumBarunGothicOTFBold"
        case NanumBarunGothicLight = "NanumBarunGothicOTFLight"
        case NanumBarunGothicUltraLight = "NanumBarunGothicOTFUltraLight"
    }

    enum StandardSize: Double {
        case h1 = 30.0
        case h2 = 20.0
        case h3 = 17.0
        case h4 = 15.0
        case h5 = 13.0
        case h6 = 12.0
    }


    var type: FontType
    var size: FontSize

    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}

extension Font {

    var instance: UIFont {

        var instanceFont: UIFont!
        switch type {
        case .custom(let fontName):
            guard let font = UIFont(name: fontName, size: CGFloat(size.value)) else {
                fatalError("\(fontName) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .installed(let fontName):
            guard let font = UIFont(name: fontName.rawValue, size: CGFloat(size.value)) else {
                fatalError("\(fontName.rawValue) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemItatic:
            instanceFont = UIFont.italicSystemFont(ofSize: CGFloat(size.value))
        case .systemWeighted(let weight):
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value),
                    weight: UIFont.Weight(rawValue: CGFloat(weight)))
        case .monoSpacedDigit(let size, let weight):
            instanceFont = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(size),
                    weight: UIFont.Weight(rawValue: CGFloat(weight)))
        }
        return instanceFont
    }
}

class Utility {
    /// Logs all available fonts from iOS SDK and installed custom font
    class func logAllAvailableFonts() {
        for family in UIFont.familyNames {
            log?.debug("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                log?.debug("   \(name)")
            }
        }
    }
}

// GuessLanguage

extension String {
    func guessLanguage() -> String {
        let length = self.utf16.count
        let languageCode = CFStringTokenizerCopyBestStringLanguage(self as CFString, CFRange(location: 0, length: length)) as String? ?? ""

        let locale = Locale(identifier: languageCode)
        return locale.localizedString(forLanguageCode: languageCode) ?? "Unknown"
    }
    
    func getUrlScheme() -> String {
        var result = ""
        result = self.replacingOccurrences(of: "connectScheme=", with: "")
        return result
    }
}


// UIImage

extension UIImage {

    // colorize image with given tint color
    // this is similar to Photoshop's "Color" layer blend mode
    // this is perfect for non-greyscale source images, and images that have both highlights and shadows that should be preserved
    // white will stay white and black will stay black as the lightness of the image is preserved
    func tint(tintColor: UIColor) -> UIImage {

        return modifiedImage { context, rect in
            // draw black background - workaround to preserve color of partially transparent pixels
            context.setBlendMode(.normal)
            UIColor.black.setFill()
            context.fill(rect)

            // draw original image
            context.setBlendMode(.normal)
            context.draw(self.cgImage!, in: rect)

            // tint image (loosing alpha) - the luminosity of the original image is preserved
            context.setBlendMode(.color)
            tintColor.setFill()
            context.fill(rect)

            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }

    // fills the alpha channel of the source image with the given color
    // any color information except to the alpha channel will be ignored
    func fillAlpha(fillColor: UIColor) -> UIImage {

        return modifiedImage { context, rect in
            // draw tint color
            context.setBlendMode(.normal)
            fillColor.setFill()
            context.fill(rect)
//            context.fillCGContextFillRect(context, rect)

            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }

    private func modifiedImage(draw: (CGContext, CGRect) -> ()) -> UIImage {

        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        assert(context != nil)

        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)

        draw(context, rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    convenience init?(imageName: String) {
        self.init(named: imageName)!
        accessibilityIdentifier = imageName
    }

    // https://stackoverflow.com/a/40177870/4488252
    func imageWithColor (newColor: UIColor?) -> UIImage? {

        if let newColor = newColor {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)

            let context = UIGraphicsGetCurrentContext()!
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(.normal)

            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            context.clip(to: rect, mask: cgImage!)

            newColor.setFill()
            context.fill(rect)

            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            newImage.accessibilityIdentifier = accessibilityIdentifier
            return newImage
        }

        if let accessibilityIdentifier = accessibilityIdentifier {
            return UIImage(imageName: accessibilityIdentifier)
        }

        return self
    }
}

extension UIImageView {
    func playBounceAnimation() {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.1, 0.9, 1.05, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.5)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic

        self.layer.add(bounceAnimation, forKey: nil)

        if let iconImage = self.image {
            let renderImage = iconImage.withRenderingMode(.alwaysTemplate)
            self.image = renderImage
            self.tintColor = BBBlackColor
        }
    }

    func changePngColorTo(color: UIColor){
        guard let image =  self.image else {return}
        self.image = image.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}


extension UIView {
    func setGradientBackground(colorLeft: UIColor, colorRight: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorLeft.cgColor, colorRight.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}


extension String {
    /// stringToFind must be at least 1 character.
    func countInstances(of stringToFind: String) -> Int {
        assert(!stringToFind.isEmpty)
        var count = 0
        var searchRange: Range<String.Index>?
        while let foundRange = range(of: stringToFind, options: [], range: searchRange) {
            count += 1
            searchRange = Range(uncheckedBounds: (lower: foundRange.upperBound, upper: endIndex))
        }
        return count
    }
}
