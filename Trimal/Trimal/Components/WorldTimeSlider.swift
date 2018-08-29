//
// Created by Hongfei on 2018/8/28.
// Copyr?ight (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeSlider: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    var slider: UICollectionView!
    var showDatePickerIcon = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .gray

        self.slider = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.slider.backgroundColor = .yellow
        self.addSubview(self.slider)

        self.showDatePickerIcon.backgroundColor = .blue
        self.addSubview(self.showDatePickerIcon)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.showDatePickerIcon.pin.right().marginRight(5).vertically().width(40)
        self.slider.pin.vertically().left(pin.safeArea).before(of: self.showDatePickerIcon).marginRight(5)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
