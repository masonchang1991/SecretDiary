//
//  DiaryMenuViewController.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/11.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import UIKit

class DiaryMenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private let cellIdentifier = "DiaryCell"
    
    private var diarys: [Diary] = []
    
    @IBOutlet weak var diaryMenuCollectionView: UICollectionView! {
        
        didSet {
            
            self.diaryMenuCollectionView.register(DiaryCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
            self.diaryMenuCollectionView.collectionViewLayout = LineLayout()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.diaryMenuCollectionView.delegate = self
        
        self.diaryMenuCollectionView.dataSource = self

        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let diaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DiaryCollectionViewCell
        
        diaryCell.backgroundColor = UIColor.blue
        
        return diaryCell
        
        
    }

    


    
    

}
