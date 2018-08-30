//
// Created by Hongfei on 2018/8/28.
// Copyr?ight (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeSlider: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    public static let HEIGHT = CGFloat(60)

    var slider: UICollectionView!
    var showDatePickerIcon = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.backgroundColor = UIColor.lightGray.cgColor

        let shadowLayer = CAGradientLayer()
        let bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: WorldTimeSlider.HEIGHT)
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOpacity = 0.8

        let shadowSize = CGFloat(1)
        let shadowPath = CGMutablePath()
        let topShadow = CGRect(x: 0, y: 0, width: bounds.width, height: shadowSize)
        let bottomShadow = CGRect(x: 0, y: WorldTimeSlider.HEIGHT - shadowSize, width: bounds.width, height: shadowSize)

        shadowPath.addRect(topShadow)
        shadowPath.addRect(bottomShadow)
        shadowLayer.shadowPath = shadowPath
        self.layer.addSublayer(shadowLayer)
        self.clipsToBounds = true

        self.slider = UICollectionView(frame: frame, collectionViewLayout: WorldTimerSliderLayout())
        self.slider.dataSource = self
        self.slider.delegate = self
        self.slider.showsHorizontalScrollIndicator = false
        self.slider.register(WorldTimeSliderCell.self, forCellWithReuseIdentifier: "WorldTimeSliderCell")
        self.addSubview(self.slider)

        self.showDatePickerIcon.backgroundColor = .blue
        self.addSubview(self.showDatePickerIcon)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        self.showDatePickerIcon.pin.right().marginRight(5).vertically().width(40)
        self.slider.pin.horizontally().vCenter().height(40)
        self.slider.scrollToItem(at: IndexPath(item: 50, section: 0), at: .right, animated: false)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorldTimeSliderCell", for: indexPath) as? WorldTimeSliderCell {
            cell.reloadViewData(position: String(indexPath.row))
            return cell
        }
        return UICollectionViewCell()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
}

class WorldTimerSliderLayout: UICollectionViewFlowLayout {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init() {
        super.init()

        self.itemSize = CGSize(width: 100, height: 40)
        self.scrollDirection = .horizontal
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 2
    }


}