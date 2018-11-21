//
//  DetailViewController.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/12/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var text_box: UITextView!
    var photos : Photo!
    var lat : Double = 0.0
    var long : Double = 0.0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        text_box.text = photos.caption
        image_view.downloadImage(from: photos.image_path)
        lat = Double(photos.location)!
        long = Double(photos.locationlong)!
        
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
            let detailVC = segue.destination as! ARViewController
            detailVC.photos = self.photos
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func CancelButtonWasPressed(_ sender: Any) {
        // Just dismiss the view controller since the user wants to exit the sign up process
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func navButton(_ sender: Any)
    {
        let coordinates = CLLocationCoordinate2DMake(lat, long)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapitem = MKMapItem(placemark: placemark)
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapitem.name = photos.caption
        mapitem.openInMaps(launchOptions: options)
    }
}
