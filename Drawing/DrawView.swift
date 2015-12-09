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
    
    
    var bezierPath: UIBezierPath!
    var undoStack: NSMutableArray!
    var redoStack: NSMutableArray!

    
    func viewWillAppear(animated: Bool) {
        undoStack = NSMutableArray()
        redoStack = NSMutableArray()
    }

    
    
    //初期化
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    //描画
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = (touches.first!)
        lastPoint = touch.locationInView(self)
        
        bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = CGLineCap.Round
        bezierPath.lineWidth = 1.0
        bezierPath.moveToPoint(lastPoint)
    }
        
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        var newPoint = touch.locationInView(self)
        
        
        lines.append(Line(start: lastPoint , end: newPoint, color: drawColor))
        lastPoint = newPoint
        
        self.setNeedsDisplay()
        
        
        if bezierPath == nil {
            return
        }
        bezierPath.addLineToPoint(lastPoint)
        drawLine(bezierPath)

    }
    
    //描画設定
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextSetLineCap(context, CGLineCap.Round)//線を滑らかにする
        CGContextSetLineWidth(context, 10)
        
        for line in lines {
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, line.stratX, line.stratY)
            CGContextAddLineToPoint(context, line.endX, line.endY)
            CGContextSetStrokeColorWithColor(context, line.color.CGColor)
            CGContextStrokePath(context)
        }
    }
    
    
    func drawLine(path:UIBezierPath) {
        
        
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
