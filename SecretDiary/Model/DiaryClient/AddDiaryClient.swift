//
//  AddDiaryClient.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/28.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation
import Firebase

class AddDiaryClient {
    
    func addDiary(ref: DatabaseReference, diary: Diary, completion: @escaping (() -> ())) {
        
        let diaryId = ref.childByAutoId().key
        
        var usersDic:[String: String] = [:]
        
        var diaryDic:[String: Any] = [:]
        
        for user in diary.users {
            
            let userRef = Database.database().reference()
        userRef.child("Users").child(user.uid).child("Diarys").child(diaryId).setValue(diaryId)
            
            usersDic[user.uid] = user.name
            
        }
        
        diaryDic["Title"] = diary.title
        
        diaryDic["Id"] = diaryId
        
        diaryDic["User"] = usersDic
        
        ref.child(diaryId).setValue(diaryDic)
        
        completion()
        
    }
    
}
