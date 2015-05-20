//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jami Couch on 5/20/15.
//  Copyright (c) 2015 Jami Couch. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!;

    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if var soundPath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            audioPlayer = AVAudioPlayer(contentsOfURL: NSURL.fileURLWithPath(soundPath), error: nil)
            audioPlayer.enableRate = true
            audioPlayer.delegate = self
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playAtRate(0.5)
        stopButton.hidden = false
    }

    @IBAction func playFast(sender: UIButton) {
        playAtRate(1.5)
        stopButton.hidden = false
    }
    
    @IBAction func stopPlayback(sender: UIButton) {
        stopButton.hidden = true
        audioPlayer.stop()
    }
    
    func playAtRate(rate: Float) {
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: AVAudioPlayerDelegate
extension PlaySoundsViewController : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        stopButton.hidden = true
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        stopButton.hidden = true
    }
}
