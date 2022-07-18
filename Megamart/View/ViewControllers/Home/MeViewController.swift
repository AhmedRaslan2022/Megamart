//
//  MeViewController.swift
//  Megamart
//
//  Created by Macintosh on 02/07/2022.
//

import UIKit


class MeViewController: UIViewController {
    
   
    var orderViewModel: Order_Protocol = OrderViewModel()
    var orders: [Order_Model] = []
    
   
    var favorites: [ProductEntity_firestore] = []
    var favoritesViewModel: Favorites_protocol = Favorites_viewModel()
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var orderMore: UIButton!
    @IBOutlet weak var wishlistMore: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var ordersLabel: UILabel!
    @IBOutlet weak var wishListLabel: UILabel!
    @IBOutlet weak var settingButton: UIBarButtonItem!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    @IBOutlet weak var wishlistCollection: UICollectionView!
    @IBOutlet weak var ordersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "Welcome \(defaults.string(forKey: Userdefaults_key.customerName.rawValue) ?? " ")"
        
       self.wishlistCollection.delegate = self
       self.wishlistCollection.dataSource = self
        
        self.ordersTable.delegate = self
        self.ordersTable.dataSource = self
        
       self.ordersTable.register(UINib(nibName: Constants.order_nib_name, bundle: nil), forCellReuseIdentifier: Constants.order_Cell_id)
       
        self.wishlistCollection.register(UINib(nibName: Constants.WishList_nib_name , bundle: nil), forCellWithReuseIdentifier: Constants.WishList_Cell_id)

        responseOf_fetchingOrders()
        responseOf_fetchingFavorites()
        
        
        if Login_Verification(){
            loginButton.isHidden = true
            registerButton.isHidden = true
        }
        else {
            
            requestLogin_alert(viewController: self)
            wishlistCollection.isHidden = true
            ordersTable.isHidden = true
            orderMore.isHidden = true
            wishlistMore.isHidden = true
            ordersLabel.isHidden = true
            wishListLabel.isHidden = true
            settingButton.isEnabled = false
            cartButton.isEnabled = false
        }
        
    }
      
    override func viewWillAppear(_ animated: Bool) {
        self.orderViewModel.fetchOrders()
        self.favoritesViewModel.fetchFavorites()
    }
    
    
    @IBAction func orderMore(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Constants.Orders_storyboard,bundle: nil)
        if let orderVC = storyboard.instantiateViewController(withIdentifier: Constants.Orders_ViewController_id) as? OrdersViewController{
            self.navigationController?.pushViewController(orderVC, animated: true)
        }
    }
  
    @IBAction func wishListMore(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Constants.Favorites_storyboard,bundle: nil)
        if let favVC = storyboard.instantiateViewController(withIdentifier: Constants.Favorites_ViewController_id) as? Favorites_ViewController{
            self.navigationController?.pushViewController(favVC, animated: true)
        
        }
    }
    
    
    
//MARK: -                        Register and Login Buttons Buttons
    
    
 @IBAction func goLogin(_ sender: UIButton) {
     let storyBoard : UIStoryboard = UIStoryboard(name: Constants.authentication_storyboard, bundle:nil)
     let loginVC = storyBoard.instantiateViewController(withIdentifier: Constants.login_viewController_id) as! Login_ViewController
     loginVC.modalPresentationStyle = .fullScreen
     self.present(loginVC, animated: true, completion: nil)
        }
    
 @IBAction func goRegister(_ sender: Any) {
   
     let storyBoard : UIStoryboard = UIStoryboard(name: Constants.authentication_storyboard, bundle:nil)
     let registerVC = storyBoard.instantiateViewController(withIdentifier: Constants.SignUp_viewController_id) as! Register_ViewController
     registerVC.modalPresentationStyle = .fullScreen
     self.present(registerVC, animated: true, completion: nil)
        }
    
   
    
    
    
    
//MARK: -                    Navigation Bar Buttons
    
    
    @IBAction func goCart(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.bag_storyboard,bundle: nil)
        if let cartVC = storyboard.instantiateViewController(withIdentifier: Constants.BagViewController_id) as? BagViewController{
            self.navigationController?.pushViewController(cartVC, animated: true)
      }
    
   }
       
    @IBAction func goSettings_ViewController(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.setting_storyboard, bundle:nil)
        let settingsVC = storyBoard.instantiateViewController(withIdentifier: Constants.Setting_viewController_id) as! SettingViewController
        self.navigationController?.show(settingsVC, sender: self)
    }

}




//MARK: -                            Favourite collectionView

extension MeViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favorites.isEmpty{
            return 0
        }
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = wishlistCollection.dequeueReusableCell(withReuseIdentifier: Constants.WishList_Cell_id, for: indexPath) as? WishListCollectionCell

        cell?.setCell(product: favorites[indexPath.row])
   
       return  cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.Favorites_storyboard,bundle: nil)
        if let favVC = storyboard.instantiateViewController(withIdentifier:Constants.Favorites_ViewController_id) as? Favorites_ViewController{
            self.navigationController?.pushViewController(favVC, animated: true)
            
        }
   
  
    }

}



//MARK: -                                    Orders TableView



extension MeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orders.isEmpty{
            return 0
        }
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: Constants.order_Cell_id, for: indexPath) as? OrderTableViewCell

        cell?.priceLbel.text =  "Price: \(orders[indexPath.row].totalPrice)"
        cell?.createdAtLabel.text =  "Created At: \(orders[indexPath.row].created_at)"
        
        return  cell ??  UITableViewCell()
    }
    
   

   
  
    }
    
    

    
    
//MARK: -                    Fetch data

    
 
extension MeViewController {
   
    func responseOf_fetchingOrders() {
        
        self.orderViewModel.binding = { orders , error in
            if let error = error {
               print("*****order error*******\(error)")
            }
            if let orders = orders {
                print(orders)
                DispatchQueue.main.async {
                    self.orders = orders
                    print (self.orders.count)
                    self.ordersTable.reloadData()
                }
                
            }

            
        }

    
    
}
    
    func responseOf_fetchingFavorites() {
        
        self.favoritesViewModel.binding = { favorites, error in
            if let error = error {
              print("error in wishlist\(error)")
            }
            if let favorites = favorites {
                self.favorites = favorites
                if self.favorites.count == 0 {
                
                }
                self.wishlistCollection.reloadData()
            }
            
        }
}
}


