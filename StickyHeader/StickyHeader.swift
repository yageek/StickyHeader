//
//  StickyHeader.swift
//  StickyHeader
//
//  Created by Yannick Heinrich on 24.08.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import UIKit

/**
 The class managing the sticky header behaviour.
 */
public class StickyHeader: NSObject {

    /**
     The view containing the provided header.
    */
    private(set) lazy var contentView: StickyHeaderView = {
        let view = StickyHeaderView()
        view.parent = self
        view.clipsToBounds = true
        return view
    }()

    private weak var _scrollView: UIScrollView?

    /**
     The `UIScrollView` attached to the sticky header.
    */
    public weak var scrollView: UIScrollView? {
        get {
            return _scrollView
        }

        set {
            if _scrollView != newValue {
                _scrollView = newValue

               if let scrollView = scrollView {
                self.adjustScrollViewTopInset(top: scrollView.contentInset.top + self.height)
                    scrollView.addSubview(self.contentView)
                }

                self.layoutContentView()
            }
        }
    }

    private var _view: UIView?

    /**
     The `UIScrollView attached to the sticky header.
     */
    public var view: UIView? {
        set {
          guard newValue != _view else { return }
            _view = newValue
            updateConstraints()
        }
        get {
            return _view
        }
    }

    private var _height: CGFloat = 0

    /**
     The height of the header.
    */
    public var height: CGFloat {
        get { return _height }
        set {
            guard newValue != _height else { return }

            if let scrollView = self.scrollView {
                self.adjustScrollViewTopInset(top: scrollView.contentInset.top - height + newValue)
            }

            _height = newValue

            self.updateConstraints()
            self.layoutContentView()

        }
    }
    private var _minimumHeight: CGFloat = 0

    /**
     The minimum height of the header.
    */
    public var minimumHeight: CGFloat {
        get { return _minimumHeight }
        set {
            _minimumHeight = newValue
            layoutContentView()
        }
    }

    private func adjustScrollViewTopInset(top: CGFloat) {

        guard let scrollView = self.scrollView else { return }
        var inset = scrollView.contentInset

        //Adjust content offset
        var offset = scrollView.contentOffset
        offset.y += inset.top - top
        scrollView.contentOffset = offset

        //Adjust content inset
        inset.top = top
        scrollView.contentInset = inset

        self.scrollView = scrollView
    }
    private func updateConstraints() {
        guard let view = self.view else { return }

        view.removeFromSuperview()
        self.contentView.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v]|", options: [], metrics: nil, views: ["v": view]))

        self.contentView.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))

        self.contentView.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.height))

    }

    private func layoutContentView() {
        var relativeYOffset: CGFloat = 0

        guard let scrollView = self.scrollView else { return }

        if scrollView.contentOffset.y < -self.minimumHeight {
            relativeYOffset = -self.height
        } else {

            let compensation: CGFloat = -self.minimumHeight - scrollView.contentOffset.y
            relativeYOffset = -self.height - compensation
        }

        let frame = CGRect(x: 0, y: relativeYOffset, width: scrollView.frame.size.width, height: height)

        self.contentView.frame = frame
    }


    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let path = keyPath, context == &StickyHeaderView.KVOContext && path == "contentOffset" {
            self.layoutContentView()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

}
