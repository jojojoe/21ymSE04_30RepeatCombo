//
//  RCYyMainVC.swift
//  RCYmRepeatCombo
//
//  Created by Joe on 2022/1/5.
//

import UIKit
import SnapKit
import DeviceKit


class RCYyMainVC: UIViewController {

    let coinStoreLabel2 = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        AFlyerLibManage.event_LaunchApp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coinStoreLabel2.text("You have \(RCYymCoinManagr.default.coinCount) coins")
    }
 
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
     
}

extension RCYyMainVC {
    func setupView() {
        view.backgroundColor(.white)
        //
        let topLabel = UILabel()
        topLabel.fontName(23, "Avenir-Medium")
            .color(.black)
            .text("Words Repeat & Emoji Combo")
            .textAlignment(.left)
            .adhere(toSuperview: view)
        topLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalToSuperview().offset(24)
            $0.width.height.greaterThanOrEqualTo(36)
        }
        //
        let settingBtn = UIButton()
        settingBtn.image(UIImage(named: "homepage_menu"))
            .adhere(toSuperview: view)
        settingBtn.snp.makeConstraints {
            $0.centerY.equalTo(topLabel.snp.centerY)
            $0.right.equalToSuperview().offset(-12)
            $0.width.height.equalTo(44)
        }
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender: )), for: .touchUpInside)
        //
        let repeatWordBtn = UIButton()
        repeatWordBtn
//            .image(UIImage(named: "homepage_bg1"))
            .backgroundImage(UIImage(named: "homepage_bg1"))
            .adhere(toSuperview: view)
        repeatWordBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topLabel.snp.bottom).offset(30)
            $0.width.equalTo((UIScreen.width - 24 * 2))
            $0.height.equalTo((176/327) * (UIScreen.width - 24 * 2))
        }
        repeatWordBtn.addTarget(self, action: #selector(repeatWordBtnClick(sender: )), for: .touchUpInside)
        let repeatWordLabel1 = UILabel()
        repeatWordLabel1.fontName(20, "Avenir-Medium")
            .color(UIColor.black.withAlphaComponent(0.7))
            .text("Repeat words")
            .textAlignment(.left)
            .adhere(toSuperview: view)
        repeatWordLabel1.snp.makeConstraints {
            $0.top.equalTo(repeatWordBtn.snp.top).offset(32)
            $0.left.equalTo(repeatWordBtn.snp.left).offset(164)
            $0.width.height.greaterThanOrEqualTo(30)
        }
        let repeatWordLabel2 = UILabel()
        repeatWordLabel2.fontName(16, "Avenir-Light")
            .color(UIColor(hexString: "#D994DC")!)
            .text("Crazy words burst")
            .textAlignment(.left)
            .adhere(toSuperview: view)
        repeatWordLabel2.snp.makeConstraints {
            $0.top.equalTo(repeatWordLabel1.snp.bottom).offset(4)
            $0.left.equalTo(repeatWordBtn.snp.left).offset(164)
            $0.width.height.greaterThanOrEqualTo(30)
        }
        
        //
        let emojiBtn = UIButton()
//        emojiBtn.image(UIImage(named: "homepage_bg2"))
            .backgroundImage(UIImage(named: "homepage_bg2"))
            .adhere(toSuperview: view)
        emojiBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            
            if Device.current.diagonal == 4.7 || Device.current.diagonal >= 6.9 {
                $0.top.equalTo(repeatWordBtn.snp.bottom).offset(-25)
            } else {
                $0.top.equalTo(repeatWordBtn.snp.bottom).offset(-25)
            }
            $0.width.equalTo((UIScreen.width - 24 * 2))
            $0.height.equalTo((232/327) * (UIScreen.width - 24 * 2))
//            $0.width.equalTo(327)
//            $0.height.equalTo(232)
        }
        emojiBtn.addTarget(self, action: #selector(emojiComboBtnClick(sender: )), for: .touchUpInside)
        let emojiLabel1 = UILabel()
        emojiLabel1.fontName(20, "Avenir-Medium")
            .color(UIColor.black.withAlphaComponent(0.7))
            .text("Emoji combo")
            .textAlignment(.left)
            .adhere(toSuperview: view)
        emojiLabel1.snp.makeConstraints {
            $0.top.equalTo(emojiBtn.snp.top).offset(88)
            $0.left.equalTo(emojiBtn.snp.left).offset(32)
            $0.width.height.greaterThanOrEqualTo(30)
        }
        let emojiLabel2 = UILabel()
        emojiLabel2.fontName(16, "Avenir-Light")
            .color(UIColor(hexString: "#D2C53C")!)
            .text("Comment must-have\nemoji")
            .numberOfLines(2)
            .textAlignment(.left)
            .adhere(toSuperview: view)
        emojiLabel2.snp.makeConstraints {
            $0.top.equalTo(emojiLabel1.snp.bottom).offset(4)
            $0.left.equalTo(emojiBtn.snp.left).offset(32)
            $0.width.height.greaterThanOrEqualTo(30)
        }
        //
        let coinStoreBtn = UIButton()
        coinStoreBtn
            .backgroundImage(UIImage(named: "homepage_bg3"))
//            .image()
            .adhere(toSuperview: view)
        coinStoreBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            
            if Device.current.diagonal == 4.7 || Device.current.diagonal >= 6.9 {
                $0.top.equalTo(emojiBtn.snp.bottom).offset(-28)
            } else {
                $0.top.equalTo(emojiBtn.snp.bottom).offset(-28)
            }
            $0.width.equalTo((UIScreen.width - 24 * 2))
            $0.height.equalTo((176/327) * (UIScreen.width - 24 * 2))
//            $0.width.equalTo(327)
//            $0.height.equalTo(232)
        }
        coinStoreBtn.addTarget(self, action: #selector(coinStoreBtnClick(sender: )), for: .touchUpInside)
        let coinStoreLabel1 = UILabel()
        coinStoreLabel1.fontName(20, "Avenir-Medium")
            .color(UIColor.black.withAlphaComponent(0.7))
            .text("Coin store")
            .textAlignment(.left)
            .adhere(toSuperview: view)
        coinStoreLabel1.snp.makeConstraints {
            $0.top.equalTo(coinStoreBtn.snp.top).offset(91)
            $0.left.equalTo(coinStoreBtn.snp.left).offset(188)
            $0.width.height.greaterThanOrEqualTo(30)
        }
        
        coinStoreLabel2.fontName(16, "Avenir-Light")
            .color(UIColor(hexString: "#EB9D99")!)
            .text("You have \(RCYymCoinManagr.default.coinCount) coins")
            .textAlignment(.left)
            .adhere(toSuperview: view)
        coinStoreLabel2.snp.makeConstraints {
            $0.top.equalTo(coinStoreLabel1.snp.bottom).offset(4)
            $0.left.equalTo(coinStoreBtn.snp.left).offset(188)
            $0.width.height.greaterThanOrEqualTo(30)
        }
        
        
    }
    
    
}

extension RCYyMainVC {
    @objc func settingBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(RCYySettingVC(), animated: true)
    }
    @objc func repeatWordBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(RCYyWordPreviewVC(), animated: true)
        
    }
    @objc func emojiComboBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(RCYyEmojiPreviewVC(), animated: true)
    }
    @objc func coinStoreBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(RCYyStoreVC(), animated: true)
    }
}

extension RCYyMainVC {
    
}

extension RCYyMainVC {
    
}

