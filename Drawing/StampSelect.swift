//
//  StampSelect.swift
//  Drawing
//
//  Created by 坂本葉 on 2015/06/25.
//  Copyright (c) 2015年 YoSakamoto. All rights reserved.
//

import UIKit

class StampSelect: UIImageView {
    
    //描画
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.superview?.bringSubviewToFront(self)
        
    }
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let x = touch.locationInView(self.superview).x - touch.previousLocationInView(self.superview).x
        let y = touch.locationInView(self.superview).y - touch.previousLocationInView(self.superview).y
        self.center = CGPointMake(self.center.x + x, self.center.y + y)
    }
    
    
}
