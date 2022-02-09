//
//  RCYyWordEditVC.swift
//  RCYmRepeatCombo
//
//  Created by Joe on 2022/1/6.
//

import UIKit
import ZKProgressHUD
import NoticeObserveKit

class RCYyWordEditVC: UIViewController {
    private var pool = Notice.ObserverPool()
    var contentStr: String
    var isPro: Bool
    let topCoinLabel = UILabel()
    let textPreviewTextV = UITextView()
    var currentLetter: String?
    var currentRepeatNumber: String?
    let vipImgV = UIImageView()
    
    let coinAlertView = RCYyCoinAlertV()
    
    let whichLetterCollection = RCYyEditCollectionV(frame: .zero, contentList: ["1", "2", "3", "4", "All"], mainColor: "#FDCDFF")
    let numberRepeatCollection = RCYyEditCollectionV(frame: .zero, contentList: ["2", "4", "6", "8", "10"], mainColor: "#FFCDCB")
    
    init(contentStr: String, isPro: Bool) {
        self.contentStr = contentStr
        self.isPro = isPro
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupCoinAlertView()
        addNotificationObserver()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addNotificationObserver() {
        
        NotificationCenter.default.nok.observe(name: .pi_noti_coinChange) {[weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.topCoinLabel.text = ( "\(RCYymCoinManagr.default.coinCount)")
            }
        }
        .invalidated(by: pool)
        
    }
}


extension RCYyWordEditVC {
    
    func setupCoinAlertView() {
        
        coinAlertView.alpha = 0
        view.addSubview(coinAlertView)
        coinAlertView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        
    }

    func showUnlockcoinAlertView() {
        // show coin alert
        
        self.view.bringSubviewToFront(self.coinAlertView)
        
        UIView.animate(withDuration: 0.35) {
            self.coinAlertView.alpha = 1
        }
        
        coinAlertView.okBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            
            if RCYymCoinManagr.default.coinCount >= RCYymCoinManagr.default.coinCostCount {
                DispatchQueue.main.async {
                     
                    RCYymCoinManagr.default.costCoin(coin: RCYymCoinManagr.default.coinCostCount)
                    DispatchQueue.main.async {
                        self.copyAction(itemStr: self.textPreviewTextV.text)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: "Insufficient Coins, please buy first.", buttonTitles: ["OK"], highlightedButtonIndex: 0) { i in
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let `self` = self else {return}
                            self.navigationController?.pushViewController(RCYyStoreVC(), animated: true)
                        }
                    }
                }
            }

            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            } completion: { finished in
                if finished {
                    
                }
            }
        }
         
        
        coinAlertView.backBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            } completion: { finished in
                if finished {
                    
                }
            }
        }
        
    }
    
}

extension RCYyWordEditVC {
    func setupView() {
        view.backgroundColor(.white)
        //
        let topBanner = UIView()
        topBanner
            .backgroundColor(UIColor.clear)
            .adhere(toSuperview: view)
        topBanner.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(44)
        }
        //
        let backBtn = UIButton()
        backBtn
            .image(UIImage(named: "all_arrow_left"))
            .adhere(toSuperview: topBanner)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        backBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.equalTo(10)
            $0.width.equalTo(44)
            $0.height.equalTo(44)
        }
  
        //
        
        let coinBgV = UIButton()
        coinBgV.backgroundColor(UIColor(hexString: "#FFF483")!)
            .adhere(toSuperview: topBanner)
            
        coinBgV.addTarget(self, action: #selector(topCoinBtnClick(sender: )), for: .touchUpInside)
        //
        topCoinLabel
            .fontName(16, "Avenir-Medium")
            .color(UIColor.black.withAlphaComponent(0.7))
            .adhere(toSuperview: topBanner)
        topCoinLabel.text = ( "\(RCYymCoinManagr.default.coinCount)")
        topCoinLabel.snp.makeConstraints {
            $0.centerY.equalTo(backBtn.snp.centerY)
            $0.right.equalToSuperview().offset(-45)
            $0.width.greaterThanOrEqualTo(1)
            $0.height.equalTo(35)
        }
        //
        let topCoinImgV = UIImageView()
        topCoinImgV
            .image("all_coin_small")
            .adhere(toSuperview: topBanner)
        topCoinImgV.snp.makeConstraints {
            $0.centerY.equalTo(topCoinLabel.snp.centerY)
            $0.right.equalTo(topCoinLabel.snp.left).offset(-4)
            $0.width.greaterThanOrEqualTo(24)
            $0.height.greaterThanOrEqualTo(24)
        }
        
        //
        coinBgV.snp.makeConstraints {
            $0.centerY.equalTo(topCoinLabel.snp.centerY)
            $0.right.equalTo(topCoinLabel.snp.right).offset(18)
            $0.left.equalTo(topCoinImgV.snp.left).offset(-18)
            $0.height.equalTo(40)
        }
        coinBgV.layer.cornerRadius = 20
        
        //
        let textPreviewBgV = UIView()
        textPreviewBgV.backgroundColor(UIColor(hexString: "#F4F4F4")!)
            .adhere(toSuperview: view)
        
        textPreviewBgV.layer.cornerRadius = 16
        textPreviewBgV.layer.masksToBounds = true
        //
        
        textPreviewTextV
            .backgroundColor(.clear)
            .adhere(toSuperview: textPreviewBgV)
        textPreviewTextV.snp.makeConstraints {
            $0.left.top.equalTo(24)
            $0.center.equalToSuperview()
        }
        textPreviewTextV.font = UIFont(name: "Avenir-Light", size: 20)
        textPreviewTextV.textColor = UIColor.black.withAlphaComponent(0.7)
        textPreviewTextV.isEditable = false
        textPreviewTextV.text = contentStr
        //
        
        //--------
        
        let generateBtn = UIButton()
        generateBtn.backgroundColor(UIColor(hexString: "#FFF483")!)
            .title("Generate")
            .titleColor(UIColor.black.withAlphaComponent(0.7))
            .font(20, "Avenir-Heavy")
            .adhere(toSuperview: view)
        generateBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            $0.left.equalTo(24)
            $0.height.equalTo(64)
            $0.width.equalToSuperview().offset(-160)
        }
        generateBtn.layer.cornerRadius = 64/2
        generateBtn.addTarget(self, action: #selector(generateBtnClick(sender: )), for: .touchUpInside)
        
        //
        let cpyBtn = UIButton()
        cpyBtn.backgroundColor(UIColor(hexString: "#FDCDFF")!)
            .title("Copy")
            .titleColor(UIColor.black.withAlphaComponent(0.7))
            .font(20, "Avenir-Heavy")
            .adhere(toSuperview: view)
        cpyBtn.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-24)
            $0.left.equalTo(generateBtn.snp.right).offset(8)
            $0.height.equalTo(64)
            $0.centerY.equalTo(generateBtn.snp.centerY)
        }
        cpyBtn.layer.cornerRadius = 64/2
        cpyBtn.addTarget(self, action: #selector(cpyBtnClick(sender:)), for: .touchUpInside)
        //
        
        vipImgV.image("all_coin_small")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: view)
        vipImgV.snp.makeConstraints {
            $0.top.equalTo(cpyBtn.snp.top)
            $0.right.equalTo(cpyBtn.snp.right)
            $0.width.height.equalTo(24)
        }
        if isPro == true {
            vipImgV.isHidden = false
        } else {
            vipImgV.isHidden = true
        }
        
        //
        let restAllBtn = UIButton()
        restAllBtn.image(UIImage(named: "editor_refresh"))
            .title("Reset all settings")
            .titleColor(UIColor.black.withAlphaComponent(0.5))
            .adhere(toSuperview: view)
        restAllBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(generateBtn.snp.top).offset(-40)
            $0.height.equalTo(44)
        }
        restAllBtn.addTarget(self, action: #selector(restAllBtnClick(sender: )), for: .touchUpInside)
        
        
        //
        let whichLetterLabel = UILabel()
        whichLetterLabel.fontName(16, "Avenir-Light")
            .color(UIColor.black.withAlphaComponent(0.7))
            .text("Which letter")
            .adhere(toSuperview: view)
        whichLetterLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.bottom.equalTo(restAllBtn.snp.top).offset(-220)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        
        whichLetterCollection.adhere(toSuperview: view)
        whichLetterCollection.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(whichLetterLabel.snp.bottom).offset(8)
            $0.height.equalTo(70)
        }
        whichLetterCollection.didSelectItemBlock = {
            [weak self] itemStr in
            guard let `self` = self else {return}
            self.currentLetter = itemStr
        }
        
        
        //
        let numberRepeatLabel = UILabel()
        numberRepeatLabel.fontName(16, "Avenir-Light")
            .color(UIColor.black.withAlphaComponent(0.7))
            .text("Number of repeat")
            .adhere(toSuperview: view)
        numberRepeatLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.top.equalTo(whichLetterLabel.snp.bottom).offset(100)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        
        numberRepeatCollection.adhere(toSuperview: view)
        numberRepeatCollection.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(numberRepeatLabel.snp.bottom).offset(8)
            $0.height.equalTo(70)
        }
        numberRepeatCollection.didSelectItemBlock = {
            [weak self] itemStr in
            guard let `self` = self else {return}
            self.currentRepeatNumber = itemStr
            
        }
        
        
        textPreviewBgV.snp.makeConstraints {
            $0.left.equalTo(24)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backBtn.snp.bottom).offset(10)
            $0.bottom.equalTo(whichLetterLabel.snp.top).offset(-40)
        }
        
        
    }
    
    
}

extension RCYyWordEditVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
     
    @objc func topCoinBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(RCYyStoreVC(), animated: true)
    }
    
    @objc func generateBtnClick(sender: UIButton) {
        if currentLetter == nil || currentRepeatNumber == nil {
            ZKProgressHUD.showMessage("Please select a letter or number of repetitions first.", maskStyle: nil, onlyOnceFont: nil, autoDismissDelay: 1.5, completion: nil)
            
            
        } else {
            if let letter = currentLetter, let numberInt = currentRepeatNumber?.int {
                if let letterInt = letter.int {
                    let leftStr = contentStr.prefix(letterInt - 1)
                    debugPrint("leftStr = \(leftStr)")
                    
                    let centerStr = "\(String(contentStr[contentStr.index(contentStr.index(from: letterInt - 1), offsetBy: 0)]))"
                    debugPrint("centerStr = \(centerStr)")
                    
                    let rightStr = contentStr.newSubstring(from: letterInt)
                    debugPrint("rightStr = \(rightStr)")
                    
                    var repeatStr = ""
                    for _ in 0...(numberInt - 1) {
                        repeatStr += centerStr
                    }
                    debugPrint("repeatStr = \(repeatStr)")
                    let comStr: String = leftStr + repeatStr + rightStr
                    //
                    self.textPreviewTextV.text = comStr
                    
                } else {
                    var comStr: String = ""
                    
                    for subChar in contentStr.charactersArray {
                        var item: String = ""
                        
                        for _ in 0...(numberInt - 1) {
                            item += String(subChar)
                        }
                        comStr += item
                    }
                    self.textPreviewTextV.text = comStr
                }
            }
        }
    }
    
    @objc func cpyBtnClick(sender: UIButton) {
        if isPro == true {
            showUnlockcoinAlertView()
        } else {
            copyAction(itemStr: self.textPreviewTextV.text)
        }
        
    }
    
    @objc func restAllBtnClick(sender: UIButton) {
        self.textPreviewTextV.text = contentStr
        currentLetter = nil
        currentRepeatNumber = nil
        whichLetterCollection.currentItem = nil
        numberRepeatCollection.currentItem = nil
        whichLetterCollection.collection.reloadData()
        numberRepeatCollection.collection.reloadData()
    }
    
    func copyAction(itemStr: String) {
        UIPasteboard.general.string = itemStr
        ZKProgressHUD.showSuccess("Copy successfully!", maskStyle: nil, onlyOnceFont: nil, autoDismissDelay: 1.5, completion: nil)
    }
    
    
}







