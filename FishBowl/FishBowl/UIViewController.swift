//  UIViewController.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-11-02.
//  Copyright © 2015 Adam Dahan. All rights reserved.

import UIKit

extension UIViewController {
    /*
    @name   displayContentController
    @param  content View controller to be displayed as child
    */
    func displayContentController(_ content: UIViewController, frame: CGRect?) {
        addChildViewController(content)
        content.view.frame = frame == nil ? view.bounds : frame!
        view.addSubview(content.view)
        content.didMove(toParentViewController: self)
    }

    /*
    @name   hideContentController
    @param  content View controller to be removed as child
    */
    func hideContentController(_ content: UIViewController) {
        content.willMove(toParentViewController: nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
}
