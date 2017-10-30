//
//  AddDiaryViewController.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/27.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import UIKit
import Firebase

class AddDiaryViewController: UIViewController {

    @IBOutlet weak var customAlertView: UIView!
    
    @IBOutlet weak var diaryTitleTextField: UITextField!
    
    @IBOutlet weak var addUsersButton: UIButton!
    
    @IBOutlet weak var chooseDiaryTypeButton: UIButton!
    
    @IBOutlet weak var createDiaryButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createDiaryButton.addTarget(self, action: #selector(createDiary), for: .touchUpInside)
        
    }
    
    @objc func createDiary() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            
            //Todo: Error handling
            
            return
            
        }
        
        // userName come from facebook or google
        
        let user = User(name: "aa", uid: uid)
        
        let diary = Diary(title: diaryTitleTextField.text!, users: [user], diaryId: nil)
        
        let manager = DiaryManager()
        
        manager.delegate = self.parent as? DiaryManagerDelegate
        
        manager.diary(diaryRouter: FirebaseRouter.addDiary(diary))
        
    }
    
    deinit {
        print("addDiary Deinit")
    }

    



}
