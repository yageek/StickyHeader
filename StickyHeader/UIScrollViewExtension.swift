//
//  UIScrollViewExtension.swift
//  StickyHeader
//
//  Created by Yannick Heinrich on 25.08.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import UIKit
import ObjectiveC

private var xoStickyHeaderKey: UInt8 = 0

public extension UIScrollView {

    public var stickyHeader: StickyHeader! {

        get {

            var header = objc_getAssociatedObject(self, &xoStickyHeaderKey) as? StickyHeader

            if header == nil {
                header = StickyHeader()
                header!.scrollView = self
                objc_setAssociatedObject(self, &xoStickyHeaderKey, header, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }

            return header!
        }

    }
}
