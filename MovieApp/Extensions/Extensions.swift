//
//  Extensions.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation
import UIKit

class GradientView: UIView {

    private let gradient : CAGradientLayer = CAGradientLayer()
    private let gradientStartColor: UIColor
    private let gradientEndColor: UIColor

    init(gradientStartColor: UIColor, gradientEndColor: UIColor) {
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }

    override public func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        gradient.colors = [gradientEndColor.cgColor, gradientStartColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 0.85)
        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
    }
}
