//
//  HomeViewController.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 17/03/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var toyCollectionView: UICollectionView!
    
    @IBOutlet weak var dvdCollectionView: UICollectionView!
    
    var pageViewController:UIPageViewController?
    let arrPageImage = ["cat","fantasy","stnext","piratemap","piratebattle"]
    
    var currentIndex = 0
    var toysCollection = [Product]()
    var dvdCollection = [Product]()
    var selectedProduct: Product?
    var productsInSelectedCategory: [Product]?
    var productTVC: ProductsTableViewController?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(HomeViewController.loadNextController), userInfo: nil, repeats: true)
        
        setPageViewController()
        
        loadProducts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Private functions
    
    private func setPageViewController() {
        let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "promoPageVC") as! UIPageViewController
        pageVC.dataSource = self
        
        let firstController = getViewController(atIndex: 0)
        
        pageVC.setViewControllers([firstController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        self.pageViewController = pageVC
        
        self.addChildViewController(self.pageViewController!)
        self.pageView.addSubview(self.pageViewController!.view)
        self.pageViewController?.didMove(toParentViewController: self)
    }
    
    
    fileprivate func getViewController(atIndex index: Int) -> PromoContentViewController {
        let promoContentVC = self.storyboard?.instantiateViewController(withIdentifier: "promoContentVC") as! PromoContentViewController
        
        promoContentVC.imageName = arrPageImage[index]
        promoContentVC.pageIndex = index
        
        return promoContentVC
    }
    
    
    @objc private func loadNextController() {
        currentIndex += 1
        
        if currentIndex == arrPageImage.count {
            currentIndex = 0
        }
        
        let nextController = getViewController(atIndex: currentIndex)
        
        self.pageViewController?.setViewControllers([nextController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        self.pageControl.currentPage = currentIndex
    }
    
    
    private func loadProducts() {
        toysCollection = ProductService.products(category: "toy")
        dvdCollection = ProductService.products(category: "dvd")
    }
    
    
    @IBAction func unwindFromOrderConfirmation(segue: UIStoryboardSegue) {
        print("Coming from Order Confirmation")
    }
}


// MARK: - UIPageViewControllerDatasource

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PromoContentViewController
        var index = pageContentVC.pageIndex
        
        if index == 0 || index == NSNotFound {
            return getViewController(atIndex: arrPageImage.count - 1)
            
            //  0 | 1 | 2 | 0 | 1 | 2 | ....
        }
        
        index -= 1 // index = index - 1
        
        return getViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PromoContentViewController
        var index = pageContentVC.pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if index == arrPageImage.count {
            return getViewController(atIndex: 0)
        }
        
        return getViewController(atIndex: index)
    }
}


// MARK: - UICollectionViewDatasource

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.toyCollectionView:
            return self.toysCollection.count
            
        case self.dvdCollectionView:
            return self.dvdCollection.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.toyCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellToy", for: indexPath) as! ProductCollectionViewCell
            
            let product = toysCollection[indexPath.row]
            cell.productImageView.image = Utility.image(withName: product.mainImage, andType: "jpg")
            
            return cell
            
        case self.dvdCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDvd", for: indexPath) as! ProductCollectionViewCell
            
            let product = dvdCollection[indexPath.row]
            cell.productImageView.image = Utility.image(withName: product.mainImage, andType: "jpg")
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}


// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.toyCollectionView:
            selectedProduct = toysCollection[indexPath.row]
            productsInSelectedCategory = toysCollection
            
        case self.dvdCollectionView:
            selectedProduct = dvdCollection[indexPath.row]
            productsInSelectedCategory = dvdCollection
            
        default:
            print("Nothing is picked")
        }
        
        self.productTVC?.products = productsInSelectedCategory
        self.productTVC?.selectedProduct = selectedProduct
        
        self.parent?.tabBarController?.selectedIndex = 1
    }
}




