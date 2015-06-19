//
//  ViewController.swift
//  Drawing
//
//  Created by 坂本葉 on 2015/06/19.
//  Copyright (c) 2015年 YoSakamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //描画エリア
    @IBOutlet var drawViewArea : DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //クリアボタンをタップされた時
    @IBAction func clearTapped() {
        var theDrawView = drawViewArea as DrawView
        theDrawView.lines = []
        theDrawView.setNeedsDisplay()
        
    }
    
    //線色変換
    @IBAction func colorTapped(button:UIButton) {
        var theDrawView = drawViewArea as DrawView
        var color: UIColor!
        if (button.titleLabel?.text == "Red") {
            color = UIColor.redColor()
        } else if (button.titleLabel?.text == "Black") {
            color = UIColor.blackColor()
        } else if (button.titleLabel?.text == "Blue") {
            color = UIColor.blueColor()
        } else if (button.titleLabel?.text == "Green") {
            color = UIColor.greenColor()
        } else if (button.titleLabel?.text == "Yellow"){
            color = UIColor.yellowColor()
        }
        theDrawView.drawColor = color
        
        
    }
    
}

