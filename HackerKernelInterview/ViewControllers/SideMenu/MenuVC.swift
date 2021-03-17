//
//  MenuVC.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}


class MenuVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var btnCloseMenuOverlay : UIButton!
    
    var arrayMenuOptions = [Dictionary<String,String>]()
    var btnMenu : UIButton!
    
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        updateArrayMenu()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //navigationController?.isNavigationBarHidden = false

    }
    
    func updateArrayMenu() {
        
        arrayMenuOptions.append(["title":"Home", "icon":"Home"])
        arrayMenuOptions.append(["title":"Dashboard", "icon":"DashBoard"])
        arrayMenuOptions.append(["title":"Log Out", "icon":"Logout"])
    }
    
    @IBAction func onCloseMenuClick(_ button: UIButton!){
        
        btnMenu.tag = 0
        //navigationController?.navigationBar.isHidden = false
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
        
    }
    
}

//MARK:- Extension
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return arrayMenuOptions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: SideMenuHeaderTableViewCell.identifier, for: indexPath) as! SideMenuHeaderTableViewCell
            
            let name = Defaults.userDefault.string(forKey: Defaults.userEmail)
            cell.userName.text = name
            return cell
            
        }else {
            let cell = table.dequeueReusableCell(withIdentifier: SideMenuListTVCell.identifier, for: indexPath) as! SideMenuListTVCell
            
            cell.listName.text = arrayMenuOptions[indexPath.row]["title"]
            cell.listImage.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            let btn = UIButton(type: UIButton.ButtonType.custom)
            btn.tag = indexPath.row
            self.onCloseMenuClick(btn)
            
            print(btn.tag)
        }
    }
    
}
