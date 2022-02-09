//
//  RCYyEmojiPreviewVC.swift
//  RCYmRepeatCombo
//
//  Created by Joe on 2022/1/6.
//


import UIKit
import NoticeObserveKit
import ZKProgressHUD


class RCYyEmojiPreviewVC: UIViewController {
    private var pool = Notice.ObserverPool()
    var collection: UICollectionView!
    let topCoinLabel = UILabel()
    let backBtn = UIButton(type: .custom)
    var topBanner: UIView = UIView()
    let coinAlertView = RCYyCoinAlertV()
    var currentItem: RCYEmojiItem?
    
    
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

extension RCYyEmojiPreviewVC {
    func setupView() {
        
        view.backgroundColor(UIColor(hexString: "#FFF483")!)
        view.clipsToBounds()
        
        // collection
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .white
        collection.layer.masksToBounds = true
        collection.delegate = self
        collection.dataSource = self
//        collection.bounces = false
        view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.snp.top).offset(0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        collection.register(cellWithClass: RCYyEmojiPreviewCell.self)
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        //
        let topBannerMaskV = UIView()
        topBannerMaskV.backgroundColor(UIColor(hexString: "#FFF483")!)
            .adhere(toSuperview: view)
        topBannerMaskV.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        //
        let collectionTopV = UIView()
        collectionTopV
            .adhere(toSuperview: collection)
        collectionTopV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 290)
        collection.addSubview(collectionTopV)
         
        
        //
        let bgImgV = UIImageView()
        bgImgV.image("editor_bg2")
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: collectionTopV)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(UIScreen.width * (640/750))
        }
        
        //
        let topBanner = UIView()
        topBanner
            .backgroundColor(UIColor(hexString: "#FFF483")!)
            .adhere(toSuperview: view)
        topBanner.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(44)
        }
        //
        
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
        coinBgV.backgroundColor(.white)
            .adhere(toSuperview: topBanner)
            
        coinBgV.addTarget(self, action: #selector(coinBgVClick(sender: )), for: .touchUpInside)
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
        let topTitleLabel1 = UILabel()
        topTitleLabel1.fontName(20, "Avenir-Heavy")
            .color(UIColor.black.withAlphaComponent(0.7))
            .text("Emoji combo")
            .adhere(toSuperview: collectionTopV)
        topTitleLabel1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(collectionTopV.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        let topTitleLabe2 = UILabel()
        topTitleLabe2.fontName(16, "Avenir-Light")
            .color(UIColor(hexString: "#D2C53C")!)
            .text("Comment must-have emoji")
            .adhere(toSuperview: collectionTopV)
        topTitleLabe2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topTitleLabel1.snp.bottom).offset(4)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        
        
        
        
    }
    
    @objc func coinBgVClick(sender: UIButton) {
        self.navigationController?.pushViewController(RCYyStoreVC(), animated: true)
    }
    
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
     
    func copyAction(itemStr: String) {
        UIPasteboard.general.string = itemStr
        ZKProgressHUD.showSuccess("Copy successfully!", maskStyle: nil, onlyOnceFont: nil, autoDismissDelay: 1.5, completion: nil)
    }
    
}

extension RCYyEmojiPreviewVC {
    
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
                        self.copyAction(itemStr: self.currentItem?.title1 ?? "")
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

extension RCYyEmojiPreviewVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: RCYyEmojiPreviewCell.self, for: indexPath)
        let item = RCYiymDataManager.default.emojiList[indexPath.item]
        cell.titleLabel1.text = item.title1
        cell.titleLabel2.text = item.title2
        if indexPath.item <= 0 {
            cell.proImgV.isHidden = true
        } else {
            cell.proImgV.isHidden = false
        }
        cell.contentView.layer.cornerRadius = 16
        cell.contentView.layer.masksToBounds = true
        cell.contentView.backgroundColor(UIColor(hexString: RCYiymDataManager.default.nextColorStr()) ?? UIColor.white)
        cell.currentItem = item
        cell.copyBtnClickBlock = {
            [weak self] item in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.currentItem = item
                if indexPath.item <= 0 {
                    self.copyAction(itemStr: item?.title1 ?? "")
                } else {
                    self.showUnlockcoinAlertView()
                }
            }
        }
        
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RCYiymDataManager.default.emojiList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension RCYyEmojiPreviewVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let left: CGFloat = 24
        
        let cellwidth: CGFloat = UIScreen.main.bounds.width - (left * 2)
        let cellHeight: CGFloat = 80
        
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let cellwidth: CGFloat = 343
//        let left: CGFloat = (UIScreen.main.bounds.width - cellwidth - 1) / 2
        
        
        return UIEdgeInsets(top: 60, left: 0, bottom: 24, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        let cellwidth: CGFloat ÷reen.main.bounds.width - cellwidth - 1) / 2
        return 15 //left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15 //left
    }
    
//    referenceSizeForHeaderInSection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: UIScreen.width, height: 290)
//        return CGSize(width: UIScreen.width, height: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath)
            
            return view
        }
        return UICollectionReusableView()
    }
    
}

extension RCYyEmojiPreviewVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let item = BCiymDataManager.default.emojiList[indexPath.item]
//        currentItem = item
//        if indexPath.item <= 1 {
//            copyAction(itemStr: item.title1 ?? "")
//        } else {
//            showUnlockcoinAlertView()
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
     
    
}

class RCYyEmojiPreviewCell: UICollectionViewCell {
    
    let titleLabel1 = UILabel()
    let titleLabel2 = UILabel()
    let copyBtn = UIButton()
    let proImgV = UIImageView()
    var copyBtnClickBlock: ((RCYEmojiItem?)->Void)?
    var currentItem: RCYEmojiItem?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        //
        titleLabel1.adhere(toSuperview: contentView)
            .color(UIColor.black.withAlphaComponent(0.7))
            .fontName(16, "Avenir-Medium")
        titleLabel1.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.centerY).offset(-2)
            $0.left.equalTo(contentView.snp.left).offset(24)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        titleLabel2.adhere(toSuperview: contentView)
            .color(UIColor.black.withAlphaComponent(0.3))
            .fontName(16, "Avenir-Medium")
        titleLabel2.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.centerY).offset(2)
            $0.left.equalTo(contentView.snp.left).offset(24)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        copyBtn.backgroundColor(UIColor.white)
            .title("Copy")
            .font(16, "Avenir-Bold")
            .titleColor(UIColor.black.withAlphaComponent(0.7))
            .adhere(toSuperview: contentView)
        copyBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(contentView.snp.right).offset(-24)
            $0.width.equalTo(88)
            $0.height.equalTo(40)
        }
//        copyBtn.isUserInteractionEnabled = false
        copyBtn.layer.cornerRadius = 20
        copyBtn.addTarget(self, action: #selector(copyBtnClick(sender: )), for: .touchUpInside)
        //
        proImgV.image("all_coin_small")
            .adhere(toSuperview: contentView)
        proImgV.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalTo(copyBtn.snp.top).offset(-4)
            $0.right.equalTo(copyBtn.snp.right).offset(4)
        }
        
        
        
        
    }
    @objc func copyBtnClick(sender: UIButton) {
        copyBtnClickBlock?(currentItem)
    }
}









