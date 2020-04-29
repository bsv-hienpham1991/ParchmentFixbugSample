//
//  ViewController.swift
//  ParchmentFixbugSample
//
//  Created by Hien Pham on 4/29/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import UIKit
import Parchment
import SnapKit

class ViewController: UIViewController {
    private var viewControllers = [UIViewController]()
    private var pagingViewController: PagingViewController!
    @IBOutlet private weak var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpPagingViewController()
    }

    func setUpPagingViewController() {
        viewControllers = []
        
        for index in 0..<6 {
            let viewController: SampleViewController = SampleViewController(index: index)
            viewControllers.append(viewController)
        }

        pagingViewController = PagingViewController()

        pagingViewController.menuBackgroundColor = #colorLiteral(red: 0.9960784314, green: 0.7882352941, blue: 0, alpha: 1)
        pagingViewController.menuInsets = .zero
        let menuItemW: CGFloat = 32

        pagingViewController.selectedTextColor = .white
        pagingViewController.textColor = .black
        pagingViewController.borderOptions = .hidden
        pagingViewController.indicatorColor = #colorLiteral(red: 0.09019607843, green: 0.3333333333, blue: 0.431372549, alpha: 1)
        pagingViewController.indicatorOptions = .visible(height: 40, zIndex: -1, spacing: .zero, insets: .zero)
        pagingViewController.menuItemSize = .selfSizing(estimatedWidth: menuItemW, height: 40)
        pagingViewController.infiniteDataSource = self
        pagingViewController.select(pagingItem: PagingIndexItem(index: 0, title: viewControllers.first?.title ?? ""))

        pagingViewController.willMove(toParent: self)
        container.addSubview(pagingViewController.view)
        pagingViewController.view.frame = .init(x: 0, y: 0, width: container.frame.width, height: container.frame.height)
        pagingViewController.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addChild(pagingViewController)
        pagingViewController.didMove(toParent: self)
    }
}

extension ViewController: PagingViewControllerInfiniteDataSource {
    func viewControllerIndex(from pagingItemIndex: Int) -> Int {
        if pagingItemIndex >= 0 {
            return pagingItemIndex % viewControllers.count
        } else {
            let circleCount: Int = Int(ceil(abs(Float(pagingItemIndex)) / Float(viewControllers.count)))
            return circleCount * viewControllers.count + pagingItemIndex
        }
    }
    
    func pagingViewController(_ : PagingViewController, itemAfter pagingItem: PagingItem) -> PagingItem? {
        if let item = pagingItem as? PagingIndexItem {
            let index = item.index + 1
            let vcIndex = viewControllerIndex(from: index)
            let title = viewControllers[vcIndex].title ?? ""
            return PagingIndexItem(index: index, title: title)
        }
        return nil
    }

    func pagingViewController(_: PagingViewController, itemBefore pagingItem: PagingItem) -> PagingItem? {
        if  let item = pagingItem as? PagingIndexItem {
            let index = item.index - 1
            let vcIndex = viewControllerIndex(from: index)
            let title = viewControllers[vcIndex].title ?? ""
            return PagingIndexItem(index: index, title: title)
        }
        return nil
    }

    func pagingViewController(_: PagingViewController, viewControllerFor pagingItem: PagingItem) -> UIViewController {
        if  let item = pagingItem as? PagingIndexItem {
            let vcIndex = viewControllerIndex(from: item.index)
            let content = viewControllers[vcIndex]
            let wrapper: UIViewController = UIViewController()
            wrapper.setContentViewController(content)
            return wrapper
        }
        return UIViewController()
    }

}

extension UIViewController {
    func setContentViewController(_ content: UIViewController) {
        content.willMove(toParent: nil)
        content.view.removeFromSuperview()
        content.didMove(toParent: nil)

        view.addSubview(content.view)
        content.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        content.willMove(toParent: self)
        addChild(content)
        content.didMove(toParent: self)
    }
}
