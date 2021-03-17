//
//  ProgressHud.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import Foundation
import MBProgressHUD

class Indicator:UIViewController {

    class func shared() -> Indicator {
        struct Static {
            static let manager = Indicator()
        }
        return Static.manager
    }

    func showIndicator(withTitle title: String, and Description:String, vc:UIViewController) {
        let Indicator = MBProgressHUD.showAdded(to: vc.view, animated: true)
        Indicator.label.text = title
        Indicator.isUserInteractionEnabled = false
        Indicator.detailsLabel.text = Description
        Indicator.show(animated: true)
        UIApplication.shared.accessibilityRespondsToUserInteraction = false
    }
    func hideIndicator(vc:UIViewController) {
        MBProgressHUD.hide(for: vc.view, animated: true)
        UIApplication.shared.accessibilityRespondsToUserInteraction = true
    }
}
