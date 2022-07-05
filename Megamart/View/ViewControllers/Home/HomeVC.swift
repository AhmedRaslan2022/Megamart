//
//  HomeVC.swift
//  Megamart
//
//  Created by A on 13/04/1401 AP.
//

import UIKit
//import ViewAnimator

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
   
    @IBOutlet weak var brandsCollectionView: UICollectionView!
     var arrAdsPhoto = [UIImage(named: "ads1")!, UIImage(named: "ads2")!, UIImage(named: "ads3")!, UIImage(named: "ads4")!, UIImage(named: "ads5")!, UIImage(named: "ads6")!]
    
    var brandsArray = [BrandsModel]()
    var timer : Timer?
    var currentCellIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.brandsCollectionView.register(UINib(nibName: Constants.Brands_nib_name, bundle: nil), forCellWithReuseIdentifier: Constants.Brands_Cell_id)
        
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        
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
  
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        startTimer()
    
    }

    func startTimer () {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    @objc func moveToNextIndex(){
        if currentCellIndex < arrAdsPhoto.count - 1{
            currentCellIndex += 1
        }else{
            currentCellIndex = 0
        }
        menuCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        
        
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
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Brands_Cell_id, for: indexPath) as! BrandsCollectionCell
        cell.BrandName.text = brandsArray[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
