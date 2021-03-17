//
//  LoginVC.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import UIKit

class LoginVC: UITableViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //Model
    var loginModel:LoginModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        txtEmail.text = "eve.holt@reqres.in"
        txtPassword.text = "pistol"
        
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        ValidationCode()
    }
    
}

extension LoginVC{
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
}

extension LoginVC{
    fileprivate func ValidationCode() {
        if let email = txtEmail.text, let password = txtPassword.text, !email.isEmpty, !password.isEmpty{
            if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Email address not found.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }else{
                
                if Reachability.isConnectedToNetwork() {
                    userLoginAPI()
                }else{
                    openAlert(title: Network.title, message: Network.message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                        print("Okay clicked!")
                    }])
                }
            }
        }else{
            openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
    }
    
    func userLoginAPI() {
        
        let params = [
            "email": txtEmail.text ?? "",
            "password": txtPassword.text ?? ""
        ]
        
        print(params)
        
        RestServices.serviceCall(url: URL.login_URL, method: .post, parameters: params, isLoaded: true, title: "", message: "Loading...", vc: self) {[weak self] (response) in
            guard let self = self else {return}
            
            do{
                let responseJson = try JSONDecoder().decode(LoginModel.self, from: response)
                self.loginModel = responseJson
                
                Defaults.userDefault.setValue(true, forKey: Defaults.userIsLogged)
                Defaults.userDefault.setValue(self.txtEmail.text ?? "", forKey: Defaults.userEmail)
                
                // Navigation - Home Screen
                let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(homeVC, animated: true)
                
            }catch{
                
                self.openAlert(title: "", message: "error login, use the mail and password already displayed in the fields", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }
            
        } failure: { (error) in
            self.openAlert(title: "", message: error.localizedDescription, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
        
    }
    
}
