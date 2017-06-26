//
//  UICollectionView+Pagination.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/26/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

protocol UICollectionViewPaginationDelegate{
    func requestItemForPages(pageSet:NSSet) -> Void
    func hasItemInPage(pageNo:Int) -> Bool
}

class UICollectionView_Pagination: UICollectionView {
    var totalItemCount:Int!
    var pageSize:Int!
    var paginationDelegate:UICollectionViewPaginationDelegate?
    var paginationEnabled:Bool!
    private var shouldTrackScrollingVelocity:Bool!
    private var lastContentOffset:Float!
    private var lastOffsetCapturedTime:TimeInterval!
    
    required override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize() -> Void{
        totalItemCount = 0
        pageSize = 0
        paginationEnabled = false
        shouldTrackScrollingVelocity = false
        lastOffsetCapturedTime = 0
        lastContentOffset = 0
    }
    
    func didScroll() -> Void {
        if !paginationEnabled{
            return
        }
        let distance = fabsf(Float(self.contentOffset.y) - lastContentOffset)
        
        if shouldTrackScrollingVelocity == true && self.contentOffset.y > 0{
            let currentTime = NSDate.timeIntervalSinceReferenceDate
            //To calculate velocity We are capturing the distance scrolled in 3 seconds and if distance traversed is less than 10
            //then we will make page request
            if((currentTime - lastOffsetCapturedTime) > 3) {
                if (distance < 10) {
                    shouldTrackScrollingVelocity = false;
                    self.requestPagesIfNeeded()
                }
                lastOffsetCapturedTime = currentTime;
            }
        }
        lastContentOffset = Float(self.contentOffset.y);
    }
    
    func willBeginDragging() -> Void{
        if !paginationEnabled{
            return
        }
        shouldTrackScrollingVelocity = true
    }
    
    func endDragging(willDecelerate decelerate: Bool){
        if !paginationEnabled{
            return
        }
        if !decelerate && self.contentOffset.y > 0{
            shouldTrackScrollingVelocity = true
            self.requestPagesIfNeeded()
        }
    }
    
    func willBeginDecelerating() -> Void{
        if !paginationEnabled{
            return
        }
    }
    
    func endDecelerating() -> Void{
        if !paginationEnabled{
            return
        }
        if self.contentOffset.y > 0{
            shouldTrackScrollingVelocity = true
            self.requestPagesIfNeeded()
        }
    }
    
    private func requestPagesIfNeeded() -> Bool{
        if self.contentOffset.y <= 0 || paginationDelegate == nil{
            return false
        }
        let currentPage = self.currentVisiblePage()
        //process only if current page have something
        if Int(currentPage * Int(pageSize)) < totalItemCount{
            let pageSet = NSMutableSet()
            if paginationDelegate!.hasItemInPage(pageNo: currentPage) == false{
                pageSet.add(NSNumber(value: currentPage))
            }
            
            if Int(currentPage * Int(pageSize) + 1) <= totalItemCount{
                if paginationDelegate!.hasItemInPage(pageNo: currentPage+1) == false{
         
                    pageSet.add(NSNumber(value: currentPage+1))
                }
            }
            
            if currentPage > 0 && Int(Int(currentPage - 1) * Int(pageSize)) < totalItemCount{
                if paginationDelegate!.hasItemInPage(pageNo: currentPage-1) == false{
                    pageSet.add(NSNumber(value: currentPage-1))
                }
            }
            if pageSet.count > 0 {
                paginationDelegate!.requestItemForPages(pageSet: pageSet)
                return true
            }
        }
        return false
    }
    
    private func currentVisiblePage() -> Int{
        if !paginationEnabled{
            return 0
        }
        
        let visibleCellsIndices:[UICollectionViewCell] = self.visibleCells
        if visibleCellsIndices.count > 0{
            if let lastVisibleCellIndex = self.indexPath(for: self.visibleCells.last!){
                return self.pageNumberForItemAtRow(row: lastVisibleCellIndex.row)
            }
        }
        return 0
    }
    
    private func pageNumberForItemAtRow(row:Int) -> Int{
        if !paginationEnabled{
            return 0
        }
        
        if pageSize > 0{
            return (row / Int(pageSize!)) + 1
        }
        return 0
    }
}
