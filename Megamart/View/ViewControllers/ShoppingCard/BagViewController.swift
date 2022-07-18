//
//  BagViewController.swift
//  Megamart
//
//  Created by A on 10/04/1401 AP.
//

import UIKit

class BagViewController: UIViewController {

    
    var productsBagCard: [ProductBagCard_firestore] = []
    var productIndex: Int?
    var totalPrice: Double = 0.0
    
    var bagCardViewModel: BagCard_protocol = BagCard_viewModel()
    
    @IBOutlet weak var bagTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bagTableView.delegate = self
        bagTableView.dataSource = self
        
        responseOf_fetchingBagCard()
        responseOf_deleteProductFrombagCart()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bagCardViewModel.fetchBagCard()
        self.tabBarController?.tabBar.isHidden = true
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    @IBAction func checkout(_ sender: Any) {
        if self.productsBagCard.count > 0 {
            let storyBoard : UIStoryboard = UIStoryboard(name: Constants.setting_storyboard, bundle:nil)
            let addressViewController = storyBoard.instantiateViewController(withIdentifier: Constants.address_ViewController_id) as! AddressVC
            
            addressViewController.order = Order_Model(id: "", products: productsBagCard, totalPrice: self.totalPrice, created_at: self.bagCardViewModel.getCurrentTime(), address: nil)
            self.navigationController?.pushViewController(addressViewController, animated: true)
        }
        else{
            addAlert(title: "Warning", message: "There are no product in cart \n add products and Try again", ActionTitle: "OK", viewController: self)
        }
        
    }
    

    
    
    
}



//MARK: -                                   The response of fetching BagCard


extension BagViewController {
    
    func responseOf_fetchingBagCard() {
        
        self.bagCardViewModel.binding = { bagCard , error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription , ActionTitle: "Cancel", viewController: self)
            }
            if let bagCard = bagCard {
                DispatchQueue.main.async {
                    self.productsBagCard = bagCard
                    self.bagTableView.reloadData()
                }
                self.updateTotalPrice()
                
            }
            else{
                addAlert(title: "Alert!", message: "There are no product in cart", ActionTitle: "Cancel", viewController: self)
            }
            
        }
    }
    
    
//MARK: -                           The response of Delete product from Cart
    
    
    func responseOf_deleteProductFrombagCart() {
        
        self.bagCardViewModel.removeFromBagCard_status = { error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription , ActionTitle: "Cancel", viewController: self)
            }
            else{
                guard let productIndex = self.productIndex else { return }
                self.productsBagCard.remove(at: productIndex)
                DispatchQueue.main.async {
                    self.bagTableView.reloadData()
                }
                addAlert(title: "Done", message: "Product remove from bag cart", ActionTitle: "OK", viewController: self)
            }
        }
    }
    
    
    func responseOf_saveProductFrombagCart() {
        
        self.bagCardViewModel.addToBagCart_status = { error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription , ActionTitle: "Cancel", viewController: self)
            }
            else{
                DispatchQueue.main.async {
                    self.bagTableView.reloadData()
                }
                addAlert(title: "Done", message: "Product save from bag cart", ActionTitle: "OK", viewController: self)
            }
        }
    }
    
}


//MARK: -                                       Update Product Count and Total Price


extension BagViewController: UpdateProductCount_protocol {
    
    func updateProductCount(count: Int, index: Int) {
        self.productsBagCard[index].count = count
        updateTotalPrice()
    }
    
    func updateTotalPrice() {
        totalPrice = 0.0
        for product in productsBagCard {
            let priceOfProduct = Double(product.price) * Double(product.count)
            totalPrice += priceOfProduct
        }
        
        DispatchQueue.main.async {
            self.totalPriceLabel.text = "\(self.totalPrice)"
        }
        
    }
    
}






//MARK: -                                    Table View


extension BagViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsBagCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.BagTableViewCell_id, for: indexPath) as? BagTableViewCell else{
            return UITableViewCell ()
        }
        cell.delegate = self
        cell.setCellBagCard(product: productsBagCard[indexPath.row], productIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (action, view , completionHandler) in
            self.productIndex = indexPath.row
            self.bagCardViewModel.removeFromBagCard(productId: self.productsBagCard[indexPath.row].id )            
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
