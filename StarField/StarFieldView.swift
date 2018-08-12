//
//  StarFieldController.swift
//  StarField
//
//  Created by Peter Bødskov on 12/08/2018.
//  Copyright © 2018 Peter Bødskov. All rights reserved.
//

import AppKit

enum StarFieldDirection {
    case up
    case down
    case left
    case right
}

class StarFieldView: NSView {
    
    var numberOfStars: Int = 100
    var timerUpdateFrequency: TimeInterval = 0.1
    var tickTimer: Timer!
    var stars: [Star] = [Star]()
    var direction: StarFieldDirection = .left
    
    init() {
        super.init(frame: NSRect.zero)
        wantsLayer = true
        layer?.backgroundColor = NSColor.black.cgColor
        autoresizingMask = [ .height, .width ]
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare() {
        tickTimer = Timer.scheduledTimer(timeInterval: timerUpdateFrequency, target: self, selector: #selector(timerTick(_:)), userInfo: nil, repeats: true)
        
        for _ in 1...numberOfStars {
            let randomX = randomNumber(range: 0 ... frame.size.width)
            let randomY = randomNumber(range: 0 ... frame.size.height)

            let randomSpeed = randomNumber(range: 5 ... 50)
            let star = Star(origin: CGPoint(x: randomX, y: randomY), speed: randomSpeed)
            addSubview(star)
            stars.append(star)
        }
    }
    
    func restart() {
        tickTimer.invalidate()
        tickTimer = nil
        for star in stars {
            star.removeFromSuperview()
        }
        stars.removeAll()
        prepare()
    }
    
    func randomNumber(range: ClosedRange<CGFloat> = 1...6) -> CGFloat {
        let min = range.lowerBound
        let max = range.upperBound
        return CGFloat(arc4random_uniform(UInt32(1 + max - min))) + min
    }
    
    @objc
    func timerTick(_ timer: TimeInterval) {
        for star in stars {
            star.updatePosition(direction: direction)
        }
        
        let invalidStars = stars.filter { !$0.isContained(in: self) }
        for star in invalidStars {
            var randomX = randomNumber(range: 0 ... frame.size.width)
            var randomY = randomNumber(range: 0 ... frame.size.height)
            switch direction {
            case .up:
                randomY = 0.0
            case .down:
                randomY = frame.size.height
            case .left:
                randomX = frame.size.width
            case .right:
                randomX = 0.0
            }
            let randomSpeed = randomNumber(range: 5 ... 50)
            star.updateValues(CGPoint(x: randomX, y: randomY), speed: randomSpeed)
        }
    }
    
//    override func performKeyEquivalent(with event: NSEvent) -> Bool {
//        return true
//    }
}
