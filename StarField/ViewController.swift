//
//  ViewController.swift
//  StarField
//
//  Created by Peter Bødskov on 12/08/2018.
//  Copyright © 2018 Peter Bødskov. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var starFieldView: StarFieldView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        starFieldView = StarFieldView()
        starFieldView.frame = view.bounds
        view.addSubview(starFieldView)
        starFieldView.prepare()
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            if self.ownKeyDown(with: $0) {
                return nil
            } else {
                return $0
            }
        }
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        starFieldView.restart()
    }
    
    func ownKeyDown(with event: NSEvent) -> Bool {
        let keyCode = event.keyCode
        switch keyCode {
        case 123:
            starFieldView.direction = .left
            return true
        case 124:
            starFieldView.direction = .right
            return true
        case 125:
            starFieldView.direction = .down
            return true
        case 126:
            starFieldView.direction = .up
            return true
        default:
            return false
        }
    }
}

