//
//  DetailViewController.swift
//  iCanHazThumbnail
//
//  Created by Aditya Rao on 2/17/16.
//  Copyright © 2016 Aditya Rao. All rights reserved.
//

import UIKit

public class DetailViewController: UIViewController {
    
    var startIndex : Int?
    var currField : Field?
    var fieldStore : FieldStore?
    let thumbnailColors = ["#667C26", "#FFF380", "#C36241", "#9F000F", "#B93B8F"]
    
    @IBOutlet weak var  imageView : UIImageView!
    @IBOutlet weak var detailsLabel : UILabel!
    
    
    @IBAction func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.Right:
            if (self.startIndex! < self.fieldStore!.numFields() - 1) {
                self.startIndex! += 1
                self.loadFieldDetail(self.startIndex!)
            }
            
            
        case UISwipeGestureRecognizerDirection.Left:
            if (self.startIndex! > 0) {
                self.startIndex! -= 1
                self.loadFieldDetail(self.startIndex!)
            }
            
        default:
            break
        }
    }
    
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (self.startIndex == nil) {
            self.startIndex = 0
        }
        self.loadFieldDetail(self.startIndex!)
    }
    
    func loadFieldDetail(index: Int) {
        print("Loading field details for field @ index \(index)")
        self.currField = self.fieldStore?.getAllFields()[index]
        
        self.detailsLabel.text = self.currField?.name
        setThumbnail()
    }
    
    private func randomThumbnailFill() -> String {
        return thumbnailColors[Int(arc4random_uniform(UInt32(thumbnailColors.count)))]
    }
    
    func setThumbnail() -> Void {
        let thumbnailOpts = [ThumbnailOpts.height: String(Int(self.imageView.bounds.height)),
                             ThumbnailOpts.width: String(Int(self.imageView.bounds.width)),
                             ThumbnailOpts.fill: self.randomThumbnailFill()]
        self.fieldStore?.fetchThumbnailForField(self.currField!.id, thumbnailOpts: thumbnailOpts,
            onComplete: {() -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.imageView.image = self.fieldStore?.getField(self.currField!.id).thumbnail
            })
        })
    }
    
}