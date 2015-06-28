//
//  DrawView.swift
//  Drawing
//
//  Created by 坂本葉 on 2015/06/19.
//  Copyright (c) 2015年 YoSakamoto. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lines: [Line] = []
    var lastPoint: CGPoint!
    var drawColor = UIColor.blackColor()
    
    
    //初期化
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    //描画
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        lastPoint = touch.locationInView(self)
        
        
        
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        var newPoint = touch.locationInView(self)
        
        
        lines.append(Line(start: lastPoint , end: newPoint, color: drawColor))
        lastPoint = newPoint
        
        self.setNeedsDisplay()
    }
    
    //描画設定
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextSetLineCap(context, kCGLineCapRound)//線を滑らかにする
        CGContextSetLineWidth(context, 5)
        
        for line in lines {
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, line.stratX, line.stratY)
            CGContextAddLineToPoint(context, line.endX, line.endY)
            CGContextSetStrokeColorWithColor(context, line.color.CGColor)
            CGContextStrokePath(context)
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
