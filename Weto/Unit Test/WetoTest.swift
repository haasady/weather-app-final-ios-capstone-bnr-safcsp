//
//  WetoTest.swift
//  Weto
//
//  Created by Hanan on 30/12/2020.
//

//import XCTest
//@testable import Weto
//
//class WetoTest: XCTestCase {
//    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//    
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//    
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    
//    class ApiTests: XCTestCase {
//        let businessStore = BusinessStore()
//        
//        
//        func testProcessingPhotos() {
//            let fullOutput = YelpAPI.parseJsonData(fromJSON: Constants.photosData)
//            
//            switch fullOutput {
//            
//            case .failure(let error):
//                XCTFail("Unable to decode sample data into [Photo]: \(error)")
//                
//            case .success(let result):
//                guard let business = result.first else {
//                    XCTFail("Decoded photos array is unexpectedly empty.")
//                    return
//                }
//                
//                XCTAssertEqual(business.id, Constants.firstPhotoInfo["id"] as! String)
//                XCTAssertEqual(business.imageURL, Constants.firstPhotoInfo["imageURL"] as? URL)
//            }
//        }
//    }
//}
