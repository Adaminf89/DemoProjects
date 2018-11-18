//
//  ViewController.swift
//  newGameMatch
//
//  Created by Adam Infiesto on 10/5/17.
//  Copyright © 2017 Adam Infiesto. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

private var player: AVAudioPlayer?

class ViewController: UIViewController {
    
   
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    var daTimer = Timer()
    var realTime = 0
    var matchCounter = 0
    var daUsers = [Users]()
    var isFlipped = false
    var Views = [Int]()
    var counter = 0
    var counter2 = 0
    var counter3 = 0
    var globalCounter = 0
    let date = Date()
    let formatter = DateFormatter()
    var playerName = String()
    var myArray :[UIImage] = [#imageLiteral(resourceName: "death"),#imageLiteral(resourceName: "death"),#imageLiteral(resourceName: "earth"),#imageLiteral(resourceName: "earth"),#imageLiteral(resourceName: "Emperor"),#imageLiteral(resourceName: "Emperor"),#imageLiteral(resourceName: "fire"),#imageLiteral(resourceName: "fire"),#imageLiteral(resourceName: "Hunter"),#imageLiteral(resourceName: "Hunter"),#imageLiteral(resourceName: "Ice"),#imageLiteral(resourceName: "Ice"),#imageLiteral(resourceName: "knight"),#imageLiteral(resourceName: "knight"),#imageLiteral(resourceName: "land"),#imageLiteral(resourceName: "land"),#imageLiteral(resourceName: "Pendulum"),#imageLiteral(resourceName: "Pendulum"),#imageLiteral(resourceName: "Pre"),#imageLiteral(resourceName: "Pre"),#imageLiteral(resourceName: "sword"),#imageLiteral(resourceName: "sword"),#imageLiteral(resourceName: "tower"),#imageLiteral(resourceName: "tower"),#imageLiteral(resourceName: "water"),#imageLiteral(resourceName: "water"),#imageLiteral(resourceName: "wind"),#imageLiteral(resourceName: "wind"),#imageLiteral(resourceName: "world"),#imageLiteral(resourceName: "world")]
    //private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var entityDescription : NSEntityDescription!
    private var manageContext : NSManagedObjectContext!
    var userStuff : NSManagedObject!
    
    @IBOutlet var btnCollection: [UIButton]!
    var button1 = UIButton()
    var button2 = UIButton()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //set a nave view at the top
        self.title = "\(playerName) Memory Game"

        //shuffles array of images
        
         myArray.shuffle()
         theShower()
         playSound2()
        
        
        //set the delay for the actual game.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:
            {
                self.theFlip()
                self.daTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timeFunc), userInfo: nil, repeats: true)
               })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.stop()
        
        if matchCounter == 15
        {
        let appDel = UIApplication.shared.delegate as! AppDelegate

        manageContext = appDel.persistentContainer.viewContext
        
        entityDescription = NSEntityDescription.entity(forEntityName: "UserScore", in: manageContext)
        
        userStuff = NSManagedObject(entity: entityDescription, insertInto: manageContext)
        //formatters for strings
        formatter.dateFormat = "dd.MM.yyyy"
        
            
        userStuff.setValue(playerName, forKey: "pName")
        userStuff.setValue(Int16(globalCounter), forKey: "gTaps")
        userStuff.setValue(String(realTime), forKey: "gTime")
        userStuff.setValue(date, forKey: "gDate")
         
        appDel.saveContext()
        
        print("\(playerName)")
        }
        else
        {
            print("no data to save.")
        }
    }
    
    
    @IBAction func btnFlipAction(_ sender: UIButton)
    {
       
        
        //each btn tap tag
        switch sender.tag {
        case 1:
                //each one will add the random image to the set btn
            btnCollection[0].setImage(myArray[0], for: .normal)
            counter += 1
        case 2:
            btnCollection[1].setImage(myArray[1], for: .normal)
            counter += 1
        case 3:
            btnCollection[2].setImage(myArray[2], for: .normal)
             counter += 1
        case 4:
            btnCollection[3].setImage(myArray[3], for: .normal)
             counter += 1
        case 5:
            btnCollection[4].setImage(myArray[4], for: .normal)
             counter += 1
        case 6:
            btnCollection[5].setImage(myArray[5], for: .normal)
             counter += 1
        case 7:
            btnCollection[6].setImage(myArray[6], for: .normal)
             counter += 1
        case 8:
            btnCollection[7].setImage(myArray[7], for: .normal)
             counter += 1
        case 9:
            btnCollection[8].setImage(myArray[8], for: .normal)
             counter += 1
        case 10:
            btnCollection[9].setImage(myArray[9], for: .normal)
            counter += 1
        case 11:
            btnCollection[10].setImage(myArray[10], for: .normal)
            counter += 1
        case 12:
            btnCollection[11].setImage(myArray[11], for: .normal)
            counter += 1
        case 13:
            btnCollection[12].setImage(myArray[12], for: .normal)
            counter += 1
        case 14:
            btnCollection[13].setImage(myArray[13], for: .normal)
            counter += 1
        case 15:
            btnCollection[14].setImage(myArray[14], for: .normal)
            counter += 1
        case 16:
            btnCollection[15].setImage(myArray[15], for: .normal)
            counter += 1
        case 17:
            btnCollection[16].setImage(myArray[16], for: .normal)
            counter += 1
        case 18:
            btnCollection[17].setImage(myArray[17], for: .normal)
            counter += 1
        case 19:
            btnCollection[18].setImage(myArray[18], for: .normal)
            counter += 1
        case 20:
            btnCollection[19].setImage(myArray[19], for: .normal)
            counter += 1
        case 21:
            btnCollection[20].setImage(myArray[20], for: .normal)
            counter += 1
        case 22:
            btnCollection[21].setImage(myArray[21], for: .normal)
            counter += 1
        case 23:
            btnCollection[22].setImage(myArray[22], for: .normal)
            counter += 1
        case 24:
            btnCollection[23].setImage(myArray[23], for: .normal)
            counter += 1
        case 25:
            btnCollection[24].setImage(myArray[24], for: .normal)
            counter += 1
        case 26:
            btnCollection[25].setImage(myArray[25], for: .normal)
            counter += 1
        case 27:
            btnCollection[26].setImage(myArray[26], for: .normal)
            counter += 1
        case 28:
            btnCollection[27].setImage(myArray[27], for: .normal)
            counter += 1
        case 29:
            btnCollection[28].setImage(myArray[28], for: .normal)
            counter += 1
        case 30:
            btnCollection[29].setImage(myArray[29], for: .normal)
            counter += 1
        default:
            assertionFailure()
        }
        
        //when one btn is pressed add that sender to the var.
        if counter == 1
        {
            button1 = sender
            button1.isUserInteractionEnabled = false
            UIView.transition(with: button1, duration: 0.1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            globalCounter += 1
        }
        
        print(counter)

        
        if counter == 2
        {
            
             print("check array")
            //add 2nd sender tap to btn va
            button2 = sender
            //set so the user cant click other buttons
            button2.isUserInteractionEnabled = false
            disableAll()
            UIView.transition(with: button2, duration: 0.1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            globalCounter += 1
            
            //check both and set
            //to make the delay and show the 2nd btn
            if (self.button1.currentImage?.isEqual(self.button2.currentImage))!
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute:
                    {
                        print("match")
                        
                        self.button2.isHidden = true
                        self.button1.isHidden = true
                        
                        //if it a match add to 15
                        self.matchCounter += 1
                        //enable the game after correct
                        self.enableALL()
                        print("\(self.matchCounter)")
                        self.endGame()
                })//end dispatch
                endGame()
            }
            else
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute:
                    {
                        UIView.transition(with: self.button1, duration: 0.1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                        UIView.transition(with: self.button2, duration: 0.1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                        self.hardReset()
                        //bring back the first button if its not a match
                        self.enableALL()
                        
                 })//end dispatch
            }
            //reset the counter
            counter = 0
        }
      //
        endGame()
    }
    
    
   //show method
    func theShower()
    {
        
        for btn in btnCollection.enumerated()
         {
            btn.element.setImage(myArray[counter2], for: .normal)
             //make the images scale
            btn.element.imageView?.contentMode = .scaleToFill
            counter2 += 1
            //make sure they cant just press btns when this shows them the tiles
            btn.element.isUserInteractionEnabled = false
         }
        //make zero for new game
        counter2 = 0
    }
    
    func enableALL()
    {
        for btn in btnCollection.enumerated()
        {
            //bring the tiles back again so they can touch em
            btn.element.isUserInteractionEnabled = true
        }
    }
    
    func disableAll()
    {
        for btn in btnCollection.enumerated()
        {
            //bring the tiles back again so they can touch em
            btn.element.isUserInteractionEnabled = false
        }
        
    }
    
    //will use to actually start the game.
    func theFlip()
    {
        
        for btn in btnCollection.enumerated()
        {
            let image = UIImage(named: "CardBack")
            btn.element.setImage(image, for: .normal)
            //make the images scale
            btn.element.imageView?.contentMode = .scaleToFill
            counter3 += 1
            //bring the tiles back again so they can touch em
            btn.element.isUserInteractionEnabled = true
        }
        //make zero for new games 
        counter3 = 0
    }
    
    func endGame()
    {
        let hour = realTime/3600
        let min = realTime/60 % 60
        let sec = realTime % 60
        //make the time readble for the user
        let trueTime = String(format:"%02i:%02i:%02i", hour, min, sec )
        
        if matchCounter == 15
        {
            let alert = UIAlertController(title: "Wow your fast!!!", message: "Your time \(trueTime) Sec and \(globalCounter) taps", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Play", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                print("pressed the ok button")
                _ = self.navigationController?.popToRootViewController(animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            //stop timer
            daTimer.invalidate()
            
            
        }
        
    }
    
    @objc func timeFunc()
    {
        realTime += 1
        
        let hour = realTime/3600
        let min = realTime/60 % 60
        let sec = realTime % 60
        
        let trueTime = String(format:"%02i:%02i:%02i", hour, min, sec )
        
        timeLabel.text = "Time: \(trueTime)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        player?.stop()
    }
    
    //if any time is off just reset the current
    func hardReset()
    {
        for btn in btnCollection.enumerated()
        {
            let image = UIImage(named: "CardBack")
            btn.element.setImage(image, for: .normal)
            counter3 += 1
            
        }
    }
    
    func playSound2()
    {
        let path = Bundle.main.path(forResource: "87 Hopes and Dreams", ofType:".m4a")!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            player = sound
            sound.numberOfLoops = 1
            sound.prepareToPlay()
            sound.play()
        } catch {
            print("error loading file")
            // couldn't load file :(
        }
    }
    
}

