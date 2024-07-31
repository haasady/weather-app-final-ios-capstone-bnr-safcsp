//
//  SearchViewController.swift
//  Weto
//
//  Created by Hanan on 30/12/2020.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var cityTextField: UITextField!
    
    var weatherStore: WeatherStore!
    var businessStore: BusinessStore!
    var collectionVC : CollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherStore = WeatherStore()
        self.businessStore = BusinessStore()
        self.collectionVC = CollectionViewController()
    }
    
    @IBAction func getCity(_ sender: UIButton) {
        
        if let tempCity = cityTextField.text {
            API.city = tempCity
            
            CollectionViewController.goFetch = true
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
