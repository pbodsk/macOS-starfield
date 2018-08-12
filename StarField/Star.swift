//
//  Star.swift
//  StarField
//
//  Created by Peter Bødskov on 12/08/2018.
//  Copyright © 2018 Peter Bødskov. All rights reserved.
//

import Cocoa

class Star: NSView {
    
    var speed: CGFloat = 0.0
    
    convenience init(origin: CGPoint, speed: CGFloat) {
        let rect = NSRect(origin: origin, size: CGSize(width: 2.0, height: 2.0))
        self.init(frame: rect)
        self.speed = speed
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupStar()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setupStar()
    }
    
    private func setupStar() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor
        layer?.cornerRadius = bounds.width / 2
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
    }
    
    func updatePosition(direction: StarFieldDirection) {
        var previousPosition = frame.origin
        switch direction {
        case .up:
            previousPosition.y += speed
        case .down:
            previousPosition.y -= speed
        case .left:
            previousPosition.x -= speed
        case .right:
            previousPosition.x += speed
        }
        frame.origin = previousPosition
    }
    
    func updateValues(_ origin: CGPoint, speed: CGFloat) {
        frame.origin = origin
        self.speed = speed
    }
    
    func isContained(in view: NSView) -> Bool {
        return
            frame.origin.x > view.frame.origin.x &&
            frame.origin.x < view.frame.size.width &&
            frame.origin.y > view.frame.origin.y &&
            frame.origin.y < view.frame.size.height
    }
}
