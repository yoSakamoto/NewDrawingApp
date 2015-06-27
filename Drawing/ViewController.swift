//
//  ViewController.swift
//  Drawing
//
//  Created by 坂本葉 on 2015/06/19.
//  Copyright (c) 2015年 YoSakamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate {
    
    //描画エリア
    @IBOutlet var drawViewArea : DrawView!
    
    @IBOutlet var mainImageView :UIImageView!
    
    @IBOutlet var canvasView : UIView!
    
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //線色変換
    @IBAction func colorTapped(button:UIButton) {
        var theDrawView = drawViewArea
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
    
    
    
    //クリア機能
    @IBAction func clearTapped() {
        var theDrawView = drawViewArea
        theDrawView.lines = []
        theDrawView.setNeedsDisplay()
        mainImageView.image = nil
        
    }
    
    
    //カメラ機能
    @IBAction func cameraTapped() {
        let controller = UIImagePickerController();
        controller.delegate = self
        controller.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(controller, animated:true, completion:nil)
    }
    
    
    //ライブラリから画像を読み込む
    @IBAction func setImage() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if picker.sourceType == .PhotoLibrary {
            self.mainImageView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        } else if picker.sourceType == .Camera {
            self.mainImageView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    //スタンプ機能
    @IBAction func stampTapped() {
        self.performSegueWithIdentifier("ToStampList", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if appDelegate.isNewStamAdded == true {
            let stamp = appDelegate.StampArray.last!
            stamp.frame = CGRectMake(0, 0, 100, 100)
            stamp.center = canvasView.center
            stamp.userInteractionEnabled = true
            canvasView.addSubview(stamp)
            appDelegate.isNewStamAdded = false
        }
    }
    
    @IBAction func deleteTapped() {
        if canvasView.subviews.count > 1 {
            let lastStamp = canvasView.subviews.last! as AnyObject as! StampSelect
            lastStamp.removeFromSuperview()
            
            if let index = find(appDelegate.StampArray, lastStamp) {
                appDelegate.StampArray.removeAtIndex(index)
            }
        }
        
    }
    //Save機能
    @IBAction func saveTapped() {
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, canvasView.opaque, 0.0)
        
        canvasView.layer.renderInContext(UIGraphicsGetCurrentContext())
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
    }
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        let saveAlert = UIAlertView()
        saveAlert.title = "保存しますか？"
        saveAlert.addButtonWithTitle("OK")
        saveAlert.show()
    }
    
}

