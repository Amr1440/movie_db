//
//  UIView+Extension.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit

public enum UIViewBorderSide {
    case top, bottom, left, right, all
}

public enum UIViewRoundedSide:String {
    case topLeft, bottomLeft, topRight, bottomRight, all
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var roundedCornerSide: String {
        get {
            return self.accessibilityIdentifier ?? ""
        }
        set {
            self.accessibilityIdentifier = newValue
            makeRoundedCornerForSides(sides: newValue)
        }
    }
    

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func makeRoundedCornerForSides(sides:String) {
        let roundedSides = sides.split(separator: ",")
        layer.cornerRadius = cornerRadius
        var maskedCorners: CACornerMask = CACornerMask.init()
        
        for side in roundedSides {
            if side == UIViewRoundedSide.all.rawValue {
                layer.masksToBounds = cornerRadius > 0
            } else if side == UIViewRoundedSide.topLeft.rawValue {
                maskedCorners.insert(.layerMinXMinYCorner)
            } else if side == UIViewRoundedSide.topRight.rawValue {
                maskedCorners.insert(.layerMaxXMinYCorner)
            } else if side == UIViewRoundedSide.bottomLeft.rawValue {
                maskedCorners.insert(.layerMinXMaxYCorner)
            } else if side == UIViewRoundedSide.bottomRight.rawValue {
                maskedCorners.insert(.layerMaxXMaxYCorner)
            }
        }
        self.layer.maskedCorners = maskedCorners
    }

    func addBorder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func addShadow(shadowOffsetWidth: CGFloat = 0.0, shadowOffsetHeight: CGFloat = 0.5, shadowColor: UIColor = .gray, shadowOpacity: Float = 0.2, cornerRadius: CGFloat = 0.0) {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }

    func addShadow() {
        layer.shadowColor = UIColor(hue: 226 / 255, saturation: 86 / 255, brightness: 82 / 255, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.3
    }

    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }

    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }

    func fadeOutAndIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            self.fadeIn(duration: duration)
        })
    }

    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }

    func addBorder(side: UIViewBorderSide, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor

        switch side {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: width)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: frame.size.height)
        case .right:
            border.frame = CGRect(x: frame.size.width - width, y: 0, width: width, height: frame.size.height)
        case .all:
            addBorder(color: color, width: width)
            return ;
        }

        layer.addSublayer(border)
    }

    func addDashedBorder(width: CGFloat? = nil, height: CGFloat? = nil, lineWidth: CGFloat = 2, lineDashPattern: [NSNumber]? = [6, 3], strokeColor: UIColor = UIColor.red, fillColor: UIColor = UIColor.clear) {
        var fWidth: CGFloat? = width
        var fHeight: CGFloat? = height

        if fWidth == nil {
            fWidth = frame.width
        }

        if fHeight == nil {
            fHeight = frame.height
        }

        let shapeLayer: CAShapeLayer = CAShapeLayer()

        let shapeRect = CGRect(x: 0, y: 0, width: fWidth!, height: fHeight!)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: fWidth! / 2, y: fHeight! / 2)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = lineDashPattern
        shapeLayer.name = "kShapeDashed"
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

        layer.addSublayer(shapeLayer)
    }

    func addDottedBorder(color: UIColor, lineDashPattern: [NSNumber], view: UIView) -> CALayer {
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = color.cgColor
        yourViewBorder.lineDashPattern = lineDashPattern
        yourViewBorder.fillColor = nil
        yourViewBorder.lineWidth = 1
        yourViewBorder.lineJoin = CAShapeLayerLineJoin.round

        yourViewBorder.lineCap = .square
        yourViewBorder.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.size.height), cornerRadius: 4).cgPath
        view.layer.addSublayer(yourViewBorder)
        return yourViewBorder
    }

    func drawDottedLine(start: CGPoint, end: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [3, 1] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [start, end])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func dashedBorderLayerWithColor(color: CGColor, view: UIView) -> CAShapeLayer {
        let borderLayer = CAShapeLayer()
        borderLayer.name = "borderLayer"
        let frameSize = view.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        borderLayer.bounds = shapeRect
        borderLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color
        borderLayer.lineWidth = 1
        borderLayer.lineJoin = CAShapeLayerLineJoin.round
        borderLayer.lineDashPattern = NSArray(array: [NSNumber(value: 8), NSNumber(value: 4)]) as? [NSNumber]

        let path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 0)

        borderLayer.path = path.cgPath

        return borderLayer
    }

    func allSubviewsOfClass<K: UIView>(_ clazz: K.Type) -> [K] {
        var matches = [K]()
        if subviews.isEmpty { return matches }
        matches.append(contentsOf: subviews.filter { $0 is K } as! [K])
        let matchesInSubviews = subviews.flatMap { $0.allSubviewsOfClass(clazz) }
        matches.append(contentsOf: matchesInSubviews.compactMap { $0 })
        return matches
    }
}

