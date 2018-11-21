//
//  ARViewController.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/14/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//
import UIKit
import SceneKit
import CoreLocation
import ARCL

class ARViewController: UIViewController
{

    var sceneLocationView = SceneLocationView()
    let image = UIImage(named: "drop")!
    var photos : Photo!
    @IBOutlet weak var buttondimiss: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        
//        let lat = Double(photos.location)
//        let long = Double(photos.locationlong)
        // Do any additional setup after loading the view.
        
        let coordinate = CLLocationCoordinate2D(latitude: Double(photos.location)!, longitude: Double(photos.locationlong)!)
        let location = CLLocation(coordinate: coordinate, altitude: 150)
        let annotationNode = LocationAnnotationNode(location: location, image: image)
        annotationNode.scaleRelativeToDistance = true
        
        //sceneLocationView.addLocationNodeForCurrentPosition(locationNode: annotationNode)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
        

    }
    
    
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func CancelButtonWasPressed(_ sender: Any)
    {
        // Just dismiss the view controller since the user wants to exit the sign up process
        self.dismiss(animated: true, completion: nil)
    }
}

