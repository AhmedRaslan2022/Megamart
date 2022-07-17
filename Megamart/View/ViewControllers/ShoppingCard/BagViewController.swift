//
//  BagViewController.swift
//  Megamart
//
//  Created by A on 10/04/1401 AP.
//

import UIKit

class BagViewController: UIViewController {

    
    var productsBagCard: [ProductBagCard_firestore] = []
    var productBag : ProductModel?
    var bagCardViewModel: BagCard_protocol = BagCard_viewModel()
    var productIndex: Int?
    
    @IBOutlet weak var bagTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bagTableView.delegate = self
        bagTableView.dataSource = self
       
        self.tabBarController?.tabBar.isHidden = true
        
        responseOf_fetchingBagCard()
        responseOf_deleteProductFrombagCart()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bagCardViewModel.fetchBagCard()
    }
 
    
    
    
    @IBAction func checkout(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.setting_storyboard, bundle:nil)
        let addressViewController = storyBoard.instantiateViewController(withIdentifier: Constants.address_ViewController_id) as! AddressVC
        addressViewController.order = Order_Model(id: "", products: productsBagCard, totalPrice: "1000", created_at: "2022", address: nil)
        self.navigationController?.pushViewController(addressViewController, animated: true)
    }
    

}


//MARK: -                                   delete Product From BadCard


extension BagViewController: DeleteProductFromBagCard_protocol {
    
    func deleteProductFromBagCard(productId: String) {
        
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to remove this product from your bagCart", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.bagCardViewModel.removeFromBagCard(productId: productId)
            
            for index in 0..<self.productsBagCard.count {
                if self.productsBagCard[index].id == productId {
                    self.productsBagCard.remove(at: index)
                    break
                }
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
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
                
            }
            else{
                addAlert(title: "Alert!", message: "There are no bag cart", ActionTitle: "Cancel", viewController: self)
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




extension BagViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsBagCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.BagTableViewCell_id, for: indexPath) as? BagTableViewCell else{
            return UITableViewCell ()
        }
        
        cell.setCellBagCard(product: productsBagCard[indexPath.row])
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
