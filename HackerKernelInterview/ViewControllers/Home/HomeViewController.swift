//
//  ViewController.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import UIKit

class HomeViewController: BaseVC {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    
    var selectedSegmentValue = 0
    var cellImage = UIImage()
    
    //Models declaration
    var photosModel = [PhotosModel]()
    var postsModel = [PostsModel]()
    var singlePostModel: SinglePostModel?
    
    //MARK:-  view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        menuButton.target = self
        menuButton.action = #selector(BaseVC.onSlideMenuButtonPressed(_:))
        
        setupTableview()
        
        if Reachability.isConnectedToNetwork() {
            userPhotosAPI()
            userPostsAPI()
        }else{
            openAlert(title: Network.title, message: Network.message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    func setupTableview() {
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.estimatedRowHeight = listTableView.rowHeight
        listTableView.rowHeight = UITableView.automaticDimension
        
        listTableView.register(PhotosTVCell.nib, forCellReuseIdentifier: PhotosTVCell.identifier)
        listTableView.register(PostsTVCell.nib, forCellReuseIdentifier: PostsTVCell.identifier)
        
        selectedSegmentValue = 1
    }

    //MARK:-  Selector
    @IBAction func onTapSegmentChange(_ sender: Any) {
        
        if segment.selectedSegmentIndex == 0 {
            selectedSegmentValue = 1
            
        }else{
            selectedSegmentValue = 2
            
        }
        
        self.listTableView.reloadData()
    }
    
    //Image Setup
    @objc func tapImageView(gesture: UITapGestureRecognizer){
        print("image tapped")
        imageExpand()
    }
    
    func imageExpand(){
        let photoItem = cellImage
        let newImageView = UIImageView(image: photoItem)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        //self.navigationController?.isNavigationBarHidden = false
        sender.view?.removeFromSuperview() // This will remove image from full screen
    }
    
}

//MARK:-  Extension TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegmentValue == 1 {
            return photosModel.count
        }else{
            return postsModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let lastIndexPath = tableView.indexPathsForVisibleRows?.last{
            if lastIndexPath.row <= indexPath.row{
                cell.center.y = cell.center.y + cell.frame.height / 2
                cell.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                    cell.center.y = cell.center.y - cell.frame.height / 2
                    cell.alpha = 1
                }, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedSegmentValue == 1 {
            
            let photosCell = listTableView.dequeueReusableCell(withIdentifier: PhotosTVCell.identifier, for: indexPath) as! PhotosTVCell
            
            photosCell.cellConfig(photosModel[indexPath.row])
            return photosCell
            
        }else if selectedSegmentValue == 2 {
            
            let postsCell = listTableView.dequeueReusableCell(withIdentifier: PostsTVCell.identifier, for: indexPath) as! PostsTVCell
            
            postsCell.cellPostsConfig(postsModel[indexPath.row])
            return postsCell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedSegmentValue == 1 {
            
            let photosCell = listTableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! PhotosTVCell
                
            cellImage = photosCell.userImage.image ?? #imageLiteral(resourceName: "DashBoard")
            
            let imageTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageView(gesture:)))
            photosCell.userImage.isUserInteractionEnabled = true
            photosCell.userImage.addGestureRecognizer(imageTap)
            
        }else if selectedSegmentValue == 2 {
            
            print(postsModel[indexPath.row].id, "selected id")
            if Reachability.isConnectedToNetwork() {
                userSinglePostsAPI(endURL: "\(postsModel[indexPath.row].id ?? 0)")
            }else{
                openAlert(title: Network.title, message: Network.message, alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension HomeViewController {
    
    func userPhotosAPI() {
        
        RestServices.serviceCall(url: URL.photos_URL, method: .get, parameters: nil, isLoaded: true, title: "", message: "Loading...", vc: self) {[weak self] (response) in
            guard let self = self else {return}
            
            guard let responseJson = try? JSONDecoder().decode([PhotosModel].self, from: response) else {return}
            
            if responseJson.count > 0 {
                self.photosModel = responseJson
                
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            }else{
                self.openAlert(title: "", message: "There are no photos.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }
        } failure: { (error) in
            self.openAlert(title: "", message: error.localizedDescription, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }

    }
    
    func userPostsAPI() {
        
        RestServices.serviceCall(url: URL.posts_URL, method: .get, parameters: nil, isLoaded: true, title: "", message: "Loading...", vc: self) {[weak self] (response) in
            guard let self = self else {return}
            
            guard let responseJson = try? JSONDecoder().decode([PostsModel].self, from: response) else {return}
            
            if responseJson.count > 0 {
                self.postsModel = responseJson
                
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            }else{
                self.openAlert(title: "", message: "There are no posts.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }
        } failure: { (error) in
            self.openAlert(title: "", message: error.localizedDescription, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
        
    }
    
    func userSinglePostsAPI(endURL: String) {
        
        print(endURL)
        print(URL.singlePosts_URL+endURL)
        
        RestServices.serviceCall(url: URL.singlePosts_URL+endURL, method: .get, parameters: nil, isLoaded: true, title: "", message: "processing...", vc: self) {[weak self] (response) in
            guard let self = self else {return}
            
            guard let responseJson = try? JSONDecoder().decode(SinglePostModel.self, from: response) else {return}
            
            self.singlePostModel = responseJson
            
            self.openAlert(title: responseJson.title ?? "", message: responseJson.body ?? "", alertStyle: .alert, actionTitles: ["Dismiss"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
            
        } failure: { (error) in
            self.openAlert(title: "", message: error.localizedDescription, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
        
    }
    
}
