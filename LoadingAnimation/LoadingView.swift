//
//  LoadingView.swift
//  LoadingAnimation
//
//  Created by Sagar Baloch on 02/11/2020.
//

import UIKit

class LoadingView: UIView {
    
    public var colorOfCircle: CGColor?
    public var radiusOfCircle: CGFloat?
    
    // The alternative way is to use singleton that is not implemented yet...!
    init(controllerView: UIView?,colorOfCircle: CGColor, radiusOfCircle: CGFloat) {
        super.init(frame: .zero)
        setupView(controllerView: controllerView, colorOfCircle: colorOfCircle, radiusOfCircle: radiusOfCircle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Properties
    
    fileprivate lazy var circleLayer: CAShapeLayer = {
        let circle = CAShapeLayer()
        let path = UIBezierPath(arcCenter: .zero,
                                radius: radiusOfCircle!,
                                startAngle: CGFloat.pi,
                                endAngle: CGFloat.pi + (CGFloat.pi * 2),
                                clockwise: true)
        print(CGFloat.pi/2)
        circle.path = path.cgPath
        circle.strokeColor = colorOfCircle
        circle.fillColor = .none
        circle.lineWidth = 10
        return circle
    }()
    
    fileprivate lazy var strokeAnimationGroup: CAAnimationGroup = {
        let animation = CAAnimationGroup()
        animation.animations = [strokeStartAnimation, strokeEndAnimation]
        animation.duration = 2
        animation.repeatCount = .infinity
        animation.timingFunction = .init(name: .easeInEaseOut)
        return animation
    }()
    
    fileprivate lazy var strokeEndAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1.5
        return animation
    }()
    
    fileprivate lazy var strokeStartAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1.5
        animation.beginTime = 0.5
        return animation
    }()
    
    fileprivate lazy var rotationAnimation: CABasicAnimation = {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = (2 * CGFloat.pi)
        rotation.duration = 3
        rotation.repeatCount = .infinity
        return rotation
    }()
    
    fileprivate lazy var startOpacityAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        return animation
    }()
    
    fileprivate lazy var endingOpacityAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 1.5
        return animation
    }()
    
    fileprivate lazy var backgroundLayer:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .blue
        v.alpha = 0.8
        return v
    }()
    //MARK: - Functions
    
    public func startLoading(){
        print("Starting")
        layer.addSublayer(circleLayer)
        startAnimation()
    }
    
    public func stopLoading(){
        print("Ending")
        self.circleLayer.add(self.endingOpacityAnimation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            self.circleLayer.removeFromSuperlayer()
            self.removeFromSuperview()
        }
    }
    
    fileprivate func setupView(controllerView: UIView?,colorOfCircle: CGColor, radiusOfCircle: CGFloat){
        self.colorOfCircle = colorOfCircle
        self.radiusOfCircle = radiusOfCircle
        addSubview(backgroundLayer)
        backgroundLayer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundLayer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundLayer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundLayer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        controllerView!.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: controllerView!.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: controllerView!.centerYAnchor).isActive = true
    }
    
    private func startAnimation(){
        circleLayer.add(strokeAnimationGroup, forKey: nil)
        circleLayer.add(rotationAnimation, forKey: nil)
        circleLayer.add(startOpacityAnimation, forKey: nil)
    }
}
