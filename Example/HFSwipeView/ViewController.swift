//
//  ViewController.swift
//  HFSwipeView
//
//  Created by DragonCherry on 07/16/2016.
//  Copyright (c) 2016 DragonCherry. All rights reserved.
//

import UIKit
import HFCore
import HFSwipeView

class ViewController: UIViewController {
    
    // sample item count for two swipe view
    private let sampleCount: Int = 7
    private let kFullTag: Int = 100
    private let kMultiTag: Int = 101
    
    // where multi swipe view will be placed
    private var multiItemSize: CGSize {
        return CGSize(width: self.view.width / 3.5, height: 50)
    }
    private var multiViewRect: CGRect {
        return CGRectMake(0, 20, self.view.width, 50)
    }
    
    // where full swipe view will be placed
    private var fullViewRect: CGRect {
        return CGRectMake(
            0,
            multiViewRect.origin.y + multiViewRect.height,
            self.view.width,
            self.view.height - (multiViewRect.origin.y + multiViewRect.height))
    }
    private var fullItemSize: CGSize {
        return CGSize(width: self.view.width, height: fullViewRect.height)
    }
    
    private var swipeViewMulti: HFSwipeView? = nil
    private var swipeViewFull: HFSwipeView? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.automaticallyAdjustsScrollViewInsets = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeViewMulti = HFSwipeView(frame: multiViewRect)
        swipeViewMulti!.autoAlignEnabled = true
        swipeViewMulti!.circulating = true
        swipeViewMulti!.dataSource = self
        swipeViewMulti!.delegate = self
        swipeViewMulti!.tag = kMultiTag
        swipeViewMulti!.recycleEnabled = true
        swipeViewMulti!.pageControlHidden = true
        swipeViewMulti!.setBorder(0.5, color: UIColor.blackColor())
        swipeViewMulti!.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.swipeViewMulti!)
        
        swipeViewFull = HFSwipeView(frame: fullViewRect)
        swipeViewFull!.autoAlignEnabled = true
        swipeViewFull!.circulating = true
        swipeViewFull!.dataSource = self
        swipeViewFull!.delegate = self
        swipeViewFull!.tag = kFullTag
        swipeViewFull!.recycleEnabled = true
        swipeViewFull!.currentPageIndicatorTintColor = UIColor.blackColor()
        swipeViewFull!.pageIndicatorTintColor = UIColor.lightGrayColor()
        swipeViewFull!.setBorder(0.5, color: UIColor.blackColor())
        swipeViewFull!.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.swipeViewFull!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.swipeViewFull!.frame = fullViewRect
        self.swipeViewMulti!.frame = multiViewRect
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - HFSwipeViewDataSource
extension ViewController: HFSwipeViewDataSource {
    func swipeViewItemDistance(swipeView: HFSwipeView) -> CGFloat {
        return 0
    }
    func swipeViewItemSize(swipeView: HFSwipeView) -> CGSize {
        if swipeView.tag == kMultiTag {
            return multiItemSize
        } else {
            return fullItemSize
        }
    }
    func swipeViewItemCount(swipeView: HFSwipeView) -> Int {
        return sampleCount
    }
    func swipeView(swipeView: HFSwipeView, viewForIndexPath indexPath: NSIndexPath) -> UIView {
        
        var view: UIView!
        switch swipeView.tag {
        case kFullTag:
            let fullLabel = UILabel(frame: CGRect(origin: CGPointZero, size: fullItemSize))
            fullLabel.text = "\(indexPath.row)"
            fullLabel.textAlignment = .Center
            view = fullLabel
        case kMultiTag:
            let contentLabel = UILabel(frame: CGRect(origin: CGPointZero, size: multiItemSize))
            contentLabel.text = "\(indexPath.row)"
            contentLabel.textAlignment = .Center
            view = contentLabel
        default:
            assertionFailure("unknown tag: \(swipeView.tag)")
        }
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        return view
    }
    func swipeView(swipeView: HFSwipeView, needUpdateViewForIndexPath indexPath: NSIndexPath, view: UIView) {
        if let label = view as? UILabel {
            label.text = "\(indexPath.row)"
            label.setBorder(0.5, color: UIColor.blackColor())
        } else {
            assertionFailure("failed to retrieve button for index: \(indexPath.row)")
        }
    }
}


// MARK: - HFSwipeViewDelegate
extension ViewController: HFSwipeViewDelegate {
    func swipeView(swipeView: HFSwipeView, didFinishScrollAtIndexPath indexPath: NSIndexPath) {
        NSLog("\(#function): HFSwipeView(\(swipeView.tag)) -> \(indexPath.row)")
    }
    
    func swipeView(swipeView: HFSwipeView, didSelectItemAtPath indexPath: NSIndexPath) {
        NSLog("\(#function): HFSwipeView(\(swipeView.tag)) -> \(indexPath.row)")
    }
    
    func swipeView(swipeView: HFSwipeView, didChangeIndexPath indexPath: NSIndexPath) {
        NSLog("\(#function): HFSwipeView(\(swipeView.tag)) -> \(indexPath.row)")
    }
}