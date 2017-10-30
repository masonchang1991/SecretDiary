//
//  DiaryManager.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/28.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation

protocol DiaryManagerDelegate: class {
    
    func manager(_ manager: DiaryManager, type: FirebaseRouter)
    
    
}



class DiaryManager {
    
    weak var delegate: DiaryManagerDelegate?
    
    func diary(diaryRouter: FirebaseRouter) {
        
        switch diaryRouter {
            
        case .addDiary(let diary):
            
            let client = AddDiaryClient()
            
            client.addDiary(ref: diaryRouter.ref,
                            diary: diary,
                            completion: { () in
                
                self.delegate?.manager(self, type: diaryRouter)
                
            })
        case .viewDiary:
            
            let client = ViewDiaryClient()
            
            client.getDiarys(ref: diaryRouter.ref, completion: { (diarys) -> (Void) in
                
                let viewDiaryRouter = FirebaseRouter.viewDiary(diarys)
                
                self.delegate?.manager(self, type: viewDiaryRouter)
                                
            })
            
            
        }
        
        
        
    }
    
    

    
    
    
    
    
    
}
