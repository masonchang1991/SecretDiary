//
//  LineLayout.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/23.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import UIKit

class LineLayout: UICollectionViewFlowLayout {
    
    var itemW: CGFloat = UIScreen.main.bounds.width
    var itemH: CGFloat = UIScreen.main.bounds.height / 2
    
    lazy var inset: CGFloat = {

        return  (self.collectionView?.bounds.width ?? 0) * 0.5 - self.itemSize.width * 0.5
    
    }()

    override init() {
        super.init()
        
        //設置每個元素的大小
        self.itemSize = CGSize(width: itemW, height: itemH)
        //設置滾動方向
        self.scrollDirection = UICollectionViewScrollDirection.horizontal
        //設定間距
        
        self.minimumLineSpacing = 100.0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Apple 推健將佈局的準備操作放在這裡
    override func prepare() {
        //設置邊距(讓第一張圖片與最後一張圖片出現在最中央）
        self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset)
        
        //調整collectionview滑動速度
        self.collectionView!.decelerationRate = UIScrollViewDecelerationRateNormal
        
    }

    //邊界發生改變就會重新佈局
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        //取出rect範圍內所有的UICollectionViewLayoutAttributes
        //不需關心這個範圍內所有cell的佈局,我們做動畫是做給人看的
        //只需關注在螢幕上可見的那些cell的rect即可
        let array = super.layoutAttributesForElements(in: rect)

        //可見矩陣
        let visibleRect = CGRect(x: self.collectionView!.contentOffset.x,
                                 y: self.collectionView!.contentOffset.y,
                                 width: self.collectionView!.frame.width,
                                 height: self.collectionView!.frame.height)

        //接下來的計算是為了動畫效果
        let maxCenterMargin = self.collectionView!.bounds.width * 0.5 + itemW * 0.5
        //獲得collectionView中央的x值(顯示在屏幕中央的x)
        let centerX = self.collectionView!.contentOffset.x + self.collectionView!.frame.size.width * 0.5

        for attributes in array! {
            //如果不在屏幕上就跳過
            if !visibleRect.intersects(attributes.frame) {continue}

            let scale = 0.65 + (0.35 - 0.35 * (abs(centerX - attributes.center.x) / maxCenterMargin))

            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)

        }

        return array

    }
    
    //用來設置collectionView停止滾動那一刻的位置
    //proposedContentOffset = 原本collectionView停止滾動那一刻的位置
    //velocity = 滾動速度
    //returns = 最終停留的位置

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        //實作這個方法的目的是，當停止滑動時，這個時間點會有一張圖片是位於螢幕最中央的。

        let lastRect = CGRect(x: proposedContentOffset.x,
                              y: proposedContentOffset.y,
                              width: self.collectionView!.frame.width,
                              height: self.collectionView!.frame.height)

        //取得collectionView中央的x值(顯示在螢幕中央的Ｘ)
        let centerX = proposedContentOffset.x + self.collectionView!.frame.width * 0.5
        //這個範圍內所有的屬性
        let array = self.layoutAttributesForElements(in: lastRect)

        //需要移動的距離
        var adjustOffsetX = CGFloat(MAXFLOAT)

        for attributes in array! {

            if abs(attributes.center.x - centerX) < abs(adjustOffsetX) {

                adjustOffsetX = attributes.center.x - centerX

            }

        }

        return CGPoint(x: proposedContentOffset.x + adjustOffsetX,
                       y: proposedContentOffset.y)

    }
    
}
