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
    
    @IBOutlet weak var addDiaryButton: UIButton!
    
    @IBOutlet weak var diaryMenuCollectionView: UICollectionView! {
        
        didSet {
            
            self.diaryMenuCollectionView.collectionViewLayout = LineLayout()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.diaryMenuCollectionView.delegate = self
        
        self.diaryMenuCollectionView.dataSource = self

        self.addDiaryButton.addTarget(self, action: #selector(showAddDiaryBox), for: .touchUpInside)
        
        let loadDiaryManager = DiaryManager()
        
        loadDiaryManager.diary(diaryRouter: FirebaseRouter.viewDiary([]))
        
        loadDiaryManager.delegate = self
        
        self.diaryMenuCollectionView.register(UINib.init(nibName: "DiaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
    }
    
    
    @objc func showAddDiaryBox() {

        
        let addDiaryVC = AddDiaryViewController(nibName: "AddDiaryViewController", bundle: nil)
        
        self.addChildViewController(addDiaryVC)
        
//        addDiaryVC.view.bounds = self.view.frame // 不work
        
        addDiaryVC.view.frame = self.view.frame // work
        
        addDiaryVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        self.view.addSubview(addDiaryVC.view)
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.diarys.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let diaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? DiaryCollectionViewCell else {
            return UICollectionViewCell()
        }

        
        diaryCell.backgroundColor = UIColor.gray
        
        diaryCell.diaryTitleLabel.text = diarys[indexPath.row].title
        
        return diaryCell
        
        
    }

    


    
    

}

extension DiaryMenuViewController: DiaryManagerDelegate {
    
    func manager(_ manager: DiaryManager, type: FirebaseRouter) {
        
        switch type {
        case .addDiary(let nonUse):
            
            self.childViewControllers[0].removeFromParentViewController()
            
            self.view.subviews[self.view.subviews.count - 1].removeFromSuperview()
            
        case .viewDiary(let diarys):
            
            self.diarys = diarys
            
            self.diaryMenuCollectionView.reloadData()
            
        }
        

        
        
    }
    
    
}
