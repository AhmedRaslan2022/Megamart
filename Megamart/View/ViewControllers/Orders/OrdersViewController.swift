//
//  OrdersViewController.swift
//  Megamart
//
//  Created by Macintosh on 02/07/2022.
//

import UIKit

class OrdersViewController: UIViewController {

   
    @IBOutlet weak var ordersCollection: UICollectionView!
    @IBOutlet weak var ordersTabelView: UITableView!
    
    

    
    var orderViewModel: Order_Protocol = OrderViewModel()
    var orders: [Order_Model] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ordersTabelView.delegate = self
        self.ordersTabelView.dataSource = self
        
        self.ordersTabelView.register(UINib(nibName: Constants.orders_nib_name, bundle: nil), forCellReuseIdentifier: Constants.orders_Cell_id)
        
        responseOf_fetchingOrders()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.orderViewModel.fetchOrders()
       
    }


}


extension OrdersViewController: UITableViewDelegate {
    
}

extension OrdersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.orders_Cell_id, for: indexPath) as? OrdersTableViewCell else { return UITableViewCell() }
        if let address = self.orders[indexPath.row].address {
            cell.setCell(date: self.orders[indexPath.row].created_at , price: self.orders[indexPath.row].totalPrice, address: address)
        }
        return cell
    }
    
    
}

//extension OrdersViewController : UICollectionViewDelegate,UICollectionViewDataSource {
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        if orders.isEmpty{
////            return 0
////        }
//        return orders.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let  cell = ordersCollection.dequeueReusableCell(withReuseIdentifier: Constants.orders_Cell_id, for: indexPath) as? OrderCollectionViewCell
//
//        cell?.dateLabel.text  = orders[indexPath.row].created_at
//        cell?.priceLabel.text = String(orders[indexPath.row].totalPrice)
//        if let street = orders[indexPath.row].address?.street {
//            if  let city = orders[indexPath.row].address?.city {
//                    cell?.countLabel.text = "\(street) " + "\(city)"
//            }
//        }
//       return  cell ?? UICollectionViewCell()
//    }
//
//
//}

extension OrdersViewController {
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
                    self.ordersTabelView.reloadData()
                }
                
            }

            
        }

    }
    
}


//extension OrdersViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: collectionView.bounds.width , height: collectionView.bounds.height / 7 )
//    }
//
//}

