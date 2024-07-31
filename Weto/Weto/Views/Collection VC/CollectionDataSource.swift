//
//  CollectionDataSource.swift
//  Weto
//
//  Created by Hanan on 30/12/2020.
//

import UIKit

class CollectionDataSource: NSObject, UICollectionViewDataSource {
   
    var businessWeatherlist = [BusinessWeather] ()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return businessWeatherlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "cell"
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionCell
        
        cell.update(displaying: nil)
                
        return cell
    }
    
    let localURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("businessWeather.plist")
        
    }()

    
    override init(){
        super.init()
        self.loadData()
    }
    
    @objc func saveData() throws {
        print("Saving data to: \(localURL)")
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(businessWeatherlist)
            try data.write(to: localURL, options: [.atomic])
            print("Saved all of the tasks")
        } catch let encodingError {
            print("Error encoding tasks: \(encodingError)")
        }
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: localURL)
            let decoder = PropertyListDecoder()
            let businessWeather = try decoder.decode([BusinessWeather].self, from: data)
            businessWeatherlist = businessWeather
        } catch {
            print("Error reading in saved items: \(error)")
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,selector: #selector(saveData),
                                       name: UIScene.didEnterBackgroundNotification,
                                       object: nil)

    }
    
}
