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
    
    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    var receivedAudio: RecordedAudio!
    var audioFile: AVAudioFile!

    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioPlayer.delegate = self
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
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
    
    @IBAction func playChipmunk(sender: UIButton) {
        println("playChipmunk")
        playWithPitch(1000)
    }
    
    @IBAction func playVader(sender: UIButton) {
        println("playVader")
        playWithPitch(-1000)
    }
    
    @IBAction func stopPlayback(sender: UIButton) {
        stopButton.hidden = true
        audioPlayer.stop()
        audioEngine.stop()
    }
    
    func playAtRate(rate: Float) {
        audioEngine.stop()
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playWithPitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        stopButton.hidden = false
        let pitchPlayer = AVAudioPlayerNode()
        let pitchShift = AVAudioUnitTimePitch()
        
        pitchShift.pitch = pitch
        
        audioEngine.attachNode(pitchPlayer)
        audioEngine.attachNode(pitchShift)
        
        audioEngine.connect(pitchPlayer, to: pitchShift, format: nil)
        audioEngine.connect(pitchShift, to: audioEngine.outputNode, format: nil)
        
        pitchPlayer.scheduleFile(audioFile, atTime: nil) {
            () in
            self.stopButton.hidden = true
        }
        
        audioEngine.startAndReturnError(nil)
        
        pitchPlayer.play()
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
