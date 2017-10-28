//
//  DiaryManager.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/28.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation

protocol DiaryManagerDelegate: class {
    
    func manager(_ manager: DiaryManager, type: String, ifSuccess: Bool)
    
}



class DiaryManager {
    
    weak var delegate: DiaryManagerDelegate?
    
    
    func diary(diaryRouter: FirebaseRouter) {
        
        switch diaryRouter {
            
        case .addDiary:
            
            let client = AddDiaryClient()
            
            client.addDiary(ref: diaryRouter.ref, completion: { (ifSuccess, type) in
                
                
                self.delegate?.manager(self, type: type, ifSuccess: ifSuccess)
                
                
            })
            

            
        }
        
        
        
    }
    
    

    
    
    
    
    
    
}
