//
//  RCYyEditCollectionV.swift
//  RCYmRepeatCombo
//
//  Created by Joe on 2022/1/6.
//

import UIKit

class RCYyEditCollectionV: UIView {
    var contentList: [String]
    var mainColor: String
    var collection: UICollectionView!
    var currentItem: String?
    
    var didSelectItemBlock: ((String)->Void)?
    
    init(frame: CGRect, contentList: [String], mainColor: String) {
        self.contentList = contentList
        self.mainColor = mainColor
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
        collection.register(cellWithClass: RCYyEditSelectCell.self)
    }

}

extension RCYyEditCollectionV: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: RCYyEditSelectCell.self, for: indexPath)
        let item = contentList[indexPath.item]
        cell.nameLabel.text(item)
        cell.bgV.layer.cornerRadius = 30
        cell.bgV.backgroundColor(.white)
        cell.bgV.layer.borderColor = UIColor(hexString: mainColor)!.cgColor
        cell.bgV.layer.borderWidth = 1
        cell.selectV.backgroundColor(UIColor(hexString: mainColor)!)
        cell.selectV.layer.cornerRadius = 30
        if item == currentItem {
            cell.selectV.isHidden = false
        } else {
            cell.selectV.isHidden = true
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension RCYyEditCollectionV: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellW: CGFloat = 60
        let padding: CGFloat = 8
        let left: CGFloat = (UIScreen.width - cellW * 5 - padding * 4 - 1) / 2
        
        
        
        return UIEdgeInsets(top: 0, left: left, bottom: 0, right: left)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

extension RCYyEditCollectionV: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = contentList[indexPath.item]
        currentItem = item
        collectionView.reloadData()
        didSelectItemBlock?(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}



class RCYyEditSelectCell: UICollectionViewCell {
    let nameLabel = UILabel()
    let selectV = UIView()
    let bgV = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        bgV.adhere(toSuperview: contentView)
        bgV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(60)
        }
        //
        selectV.adhere(toSuperview: contentView)
        selectV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(60)
        }
        //
        nameLabel.adhere(toSuperview: contentView)
            .fontName(20, "Avenir-Bold")
            .color(UIColor.black.withAlphaComponent(0.7))
            .textAlignment(.center)
            .adhere(toSuperview: contentView)
        nameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.greaterThanOrEqualTo(1)
            $0.left.equalTo(8)
        }
        
        
    }
}






