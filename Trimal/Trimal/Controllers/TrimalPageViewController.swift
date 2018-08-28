//
//  TrimalPageViewController.swift
//  Trimal
//
//  Created by Hongfei on 2018/8/27.
//  Copyright © 2018年 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class TrimalPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var worldTimeViewController = WorldTimeViewController()
    var worldAlarmViewController = WorldAlarmViewController()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String: Any]?) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self

        self.setViewControllers([self.worldTimeViewController], direction: .forward, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for view in self.view.subviews {
            if let v = view as? UIScrollView {
                v.frame = self.view.bounds
            }
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let _ = viewController as? WorldAlarmViewController {
            return self.worldTimeViewController
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let _ = viewController as? WorldTimeViewController {
            return self.worldAlarmViewController
        } else {
            return nil
        }
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
