//
//  DiaryCollectionViewCell.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/11.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var diaryOwnerTableView: UITableView!
    
    @IBOutlet weak var diaryOwnerTableViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var diaryTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("awake")
        
    }

}
