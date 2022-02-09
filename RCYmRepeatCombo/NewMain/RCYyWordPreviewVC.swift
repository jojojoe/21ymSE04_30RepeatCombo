//
//  RCYyWordPreviewVC.swift
//  RCYmRepeatCombo
//
//  Created by Joe on 2022/1/6.
//

import UIKit
import NoticeObserveKit
import ZKProgressHUD


class RCYyWordPreviewVC: UIViewController {
    private var pool = Notice.ObserverPool()
    var collection: UICollectionView!
    let topCoinLabel = UILabel()
    let backBtn = UIButton(type: .custom)
    var topBanner: UIView = UIView()
    
    
    
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
                
            }
        }
        .invalidated(by: pool)
        
    }

}

extension RCYyWordPreviewVC {
    func setupView() {
        
        view.backgroundColor(UIColor(hexString: "#FFFFFF")!)
        view.clipsToBounds()
        
        
        
        // collection
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
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
        collection.register(cellWithClass: RCYyWordPreviewCell.self)
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        
        //
        
        //
        let topBannerMaskV = UIView()
        topBannerMaskV.backgroundColor(UIColor(hexString: "#FDCDFF")!)
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
        bgImgV.image("editor_bg1")
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: collectionTopV)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(UIScreen.width * (640/750))
        }
        
        //
        let topBanner = UIView()
        topBanner
            .backgroundColor(UIColor(hexString: "#FDCDFF")!)
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
            .text("Repeat words")
            .adhere(toSuperview: collectionTopV)
        topTitleLabel1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(collectionTopV.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        let topTitleLabe2 = UILabel()
        topTitleLabe2.fontName(16, "Avenir-Light")
            .color(UIColor(hexString: "#D994DC")!)
            .text("Crazy words burst")
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
     
   
}


extension RCYyWordPreviewVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: RCYyWordPreviewCell.self, for: indexPath)
        let contentStr = RCYiymDataManager.default.repeatWordsList[indexPath.item]
        cell.iconBgV.backgroundColor(UIColor(hexString: RCYiymDataManager.default.nextColorStr()) ?? UIColor.white)
        
        let fiStr = "\(String(contentStr[contentStr.startIndex]))"
        cell.iconLabel.text(fiStr)
        cell.titleLabel1.text(contentStr)
        let centerStr = "\(String(contentStr[contentStr.index(contentStr.startIndex, offsetBy: 1)]))"
        let afterStr = contentStr.newSubstring(from: 2)
        let repeatStr = "\(fiStr)\(centerStr)\(centerStr)\(centerStr)\(centerStr)\(centerStr)\(centerStr)\(centerStr)\(afterStr)"
        cell.titleLabel2.text(repeatStr)
        
        if indexPath.item == 0 {
            cell.arrowImgV.isHidden = false
            cell.proImgV.isHidden = true
        } else {
            cell.arrowImgV.isHidden = true
            cell.proImgV.isHidden = false
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RCYiymDataManager.default.repeatWordsList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension RCYyWordPreviewVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellwidth: CGFloat = UIScreen.main.bounds.width
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

extension RCYyWordPreviewVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = RCYiymDataManager.default.repeatWordsList[indexPath.item]
        var pro: Bool = true
        if indexPath.item == 0 {
            pro = false
        }
        let vc = RCYyWordEditVC(contentStr: item, isPro: pro)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
     
    
}

class RCYyWordPreviewCell: UICollectionViewCell {
    let iconLabel = UILabel()
    let iconBgV = UIView()
    let titleLabel1 = UILabel()
    let titleLabel2 = UILabel()
    let arrowImgV = UIImageView()
    let proImgV = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        iconBgV
            .adhere(toSuperview: contentView)
        iconBgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(24)
            $0.width.height.equalTo(80)
        }
        iconBgV.layer.cornerRadius = 16
        //
        iconLabel.adhere(toSuperview: iconBgV)
            .fontName(32, "AvenirNext-Bold")
            .color(.white)
        iconLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        titleLabel1.adhere(toSuperview: contentView)
            .color(UIColor.black.withAlphaComponent(0.7))
            .fontName(20, "Avenir-Medium")
        titleLabel1.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.centerY).offset(-2)
            $0.left.equalTo(iconBgV.snp.right).offset(16)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        titleLabel2.adhere(toSuperview: contentView)
            .color(UIColor.black.withAlphaComponent(0.3))
            .fontName(16, "Avenir-Medium")
        titleLabel2.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.centerY).offset(2)
            $0.left.equalTo(iconBgV.snp.right).offset(16)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        arrowImgV.image("all_arrow_right")
            .adhere(toSuperview: contentView)
        arrowImgV.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-24)
        }
        
        //
        proImgV.image("editor_pro")
            .adhere(toSuperview: contentView)
        proImgV.snp.makeConstraints {
            $0.width.equalTo(128/2)
            $0.height.equalTo(64/2)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-24)
        }
        
        
        
        
    }
}









