//
//  AnimationForUIView.swift
//  Rick&Morty
//
//  Created by Andrey Novikov on 12/15/19.
//  Copyright © 2019 Andrey Novikov. All rights reserved.
//

import UIKit

extension UIViewController {
    func transform(for view: UIView, nameAnimation: String, duration: CFTimeInterval, fromValue: Float, toValue: Float, autoreverses: Bool, repeatCount: Float) {
        
        let animation = CASpringAnimation(keyPath: nameAnimation)
        
        animation.duration = duration
        animation.fromValue = duration
        animation.toValue = fromValue
        animation.autoreverses = autoreverses
        animation.repeatCount = repeatCount
        view.layer.add(animation, forKey: nil)
    }
}
