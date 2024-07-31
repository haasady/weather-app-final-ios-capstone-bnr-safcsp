//
//  ViewController.swift
//  Weto
//
//  Created by Hanan on 23/12/2020.
//

import UIKit

class CollectionViewController: UIViewController {

    // flag
    public static var goFetch = false

    // outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var nothingLabel: UILabel!
    
    // Stores
    var collectionDataSource: CollectionDataSource!
    var businessStore: BusinessStore!
    var weatherStore: WeatherStore!
    
    // Arrays
    var businesses = [Business]()
    var forcastday = [Forecastday]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.collectionDataSource = CollectionDataSource()
        self.businessStore = BusinessStore()
        self.weatherStore = WeatherStore()
        
        collectionView.delegate = self
        collectionView.dataSource = collectionDataSource

        
        if collectionDataSource.businessWeatherlist.isEmpty {
            collectionView.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestData()
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as! SearchViewController
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func requestData() {
        if CollectionViewController.goFetch == true {
            
            self.collectionView.isHidden = false
            
            self.collectionDataSource.businessWeatherlist.removeAll()
            
            // fetch data
            self.businessStore.requestBusinessData { (result) in
                switch result {
                case let .success(result):
                    print("Successfully found \(result.count) businuss.")
                    
                    for business in result {
                            
                            API.lat = business.coordinates.latitude
                            API.lon = business.coordinates.longitude
                                                    
                            // fetch weather
                            self.weatherStore.requestWeatherData { (result) in
                                switch result {
                                case let .success(result):
                                    print("Successfully found \(result.count) weathers.")
                                    
                                    let businessWeather = BusinessWeather(business: business, weather: result)
                                    
                                    self.collectionDataSource.businessWeatherlist.append(businessWeather)

                                    self.collectionView.reloadData()
                                    
                                case let .failure(error):
                                    print("Error fetching from yelp: \(error)")
                                }
                            }
                        }
                                    
                case let .failure(error):
                    print("Error fetching from yelp: \(error)")
                }
            }
            CollectionViewController.goFetch = false
        }
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showDetail":
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                let besninussWeather = self.collectionDataSource.businessWeatherlist[indexPath.item]
                
                let detailVC = segue.destination as! DetailViewController
                detailVC.besninussWeather = besninussWeather
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 400, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let businessWeather = self.collectionDataSource.businessWeatherlist[indexPath.item]
        
        businessStore.fetchImage(for: businessWeather.business) { (result) -> Void in
            guard let imageIndex = self.collectionDataSource.businessWeatherlist.firstIndex(of: businessWeather) ,
                  case let .success(image) = result
            else {
                return
            }
            
            let imageIndexPath = IndexPath(item: imageIndex, section: 0)
            
            if let cell = self.collectionView.cellForItem(at: imageIndexPath) as? CollectionCell {
                cell.condition.text = businessWeather.weather[0].day.condition.text
                cell.storeName.text = businessWeather.business.name
                cell.update(displaying: image)
            }
        }
        
    }
}

