//
//  RCYyStoreVC.swift
//  RCYmRepeatCombo
//
//  Created by Joe on 2022/1/6.
//

import UIKit
import NoticeObserveKit
import ZKProgressHUD

class RCYyStoreVC: UIViewController {
    private var pool = Notice.ObserverPool()
    let topCoinLabel = UILabel()
    var collection: UICollectionView!
    let backBtn = UIButton(type: .custom)
    var topBanner: UIView = UIView()
//    let collectionTopV = UIView()
    let topTitleLabe2 = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
                self.topTitleLabe2.text("You have \(RCYymCoinManagr.default.coinCount) coins")
            }
        }
        .invalidated(by: pool)
        
    }

}

extension RCYyStoreVC {
    func setupView() {
        
        view.backgroundColor(UIColor(hexString: "#FFCDCB")!)
        
         
        view.clipsToBounds()
        //
//        let topBgV = UIView()
//        topBgV.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: 280)
//        topBgV.backgroundColor(UIColor(hexString: "#FF6A00")!)
//            .adhere(toSuperview: view)
//        topBgV.roundCorners([.bottomLeft, .bottomRight], radius: 24)
        
        
        
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
        collection.register(cellWithClass: RCYymStoreCell.self)
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        //
        let topBannerMaskV = UIView()
        topBannerMaskV.backgroundColor(UIColor(hexString: "#FFCDCB")!)
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
        bgImgV.image("store_bg")
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: collectionTopV)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(UIScreen.width * (640/750))
        }
        
        //
        let topBanner = UIView()
        topBanner
            .backgroundColor(UIColor(hexString: "#FFCDCB")!)
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
        
        let coinBgV = UIView()
        coinBgV.backgroundColor(.white)
            .adhere(toSuperview: topBanner)
        
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
            .text("Coin store")
            .adhere(toSuperview: collectionTopV)
        topTitleLabel1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(collectionTopV.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        
        topTitleLabe2.fontName(16, "Avenir-Light")
            .color(UIColor(hexString: "#EB9D99")!)
            .text("Coin store")
            .adhere(toSuperview: collectionTopV)
        topTitleLabe2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topTitleLabel1.snp.bottom).offset(4)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        topTitleLabe2.text("You have \(RCYymCoinManagr.default.coinCount) coins")
        //
        
        
        
    }
    
}

extension RCYyStoreVC {
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
}



extension RCYyStoreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: RCYymStoreCell.self, for: indexPath)
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        let item = RCYymCoinManagr.default.coinIpaItemList[indexPath.item]
        cell.coinCountLabel.text = "\(item.coin)"
        if let localPrice = item.localPrice {
            cell.priceLabel.text = item.localPrice
        } else {
            cell.priceLabel.text = "$\(item.price)"
//            let str = "$\(item.price)"
//            let att = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.font : UIFont(name: "MarkerFelt-Wide", size: 16) ?? UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.black])
//            let ran1 = str.range(of: "$")
//            let ran1n = "".nsRange(from: ran1!)
//            att.addAttributes([NSAttributedString.Key.font : UIFont(name: "MarkerFelt-Wide", size: 32) ?? UIFont.systemFont(ofSize: 16)], range: ran1n)
//            cell.priceLabel.attributedText = att
            
        }
        
        let colorStr = RCYiymDataManager.default.nextColorStr()
        cell.contentView.backgroundColor(UIColor(hexString: colorStr) ?? UIColor.white)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RCYymCoinManagr.default.coinIpaItemList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension RCYyStoreVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let left: CGFloat = 24
        let padding: CGFloat = 16
        
        let cellwidth: CGFloat = (UIScreen.main.bounds.width - left * 2 - padding - 1) / 2
        let cellHeight: CGFloat = 208
        
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let cellwidth: CGFloat = 343
//        let left: CGFloat = (UIScreen.main.bounds.width - cellwidth - 1) / 2
        
        
        return UIEdgeInsets(top: 60, left: 24, bottom: 50, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        let cellwidth: CGFloat ÷reen.main.bounds.width - cellwidth - 1) / 2
        return 15 //left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellwidth: CGFloat = 343
        let left: CGFloat = (UIScreen.main.bounds.width - cellwidth - 1) / 2
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

extension RCYyStoreVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = RCYymCoinManagr.default.coinIpaItemList[safe: indexPath.item] {
            selectCoinItem(item: item)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func selectCoinItem(item: InCyStoreItem) {
        // core
        
        RCyPurchaseManagerLink.default.purchaseIapId(item: item) { (success, errorString) in
            
            if success {
                ZKProgressHUD.showSuccess("Purchase successful.")
            } else {
                ZKProgressHUD.showError("Purchase failed.")
            }
        }
    }
    
}

class RCYymStoreCell: UICollectionViewCell {
    
    var bgView: UIView = UIView()
    
    var iconImageV: UIImageView = UIImageView()
    var coverImageV: UIImageView = UIImageView()
    var coinCountLabel: UILabel = UILabel()
    var priceLabel: UILabel = UILabel()
    var priceBgImgV: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        backgroundColor =  UIColor.white.withAlphaComponent(0.15)
        let bgImgV = UIImageView()
        bgImgV.image("all_coin")
            .adhere(toSuperview: contentView)
        bgImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(28)
            $0.width.height.equalTo(64)
        }
        
//        layer.cornerRadius = 12
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.black.cgColor
        //
//        iconImageV.backgroundColor = .clear
//        iconImageV.contentMode = .scaleAspectFit
//        iconImageV.image = UIImage(named: "coins_big_pic")
//        contentView.addSubview(iconImageV)
//        iconImageV.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.left.equalTo(contentView.snp.left).offset(34)
//            $0.width.equalTo(64)
//            $0.height.equalTo(64)
//
//        }
         
        //
        coinCountLabel.adjustsFontSizeToFitWidth = true
        coinCountLabel
            .color(UIColor(hexString: "#FFFFFF")!)
            .numberOfLines(1)
            .fontName(20, "Avenir-Light")
            .textAlignment(.center)
            .adhere(toSuperview: contentView)
        coinCountLabel.snp.makeConstraints {
            $0.top.equalTo(bgImgV.snp.bottom).offset(4)
            $0.centerX.equalTo(bgImgV.snp.centerX)
            $0.width.height.greaterThanOrEqualTo(28)
        }
        
        let priceBgV = UIView()
        priceBgV
            .backgroundColor(UIColor(hexString: "#FFFFFF")!)
            .adhere(toSuperview: contentView)
        priceBgV.layer.cornerRadius = 20
        //
        priceBgImgV.image("")
            .adhere(toSuperview: priceBgV)
        priceBgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(priceBgV)
        }
        //
        priceLabel.textColor = UIColor.black.withAlphaComponent(0.7)
        priceLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        priceLabel.textAlignment = .center
        contentView.addSubview(priceLabel)
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.snp.makeConstraints {
            $0.centerX.equalTo(bgImgV.snp.centerX)
            $0.bottom.equalToSuperview().offset(-26)
            $0.height.greaterThanOrEqualTo(40)
            $0.width.greaterThanOrEqualTo(50)
        }
        
        priceBgV.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.top).offset(0)
            $0.left.equalTo(priceLabel.snp.left).offset(-15)
            $0.bottom.equalTo(priceLabel.snp.bottom).offset(0)
            $0.right.equalTo(priceLabel.snp.right).offset(15)
        }
        
        
        
    }
     
}





