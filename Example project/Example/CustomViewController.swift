//
//  CustomViewController.swift
//  Example
//
//  Created by Hirohisa Kawasaki on 6/30/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit
import PageController

class CustomMenuCell: MenuCell {

    required init(frame: CGRect) {
        super.init(frame: frame)

        // NOTE: ここでメニュータブの上下左右マージンを調整する
        contentInset = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 40)
        titleLabelFont = UIFont.systemFont(ofSize: 14)
        selectedTitleLabelFont = UIFont.boldSystemFont(ofSize: 13)
        selectedTitleLabelColor = UIColor.blue
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func updateData() {
        super.updateData()

        titleLabel.font = selected ? selectedTitleLabelFont : titleLabelFont
        titleLabel.textColor = selected ? selectedTitleLabelColor : titleLabelColor

    }
    
}

class CustomViewController: PageController {

    override func viewDidLoad() {
        super.viewDidLoad()

        menuBar.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        menuBar.registerClass(CustomMenuCell.self)
        underLine.backgroundColor = UIColor.blue
        delegate = self
        viewControllers = createViewControllers()
    }

}

extension CustomViewController {

    func createViewControllers() -> [UIViewController] {
        let names = [
            "Home",
            "Innovation",
            "Technology",
            "Life",
            "Bussiness",
            "Economics",
            "Financial",
            "Market",
        ]

        let viewControllers = names.map { name -> ItemsCollectionViewController in
            let viewController = ItemsCollectionViewController()
            viewController.title = name
            viewController.collectionView?.scrollsToTop = false
            return viewController
        }

        viewControllers.first?.collectionView?.scrollsToTop = true
        return viewControllers
    }
}

extension CustomViewController: PageControllerDelegate {

    func pageController(_ pageController: PageController, didChangeVisibleController visibleViewController: UIViewController, fromViewController: UIViewController?) {
        print("now title is \(String(describing: pageController.visibleViewController?.title))")
        print("did change from \(String(describing: fromViewController?.title)) to \(String(describing: visibleViewController.title))")
        if pageController.visibleViewController == visibleViewController {
            print("visibleViewController is assigned pageController.visibleViewController")
        }

        if let viewController = fromViewController as? ItemsCollectionViewController  {
            viewController.collectionView?.scrollsToTop = false
        }
        if let viewController = visibleViewController as? ItemsCollectionViewController  {
            viewController.collectionView?.scrollsToTop = true
        }
    }
}
