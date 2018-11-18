//
//  ViewController1.swift
//  newGameMatch
//
//  Created by Adam Infiesto on 10/12/17.
//  Copyright © 2017 Adam Infiesto. All rights reserved.
//

import UIKit
import AVFoundation

private var player: AVAudioPlayer?

class ViewController1: UIViewController {

    @IBOutlet weak var giftyView: UIImageView!
    @IBOutlet weak var btnToPLay: UIButton!
    @IBOutlet weak var userName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        giftyView.loadGif(name: "Tower")
        /*UIViewPropertyAnimator(duration: 30, curve: .easeInOut, animations:
            {
            self.btnToPLay.alpha = 0.0
        }).startAnimation()*/
        // Do any additional setup after loading the view.
        playSound()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "game_ID"
        {
        let gvc = segue.destination as! ViewController
            gvc.playerName = userName.text!
        }
        
        player?.stop()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        giftyView.loadGif(name: "Tower")
        playSound()
    }
    
    func playSound()
    {
        let path = Bundle.main.path(forResource: "CornerOfMemories", ofType:".mp3")!
        let url = URL(fileURLWithPath: path)
        
        do
        {
            let sound = try AVAudioPlayer(contentsOf: url)
            player = sound
            sound.numberOfLoops = 1
            sound.prepareToPlay()
            sound.play()
        }
        catch
        {
            print("error loading file")
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
  

}
