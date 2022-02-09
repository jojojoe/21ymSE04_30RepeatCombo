//
//  RCYyCoinAlertV.swift
//  RCYmRepeatCombo
//
//  Created by Joe on 2022/1/6.
//

import UIKit

class RCYyCoinAlertV: UIView {
    
    var backBtnClickBlock: (()->Void)?
    var okBtnClickBlock: (()->Void)?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func backBtnClick(sender: UIButton) {
        backBtnClickBlock?()
    }
    
    func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        //
//        var blurEffect = UIBlurEffect(style: .dark)
//        var blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.frame
//        addSubview(blurEffectView)
//        blurEffectView.snp.makeConstraints {
//            $0.left.right.top.bottom.equalToSuperview()
//        }
//
        //
        let bgBtn = UIButton(type: .custom)
        bgBtn
            .image(UIImage(named: ""))
            .adhere(toSuperview: self)
        bgBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        bgBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        let contentV = UIView()
            .backgroundColor(UIColor(hexString: "#FFF483")!)
            .adhere(toSuperview: self)
//        contentV.layer.cornerRadius = 24
        contentV.layer.masksToBounds = true
        contentV.frame = CGRect(x: 0, y: UIScreen.height - 400, width: UIScreen.width, height: 400)
        contentV.roundCorners([.topLeft], radius: 80)
//        contentV.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
//        contentV.layer.shadowOffset = CGSize(width: 0, height: 0)
//        contentV.layer.shadowRadius = 3
//        contentV.layer.shadowOpacity = 0.8
//        contentV.layer.borderWidth = 2
//        contentV.layer.borderColor = UIColor.black.cgColor
//        contentV.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.left.equalTo(60)
//            $0.height.equalTo(214)
////            $0.height.equalTo((UIScreen.width - 60 * 2) * (214/256))
//            $0.centerY.equalToSuperview()
//        }
        
        //
         
        let coinImgV = UIImageView()
            .image("all_coin_big")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: self)
        coinImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(contentV.snp.top).offset(0)
            $0.width.equalTo(112)
            $0.height.equalTo(112)
        }
        
        //
        let titLab = UILabel()
        
            .text("It costs \(RCYymCoinManagr.default.coinCostCount) coins to copy the text.")
            .textAlignment(.center)
            .numberOfLines(0)
            .fontName(18, "Avenir-Medium")
            .color(UIColor(hexString: "#000000")!.withAlphaComponent(0.7))
            .adhere(toSuperview: contentV)
        
        titLab.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(coinImgV.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(50)
            $0.height.greaterThanOrEqualTo(55)
        }
        
        //
//        let contentBgImgV = UIImageView()
//        contentBgImgV.image("popup_pro")
//            .adhere(toSuperview: contentV)
//        contentBgImgV.snp.makeConstraints {
//            $0.left.right.top.bottom.equalToSuperview()
//        }
        
//        //
//
//        let titLab2 = UILabel()
//            .text("Using paid item will cost \(LPymCoinManagr.default.coinCostCount) coins.")
//            .textAlignment(.center)
//            .numberOfLines(0)
//            .fontName(16, "AvenirNext-Regular")
//            .color(UIColor(hexString: "#454D3D")!.withAlphaComponent(0.6))
//            .adhere(toSuperview: contentV)
//
//        titLab2.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(titLab.snp.bottom).offset(10)
//            $0.left.equalToSuperview().offset(50)
//            $0.height.greaterThanOrEqualTo(1)
//        }
        
        //AvenirNext-DemiBold
        
        ///
        
        
        //
        let okBtn = UIButton()
        okBtn.layer.cornerRadius = 32
        okBtn
            .backgroundColor(UIColor(hexString: "#82F6AC")!)
            .titleColor(UIColor.black.withAlphaComponent(0.7))
            .title("OK")
            .font(20, "Avenir-Black")
            .adhere(toSuperview: contentV)
        okBtn.snp.makeConstraints {
            $0.top.equalTo(titLab.snp.bottom).offset(48)
            $0.centerX.equalToSuperview()
            $0.left.equalTo(contentV.snp.left).offset(60)
            $0.height.equalTo(64)
        }
        
        okBtn.addTarget(self, action: #selector(okBtnClick(sender:)), for: .touchUpInside)
        
        
        //
        let backBtn = UIButton()
        backBtn
            .backgroundColor(UIColor(hexString: "#FFCDCB")!)
            .titleColor(UIColor.black.withAlphaComponent(0.7))
            .title("Cancel")
            .font(20, "Avenir-Black")
            .adhere(toSuperview: contentV)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(okBtn.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.left.equalTo(contentV.snp.left).offset(60)
            $0.height.equalTo(64)
        }
        backBtn.layer.cornerRadius = 64/2
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        
        //
    }
    @objc func okBtnClick(sender: UIButton) {
        okBtnClickBlock?()
    }
    
//    @objc func editBtnClick(sender: UIButton) {
//        okBtnClickBlock?()
//    }
     
//    @objc func copyBtnClick(sender: UIButton) {
//        okBtnClickBlock?()
//    }
     
    
    
    
    
    
    
  }
