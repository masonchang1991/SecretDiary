//
//  LoginView.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import UIKit

class LoginView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var fbLoginButton: UIButton!
    
    @IBOutlet weak var googleLoginButton: UIButton!
    
    @IBOutlet weak var phoneLoginButton: UIButton!
    
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var fbLoginButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var googleLoginButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var phoneLoginButtonTopConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubView()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubView()
        
    }
    
    func initSubView() {
        
        let view = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.first as! UIView

        view.frame = self.bounds
        self.addSubview(view)
        
        titleLabelTopConstraint.constant = view.bounds.size.height * 30 / 667
        fbLoginButtonTopConstraint.constant = view.bounds.size.height * 50 / 667
        googleLoginButtonTopConstraint.constant = view.bounds.size.height * 30 / 667
        phoneLoginButtonTopConstraint.constant = view.bounds.size.height * 30 / 667

        contentView.frame = bounds
        contentView.backgroundColor = UIColor.white
        
    }
    

}
