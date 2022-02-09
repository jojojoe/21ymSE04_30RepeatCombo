//
//  RCYySettingVC.swift
//  RCYmRepeatCombo
//
//  Created by Joe on 2022/1/6.
//

import UIKit
import UIKit
import MessageUI
import StoreKit
import Defaults
import NoticeObserveKit

 
class RCYySettingVC: UIViewController {
    var upVC: UIViewController?
    let backBtn = UIButton(type: .custom)
    let titleLabel = UILabel(text: "Setting")
    let privacyBtn = RCYymSettingBtn()
    let termsBtn = RCYymSettingBtn()
    let feedbackBtn = RCYymSettingBtn()
    let coinLabel = UILabel()
 
    var loginBtnClickBlock: (()->Void)?
    
    
    let accountBgView = UIView()
    let coinInfoBgView = UIView()
    let userNameLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        setupView()
        setupContent()
//        updateUserAccountStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.coinLabel.text("Your coins: \(RCYymCoinManagr.default.coinCount)")
    }
     
}

extension RCYySettingVC {
    func setupView() {
        view.backgroundColor(UIColor(hexString: "#FFF483")!)
        let bgImgV1 = UIImageView()
        bgImgV1.image("setting_bg1")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: view)
        bgImgV1.snp.makeConstraints {
            $0.right.top.equalToSuperview()
            $0.width.equalTo(750/2)
            $0.height.equalTo(860/2)
            
        }
        //
        let bgImgV2 = UIImageView()
        bgImgV2.image("setting_bg2")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: view)
        bgImgV2.snp.makeConstraints {
            $0.left.bottom.equalToSuperview()
            $0.width.equalTo(750/2)
            $0.height.equalTo(360/2)
            
        }
        
        
        
        //
        view.addSubview(backBtn)
        backBtn.setImage(UIImage(named: "setting_close"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            $0.right.equalTo(-10)
            $0.width.height.equalTo(44)
        }
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        
        
//        titleLabel.font = UIFont(name: "Arial-BoldMT", size: 18)
//        titleLabel.textAlignment = .center
//        view.addSubview(titleLabel)
//        titleLabel.textColor = UIColor(hexString: "#121212")
//        titleLabel.snp.makeConstraints {
//            $0.centerY.equalTo(backBtn)
//            $0.centerX.equalToSuperview()
//            $0.height.equalTo(28)
//            $0.width.equalTo(100)
//        }
        
    }
    
    func setupContent() {
        
        // login

//        loginBtn.nameLa.text("Login account")
//        loginBtn.btn.setTitle("Log in", for: .normal)
//        view.addSubview(loginBtn)
//        loginBtn.snp.makeConstraints {
//            $0.width.equalTo(748/2 - 20)
//            $0.height.equalTo(176/2)
//            $0.right.equalToSuperview()
//            $0.top.equalTo(backBtn.snp.bottom).offset(26)
//        }
//        loginBtn.addTarget(self, action: #selector(loginBtnClick(sender:)), for: .touchUpInside)
        
        
        
        //
//        let iconIMgV = UIImageView()
//        iconIMgV.image("setting_logo")
//            .contentMode(.scaleAspectFit)
//            .adhere(toSuperview: view)
//        iconIMgV.snp.makeConstraints {
//            $0.width.height.equalTo(96)
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(backBtn.snp.bottom).offset(60)
//        }
//        let iconLabel = UILabel()
//        iconLabel.fontName(22, "BodoniSvtyTwoITCTT-Book")
//            .color(.white)
//            .text("2021 Best Comment")
//            .textAlignment(.center)
//            .adhere(toSuperview: view)
//        iconLabel.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(iconIMgV.snp.bottom).offset(16)
//            $0.width.height.greaterThanOrEqualTo(1)
//        }
//        let iconLabel2 = UILabel()
//        iconLabel2.fontName(14, "Avenir-Light")
//            .color(.white)
////            .text("- Best Comment for IG -")
//            .textAlignment(.center)
//            .adhere(toSuperview: view)
//        iconLabel2.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(iconLabel.snp.bottom).offset(2)
//            $0.width.height.greaterThanOrEqualTo(1)
//        }
//
        
        
        // feed
        
        feedbackBtn.nameLa.text("Feedback")
        feedbackBtn.iconImgV.image("setting_feed")
        view.addSubview(feedbackBtn)
        feedbackBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(72)
            $0.width.equalTo(255)
            $0.centerY.equalToSuperview()
        }
        feedbackBtn.addTarget(self, action: #selector(feedbackBtnClick(sender:)), for: .touchUpInside)
        feedbackBtn.layer.cornerRadius = 72/2
        
        
        
        // privacy
        privacyBtn.nameLa.text("Privacy Policy")
        privacyBtn.iconImgV.image("setting_privacy")
        view.addSubview(privacyBtn)
        privacyBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(72)
            $0.width.equalTo(255)
            $0.bottom.equalTo(feedbackBtn.snp.top).offset(-24)
        }
        privacyBtn.addTarget(self, action: #selector(privacyBtnClick(sender:)), for: .touchUpInside)
        privacyBtn.layer.cornerRadius = 72/2
        // terms
        
        termsBtn.nameLa.text("Terms of use")
        termsBtn.iconImgV.image("setting_term")
        view.addSubview(termsBtn)
        termsBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(72)
            $0.width.equalTo(255)
            $0.top.equalTo(feedbackBtn.snp.bottom).offset(24)
            
        }
        termsBtn.addTarget(self, action: #selector(termsBtnClick(sender:)), for: .touchUpInside)
        termsBtn.layer.cornerRadius = 72/2
        
        
        // logout
//        logoutBtn.nameLa.text("")
//        logoutBtn.btn.setTitle("Log out", for: .normal)
//        view.addSubview(logoutBtn)
//        logoutBtn.snp.makeConstraints {
//            $0.width.equalTo(748/2 - 20)
//            $0.height.equalTo(176/2)
//            $0.right.equalToSuperview()
//            $0.top.equalTo(backBtn.snp.bottom).offset(26)
//        }
//        logoutBtn.addTarget(self, action: #selector(logoutBtnClick(sender:)), for: .touchUpInside)
        
        
        
        // user name label
//        view.addSubview(userNameLabel)
//        userNameLabel.textAlignment = .center
//        userNameLabel.adjustsFontSizeToFitWidth = true
//        userNameLabel.textColor = .black
//        userNameLabel.font = UIFont(name: "Avenir-BoldMT", size: 18)
//        userNameLabel.snp.makeConstraints {
//            $0.center.equalTo(titleLabel)
//            $0.height.equalTo(40)
//            $0.left.equalTo(backBtn.snp.right).offset(10)
//        }
//
//
//        // accountBgView
//        accountBgView.backgroundColor = .clear
//        view.addSubview(accountBgView)
//        accountBgView.snp.makeConstraints {
//            $0.center.equalTo(loginBtn)
//            $0.width.equalToSuperview()
//            $0.centerX.equalToSuperview()
//
//        }
//
//        // coin info bg view
//        let topCoinLabel = UILabel()
//        topCoinLabel.textAlignment = .right
//        topCoinLabel.text = "\(InCymCoinManagr.default.coinCount)"
//        topCoinLabel.textColor = UIColor(hexString: "#2A2A2A")
//        topCoinLabel.font = UIFont(name: "PingFangSC-Semibold", size: 22)
//        accountBgView.addSubview(topCoinLabel)
//        topCoinLabel.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.centerX.equalToSuperview().offset(-28)
//            $0.height.equalTo(30)
//            $0.width.greaterThanOrEqualTo(25)
//        }
//
//        let coinImageV = UIImageView()
//        coinImageV.image = UIImage(named: "coins_icon3")
//        coinImageV.contentMode = .scaleAspectFit
//        accountBgView.addSubview(coinImageV)
//        coinImageV.snp.makeConstraints {
//            $0.centerY.equalTo(topCoinLabel)
//            $0.left.equalTo(topCoinLabel.snp.right).offset(10)
//            $0.width.height.equalTo(20)
//        }
        
    }
}

extension RCYySettingVC {
//    func updateUserAccountStatus() {
//        if let userModel = LoginManage.currentLoginUser() {
//            let userName  = userModel.userName
//            let name = (userName?.count ?? 0) > 0 ? userName : "Signed in with apple ID"
////            accountBgView.isHidden = false
//            logoutBtn.nameLa.text(name)
//            logoutBtn.isHidden = false
//            loginBtn.isHidden = true
//            userNameLabel.isHidden = false
//            titleLabel.isHidden = true
//        } else {
//            logoutBtn.nameLa.text("")
////            accountBgView.isHidden = true
//            logoutBtn.isHidden = true
//            loginBtn.isHidden = false
//            userNameLabel.isHidden = true
//            titleLabel.isHidden = false
//        }
//    }
}

extension RCYySettingVC {
    @objc func stoerBtnClick(sender: UIButton) {
//        let storeVC = FFyInStoreVC()
//        self.navigationController?.pushViewController(storeVC, animated: true)
    }
}



extension RCYySettingVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController()
        }
    }
}



extension RCYySettingVC {
    @objc func privacyBtnClick(sender: UIButton) {
        UIApplication.shared.openURL(url: PrivacyPolicyURLStr)
    }
    
    @objc func termsBtnClick(sender: UIButton) {
        UIApplication.shared.openURL(url: TermsofuseURLStr)
    }
    
    @objc func feedbackBtnClick(sender: UIButton) {
        feedback()
    }
    
//    @objc func loginBtnClick(sender: UIButton) {
//        backBtnClick(sender: backBtn)
//        if let mainVC = self.upVC as? HPymMainVC {
//            mainVC.showLoginVC()
//        }
//
//    }
//
//    @objc func logoutBtnClick(sender: UIButton) {
//        LoginManage.shared.logout()
//        updateUserAccountStatus()
//    }
    
    
     
}



extension RCYySettingVC: MFMailComposeViewControllerDelegate {
    func feedback() {
        //首先要判断设备具不具备发送邮件功能
        if MFMailComposeViewController.canSendMail(){
            //获取系统版本号
            let systemVersion = UIDevice.current.systemVersion
            let modelName = UIDevice.current.modelName
            
            let infoDic = Bundle.main.infoDictionary
            // 获取App的版本号
            let appVersion = infoDic?["CFBundleShortVersionString"] ?? "8.8.8"
            // 获取App的名称
            let appName = "\(AppName)"
            
            
            let controller = MFMailComposeViewController()
            //设置代理
            controller.mailComposeDelegate = self
            //设置主题
            controller.setSubject("\(appName) Feedback")
            //设置收件人
            // FIXME: feed back email
            controller.setToRecipients([feedbackEmail])
            //设置邮件正文内容（支持html）
            controller.setMessageBody("\n\n\nSystem Version：\(systemVersion)\n Device Name：\(modelName)\n App Name：\(appName)\n App Version：\(appVersion )", isHTML: false)
            
            //打开界面
            self.present(controller, animated: true, completion: nil)
        }else{
            HUD.error("The device doesn't support email")
        }
    }
    
    //发送邮件代理方法
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}


class HPymSettingLoginBtn: UIButton {
    
    var nameLa = UILabel()
    let btn = UIButton()
    var btnClickBlock: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let bgImgV = UIImageView()
        bgImgV
            .image("coin_bg_pic")
            .adhere(toSuperview: self)
            .contentMode(.scaleAspectFit)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        nameLa
            .fontName(18, "Avenir-Light")
            .color(.black)
            .text("Login")
            .numberOfLines(2)
            .textAlignment(.left)
            .adhere(toSuperview: self)
        nameLa.snp.makeConstraints {
            $0.left.equalTo(80)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-150)
            $0.height.greaterThanOrEqualTo(60)
        }
        
        //
        btn.isUserInteractionEnabled(false)
        btn
            .backgroundColor(UIColor(hexString: "#2FDF84")!)
            .titleColor(UIColor.white)
            .font(18, "Didot-Bold")
            .adhere(toSuperview: self)
        btn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-24)
            $0.width.equalTo(85)
            $0.height.equalTo(40)
        }
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
//        btn.addTarget(self, action: #selector(btnClick(sender: )), for: .touchUpInside)
        
        
    }
    
//    @objc func btnClick(sender: UIButton) {
//        btnClickBlock?()
//    }
    
    
}


class RCYymSettingBtn: UIButton {
    
    var iconImgV = UIImageView()
    var nameLa = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor(.white)
        
        iconImgV
//            .image("all_btn_big")
//            .backgroundColor(UIColor(hexString: "47D2FF")!)
            .adhere(toSuperview: self)
            .contentMode(.scaleAspectFit)
        iconImgV.snp.makeConstraints {
            $0.left.equalToSuperview().offset(40)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(32)
        }
        //
        nameLa
            .fontName(20, "Avenir-Medium")
            .color(UIColor.black.withAlphaComponent(0.7))
            .text("")
            .numberOfLines(2)
            .textAlignment(.left)
            .adhere(toSuperview: self)
        nameLa.snp.makeConstraints {
            $0.left.equalTo(iconImgV.snp.right).offset(16)
            $0.centerY.equalToSuperview()
            $0.height.greaterThanOrEqualTo(30)
            $0.width.greaterThanOrEqualTo(1)
        }
    }
    
    
}

