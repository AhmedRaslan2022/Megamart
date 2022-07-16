//
//  HomeVC.swift
//  Megamart
//
//  Created by A on 13/04/1401 AP.
//



import UIKit


class HomeVC: UIViewController {
    

    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    let defaults = UserDefaults.standard
    
    var arrAdsPhoto = [UIImage(named: "ads1")!, UIImage(named: "ads2")!, UIImage(named: "ads3")!, UIImage(named: "ads4")!, UIImage(named: "ads5")!, UIImage(named: "ads6")!]
    
    var brandsArray = [SmartCollection]()
    var timer : Timer?
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       brandsCollectionView.register(UINib(nibName: Constants.Brands_nib_name, bundle: nil), forCellWithReuseIdentifier: Constants.Brands_Cell_id)
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        
        defaults.set(0.0, forKey: Userdefaults_key.couponValue.rawValue)
        
         let brandsViewModel = BrandsViewModel()
           brandsViewModel.fetchData()
           brandsViewModel.bindingData = { brands, error in
               if let brands = brands {
                   self.brandsArray = brands
                    DispatchQueue.main.async {
                      self.brandsCollectionView.reloadData()
                   }
               }
               if let error = error {
                   print(error.localizedDescription)
               }
           }
  
        
        startTimer()
    
    }

    func startTimer () {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    @objc func moveToNextIndex(){
        if currentCellIndex < arrAdsPhoto.count - 1 {
            currentCellIndex += 1
        }else{
            currentCellIndex = 0
        }
        menuCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        
        
    }
    
    @IBAction func goFav(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.Favorites_storyboard,bundle: nil)
        if let favouriteVC = storyboard.instantiateViewController(withIdentifier: Constants.Favorites_ViewController_id) as? Favorites_ViewController{
            self.navigationController?.pushViewController(favouriteVC, animated: true)
    }
    }
    
    @IBAction func goCart(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: Constants.bag_storyboard,bundle: nil)
        if let cartVC = storyboard.instantiateViewController(withIdentifier: Constants.BagViewController_id) as? BagViewController{
            self.navigationController?.pushViewController(cartVC, animated: true)
    }
    }
    
    
    
}
    
    
   

extension HomeVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == menuCollectionView){
        return arrAdsPhoto.count
        }
        return brandsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == menuCollectionView){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCollectionViewCell", for: indexPath) as! AdsCollectionViewCell
        cell.adsPhoto.image = arrAdsPhoto[indexPath.row]
        return cell
        }
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Brands_Cell_id", for: indexPath) as! BrandsCollectionCell
        cell.brandName.text = brandsArray[indexPath.row].title
        let image = brandsArray[indexPath.row].image.src
        cell.setCell(imageUrl: image)
   
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == menuCollectionView){
        return CGSize(width: brandsCollectionView.frame.width, height: brandsCollectionView.frame.height)
    }
        return CGSize(width: brandsCollectionView.bounds.width/2, height: brandsCollectionView.bounds.height/2)
    }
       


    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == menuCollectionView {
            defaults.set(Constants.coupons_values[indexPath.row], forKey: Userdefaults_key.couponValue.rawValue)
            addAlert(title: "congratulations", message: "Coupon added", ActionTitle: "OK", viewController: self)
        }
        
        let storyboard = UIStoryboard(name: Constants.Products_storyboard,bundle: nil)
        if let productsVC = storyboard.instantiateViewController(withIdentifier:Constants.ProductsViewController_id) as? ProductsViewController{
            productsVC.brandTitle = brandsArray[indexPath.row].title
            self.navigationController?.pushViewController(productsVC, animated: true)
    }
    
}
}
