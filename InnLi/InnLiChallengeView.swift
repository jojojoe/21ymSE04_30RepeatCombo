//
//  InnLiChallengeView.swift
//  REpeatCom
//
//  Created by comre on 2022/01/05.
//  Copyright © 2022 REpeat. All rights reserved.
//
import UIKit

class InnLiChallengeView: UIView {

    @IBOutlet weak var emailBtn:UIButton!
    @IBOutlet weak var mobileBtn:UIButton!
    @IBOutlet weak var sendBtn:UIButton!
    @IBOutlet weak var tipLab:UILabel!
    @IBOutlet weak var emailHeight:NSLayoutConstraint!
    @IBOutlet weak var mobileHeight:NSLayoutConstraint!
    @IBOutlet weak var mobileTop:NSLayoutConstraint!

    var emailClick:(()->())?
    var mobileClick:(()->())?
    var sendActionClick:((_ type:String?)->())?
    var closeClick:(()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = true
        self.emailBtn.isSelected = true
    }
    
    @IBAction func emailAction(_ sender:Any){
        self.emailBtn.isSelected = true
        self.mobileBtn.isSelected = false
        self.emailClick?()
    }

    @IBAction func mobileAction(_ sender:Any){
        self.emailBtn.isSelected = false
        self.mobileBtn.isSelected = true
        self.mobileClick?()
    }

    @IBAction func sendAction(_ sender:Any) {
        self.sendActionClick?(self.emailBtn.isSelected ? "1" : "0");
    }
    
    @IBAction func closeAction(_ sender:Any){
        self.closeClick?()
    }
}
