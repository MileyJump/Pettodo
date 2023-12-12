//
//  CorneredTabBar.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/07/31.
//

import UIKit


@IBDesignable class RoundedTabbarView: UITabBar {
    struct UIConfig {
        static let shadowOffset: CGSize = CGSize(width: 0, height: -2)
        static let shadowOpacity: Float = 0.21
        static let shadowRadius: CGFloat = 8
        static let titleOffset: UIOffset = UIOffset(horizontal: 0.0, vertical: -5.0)
    }
    // MARK: - Public Properties
    @IBInspectable var fillColor: UIColor = .white
    @IBInspectable var cornerRadius: CGFloat = 18
    @IBInspectable var bottomMargin: CGFloat = 65
    @IBInspectable var strokeColor: UIColor = .gray
    @IBInspectable var strokeLineWidth: CGFloat = 1
    // MARK: - Private Properites
    private var shapeLayer: CALayer?
    // MARK: - Public Functions
    override func draw(_ rect: CGRect) {
        addShape()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        let height = bottomMargin + safeAreaInsets.bottom
        tabFrame.size.height = height
        tabFrame.origin.y = self.frame.origin.y + self.frame.height - height
        self.layer.cornerRadius = cornerRadius
        self.frame = tabFrame
        self.items?.forEach({ $0.titlePositionAdjustment = UIConfig.titleOffset })
    }
    override func prepareForInterfaceBuilder() {
        setNeedsDisplay()
    }
    // MARK: - Private Functions
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.lineWidth = strokeLineWidth
        shapeLayer.shadowColor = strokeColor.cgColor
        shapeLayer.shadowOffset = UIConfig.shadowOffset
        shapeLayer.shadowOpacity = UIConfig.shadowOpacity
        shapeLayer.shadowRadius = UIConfig.shadowRadius
        shapeLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadius, height: 0.0))
        return path.cgPath
    }
}
