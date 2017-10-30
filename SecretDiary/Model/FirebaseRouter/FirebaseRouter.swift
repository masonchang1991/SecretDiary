//
//  FirebaseRouter.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/28.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation
import Firebase

enum FirebaseRouter {
    
    case addDiary(Diary)
    
    case viewDiary([Diary])
    
    var ref: DatabaseReference {

        switch self {

        case .addDiary :
            
            return Database.database().reference().child("Diarys")
            
        case .viewDiary:
            
            return Database.database().reference().child("Diarys")
        }

    }
    
}




