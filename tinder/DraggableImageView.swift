//
//  DraggableImageView.swift
//  tinder
//
//  Created by Paul Sokolik on 10/11/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

class DraggableImageView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cardImageView: UIImageView!
    
    var originalPosition: CGPoint!
    var rotationConstant: CGFloat!
    
    var image: UIImage? {
        get {
            return cardImageView.image
        }
        set(newValue) {
            cardImageView.image = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

    @IBAction func onPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let location = sender.location(in: self)
        
        if sender.state == .began {
            originalPosition = contentView.center
            if location.y > contentView.frame.height/2 {
                rotationConstant = -0.002
            } else {
                rotationConstant = 0.002
            }
        } else if sender.state == .changed {
            contentView.center = CGPoint(x: originalPosition.x + translation.x, y: originalPosition.y)
            contentView.transform = CGAffineTransform(rotationAngle: translation.x * rotationConstant)
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.3, animations: {
                if translation.x > 50 || translation.x < -50 {
                    let direction: CGFloat = translation.x > 0 ? 1.0 : -1.0
                    self.contentView.center = CGPoint(x: self.contentView.center.x + direction * 200, y: self.originalPosition.y)
                    self.contentView.transform = CGAffineTransform(rotationAngle: (translation.x + direction * 200) * self.rotationConstant)
                } else {
                    self.contentView.center = self.originalPosition
                    self.contentView.transform = CGAffineTransform.identity
                }
            }, completion: { (success: Bool) in
                self.contentView.center = self.originalPosition
                self.contentView.transform = CGAffineTransform.identity
            })
        }
    }
}
