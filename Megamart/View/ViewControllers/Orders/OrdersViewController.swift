//
//  OrdersViewController.swift
//  Megamart
//
//  Created by Macintosh on 02/07/2022.
//

import UIKit

class OrdersViewController: UIViewController {

   
    @IBOutlet weak var ordersCollection: UICollectionView!
    
    
    

    
    var orderViewModel: Order_Protocol = OrderViewModel()
    var orders: [Order_Model] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ordersCollection.delegate = self
        self.ordersCollection.dataSource = self
        
        self.ordersCollection.register(UINib(nibName: Constants.orders_nib_name, bundle: nil), forCellWithReuseIdentifier: Constants.orders_Cell_id)
        
        responseOf_fetchingOrders()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.orderViewModel.fetchOrders()
       
    }


}


extension OrdersViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if orders.isEmpty{
            return 0
        }
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = ordersCollection.dequeueReusableCell(withReuseIdentifier: Constants.orders_Cell_id, for: indexPath) as? OrderCollectionViewCell

        cell?.dateLabel.text  = orders[indexPath.row].created_at
        cell?.priceLabel.text = String(orders[indexPath.row].totalPrice)
        if let street = orders[indexPath.row].address?.street {
            if  let city = orders[indexPath.row].address?.city {
                    cell?.countLabel.text = "\(street) " + "\(city)"
            }
        }
       return  cell ?? UICollectionViewCell()
    }
    
    
}

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
                    self.ordersCollection.reloadData()
                }
                
            }

            
        }

    }
    
}


extension OrdersViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width , height: collectionView.bounds.height / 3 )

        
    }

}

