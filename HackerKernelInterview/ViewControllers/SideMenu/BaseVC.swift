//
//  BaseVC.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import UIKit

class BaseVC: UIViewController, SlideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        
        switch(index){
        case 0:
            //Home
            let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 1:
            //DashBoard
            
            let vc = storyboard?.instantiateViewController(identifier: "DashboardVC") as! DashboardVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 2:
            //Logout
                let alert = UIAlertController(title: "Alert", message: "Would you like to Logout your Account?", preferredStyle: UIAlertController.Style.alert)
                
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "LoginVC") as! LoginVC
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    nav.modalTransitionStyle = .crossDissolve
                    
                    Defaults.userDefault.setValue(false, forKey: Defaults.userIsLogged)
                    Defaults.userDefault.setValue(nil, forKey: Defaults.userEmail)
                    
                    self.navigationController?.pushViewController(vc, animated: false)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
                    action in
                    
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            
            break
        default:
            print("default\n", terminator: "")
            
        }
    }
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButton.ButtonType.system)
        btnShowMenu.addTarget(self, action: #selector(BaseVC.onSlideMenuButtonPressed(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : MenuVC = self.storyboard!.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        menuVC.btnMenu = sender
        menuVC.delegate = self
        
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
        
    }
    
}
