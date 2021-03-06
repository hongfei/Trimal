//
// Created by Hongfei on 2018/8/28.
// Cop?yr?ight (c) 201?8 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeSlider: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    public static let HEIGHT = CGFloat(60)
    public static let TIME_SLOT_COUNT = 481
    var currentTime: Date = Date()
    var calendar: Calendar = DateUtil.calendar
    var currentOffset: CGFloat = 0
    var inDragging: Bool = false

    var slider: UICollectionView!
    var centerRedLine: UILabel = UILabel()

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

        self.slider = UICollectionView(frame: frame, collectionViewLayout: WorldTimeSliderLayout())
        self.slider.dataSource = self
        self.slider.delegate = self
        self.slider.showsHorizontalScrollIndicator = false
        self.slider.register(WorldTimeSliderCell.self, forCellWithReuseIdentifier: "WorldTimeSliderCell")
        self.slider.backgroundColor = .clear
        self.addSubview(self.slider)

        self.centerRedLine.backgroundColor = .red
        self.addSubview(self.centerRedLine)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.centerRedLine.pin.vertically().marginTop(2).marginBottom(2).hCenter().width(2)
        self.slider.pin.horizontally().vCenter().height(40)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WorldTimeSlider.TIME_SLOT_COUNT
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorldTimeSliderCell", for: indexPath) as? WorldTimeSliderCell {
            let currentHour = self.calendar.component(.hour, from: self.currentTime)
            let hour = (currentHour + indexPath.row % 24) % 24
            cell.loadViewData(hour: String(hour))
            return cell
        }
        return UICollectionViewCell()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.inDragging {
            return
        }
        let seconds = (scrollView.contentOffset.x - self.currentOffset) / WorldTimeSliderLayout.SLOT_WIDTH * 3600
        if let newTime = self.calendar.date(byAdding: .second, value: Int(seconds), to: self.currentTime) {
            TimeCenterService.publishNewTime(time: newTime)
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.inDragging = true
        TimeCenterService.toggleTimer(disableTimer: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.inDragging = false
        let seconds = (scrollView.contentOffset.x - self.currentOffset) / WorldTimeSliderLayout.SLOT_WIDTH * 3600
        if let newTime = self.calendar.date(byAdding: .second, value: Int(seconds), to: self.currentTime) {
            if abs(newTime.timeIntervalSince(self.currentTime)) < 20 {
                TimeCenterService.toggleTimer(disableTimer: false)
            } else {
                TimeCenterService.toggleTimer(disableTimer: true)
            }
        }
    }

    func loadViewData(timezone: UserTimeZone, time: Date) {
        self.currentTime = Date()
        self.calendar.timeZone = timezone.timezone
        self.slider.reloadData()
        self.currentOffset = DateUtil.timeToOffset(minutes: self.calendar.component(.minute, from: self.currentTime))
        self.slider.contentOffset.x = self.currentOffset + CGFloat(time.timeIntervalSince(self.currentTime)) / 3600 * WorldTimeSliderLayout.SLOT_WIDTH
    }
}

class WorldTimeSliderLayout: UICollectionViewFlowLayout {
    public static let SLOT_WIDTH = CGFloat(100)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init() {
        super.init()

        self.itemSize = CGSize(width: WorldTimeSliderLayout.SLOT_WIDTH, height: 40)
        self.scrollDirection = .horizontal
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
    }
}
