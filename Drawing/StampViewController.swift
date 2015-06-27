//
//  StampViewController.swift
//  Drawing
//
//  Created by 坂本葉 on 2015/06/21.
//  Copyright (c) 2015年 YoSakamoto. All rights reserved.
//

import UIKit

class StampViewController: UIViewController {
    
    //imageArray[UIImage]
    var imageArray:[UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 1...10 {
            imageArray.append(UIImage(named: "\(i).png")!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //スタンプ表示(CollectionView)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var Cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
        let imageView = Cell.viewWithTag(1) as! UIImageView
        imageView.image = imageArray[indexPath.row]
        return Cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let stamp = StampSelect()
        stamp.image = imageArray[indexPath.row]
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.StampArray.append(stamp)
        appDelegate.isNewStamAdded = true
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func backTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
}
