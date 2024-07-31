//
//  DetailViewController.swift
//  Weto
//
//  Created by Hanan on 30/12/2020.
//

import UIKit

class DetailViewController: UIViewController {
    var besninussWeather: BusinessWeather!
    
    @IBOutlet var weatherCollectionView: UICollectionView!
    
    @IBOutlet var businessName: UILabel!
    
    @IBOutlet var address1: UILabel!
    @IBOutlet var address2: UILabel!
    
    @IBOutlet var businessPhone: UILabel!
    @IBOutlet var isClosed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let business = besninussWeather.business
        
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        
        businessName.text = business.name
        address1.text = business.location.address[0]
        address2.text = business.location.address[1]
        businessPhone.text = business.phone
        
        if business.isClosed == false {
            isClosed.text = "Open"
            isClosed.textColor = .green
        } else {
            isClosed.text = "Closed"
            isClosed.textColor = .red
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        weatherCollectionView.reloadData()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dayName(date: String) -> String {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        let myDate = dateFormatter1.date(from: date)
        dateFormatter1.dateFormat = "EEEE"
        if(myDate != nil){
            let Date = dateFormatter1.string(from: myDate!)
            return Date
        }
        else{
            return ""
        }
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return besninussWeather.weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "weatherCell"
        let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! WeatherCell
        
        let weather = self.besninussWeather.weather[indexPath.item]
        print("entered")
        
        cell.day.text = dayName(date: weather.date)
        cell.date.text = weather.date
        cell.condition.text = weather.day.condition.text
        cell.windValue.text = String(weather.day.wind)
        cell.tempValue.text =  String(weather.day.temp)
        cell.humiditValue.text = String(weather.day.humidity)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 400, height: 450)
    }
    
}

