//
//  viewDiaryClient.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/30.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation
import Firebase

class ViewDiaryClient {
    
    func getDiarys(ref: DatabaseReference, completion: @escaping (([Diary]) -> (Void))) {
        
        let uid = Auth.auth().currentUser?.uid
        
        var userRef = DatabaseReference()
        
        userRef = Database.database().reference().child("Users").child(uid!).child("Diarys")
        
        getUsersDiaryIds(userRef: userRef) { (diaryIds) -> (Void) in
            
            ref.observe(.value, with: { (snapshot) in
                
                var diarys: [Diary] = []
                
                for snapshotValue in snapshot.children {
                    
                    guard
                        let data = snapshotValue as? DataSnapshot,
                        let diary = data.value as? [String: Any],
                        let diaryId = diary["Id"] as? String else {
                            return
                    }
                    
                    if diaryIds[diaryId] != nil {
                        
                        guard let title = diary["Title"] as? String,
                            let usersDic = diary["User"] as? [String: String] else {
                         
                                return
                        }

                        var users: [User] = []
                        
                        for userDic in usersDic {
                            
                            let user = User(name: userDic.value, uid: userDic.key)
                            
                            users.append(user)
                            
                        }
                        
                        let diary = Diary(title: title,
                                          users: users,
                                          diaryId: diaryId)
                        
                        diarys.append(diary)
                        
                    }
                }
                
                ref.removeAllObservers()
                
                completion(diarys)
                
            })
            
        }
     
        
        
        
    }
    
    private func getUsersDiaryIds(userRef: DatabaseReference, completion: @escaping (([String: String]) -> (Void))) {
        
        userRef.observe(.value) { (snapshot) in
            
            var diaryIds: [String: String] = [:]
            
            for snapshotValue in snapshot.children {
                
                guard
                    let data = snapshotValue as? DataSnapshot,
                    let diaryId = data.value as? String else {
                        return
                }
                
                diaryIds[diaryId] = diaryId
                
            }
            
            userRef.removeAllObservers()
            
            completion(diaryIds)
            
        }
        
        
    }
    
    
    
    
}
