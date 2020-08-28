//
//  ViewController.swift
//  my_trainer
//
//  Created by  Kirill Berezin on 24.03.2020.
//  Copyright © 2020  Kirill Berezin. All rights reserved.
//

import UIKit
import AudioToolbox


class ViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var pauseLabel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    
    let program: trainingProgram = trainingProgram()
    
    let startText = "Press start"
    let startTime = "00:00"
    
    var timeSpent = 0
    var timeRemains = 0
    var bTime = 0
    var active : Bool = true
    var timer : Timer?
    var flip = true
    
    //var feedbackGenerator : UISelectionFeedbackGenerator? = nil
    //var feedbackGenerator : UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
    var feedbackGenerator : UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()
    override func viewDidLoad() {
        super.viewDidLoad()
        //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        if (sender.currentTitle  == "START") {
            stopButton.isEnabled = true
            startButton.setTitle("PAUSE", for: UIControl.State.normal)
            //feedbackGenerator = UISelectionFeedbackGenerator()
            //feedbackGenerator?.prepare()
            feedbackGenerator.prepare()
            program.start()
            if let action = program.next() {
                infoLabel.text = action.name
                timeSpent = 0
                timeRemains = action.duration * 10
                bTime = action.rest * 10
                active = true
                activityLabel.text = "0.0"
                timer =  Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
                UIApplication.shared.isIdleTimerDisabled = true
            } else {
                timer?.invalidate()
                timer = nil
                infoLabel.text = startText
                //feedbackGenerator = nil
                UIApplication.shared.isIdleTimerDisabled = false
            }
        } else if (sender.currentTitle == "STOP") {
            stopButton.isEnabled = false
            startButton.setTitle("START", for: UIControl.State.normal)
            infoLabel.text = startText
            activityLabel.text = startTime
            pauseLabel.text = startTime
            timer?.invalidate()
            timer = nil
            UIApplication.shared.isIdleTimerDisabled = false
            //feedbackGenerator = nil
        } else if (sender.currentTitle == "PAUSE") {
            timer?.invalidate()
            timer = nil
            startButton.setTitle("RESUME", for: UIControl.State.normal)
            timer =  Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(flipTimer), userInfo: nil, repeats: true)
        } else if (sender.currentTitle == "RESUME") {
            startButton.setTitle("PAUSE", for: UIControl.State.normal)
            timer?.invalidate()
            timer =  Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func flipTimer() {
        if (flip) {
            if (active) {
               activityLabel.text = ""
            } else {
               pauseLabel.text = ""
            }
        } else {
            let display : String = "\(timeSpent/10).\(timeSpent%10)"
            if active {
                activityLabel.text = display
            } else {
                pauseLabel.text = display
            }
        }
        flip = !flip
    }
    
    @objc func updateCounter() {
        if timeRemains >= 0 {
            timeSpent += 1
            timeRemains -= 1
            let display : String = "\(timeSpent/10).\(timeSpent%10)"
            if active {
                activityLabel.text = display
            } else {
                pauseLabel.text = display
            }
        } else if active {
            active = false
            timeSpent = 0
            timeRemains = bTime
            activityLabel.text = startTime
            pauseLabel.text = "0.0"
            infoLabel.text = "Rest"
            AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
            //feedbackGenerator?.selectionChanged()
            //feedbackGenerator?.prepare()
            //feedbackGenerator.impactOccurred()
            feedbackGenerator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
            feedbackGenerator.prepare()
        } else if let action = program.next() {
            infoLabel.text = action.name
            timeSpent = 0
            timeRemains = action.duration * 10
            bTime = action.rest * 10
            active = true
            pauseLabel.text = startTime
            AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(1011)) { }
            //feedbackGenerator?.selectionChanged()
            //feedbackGenerator?.prepare()
            //feedbackGenerator.impactOccurred()
            feedbackGenerator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.warning)
            feedbackGenerator.prepare()
        } else {
            timer?.invalidate()
            timer = nil
            
            infoLabel.text = startText
            pauseLabel.text = startTime
            stopButton.setTitle("STOP", for: UIControl.State.normal)
            stopButton.isEnabled = false
            startButton.setTitle("START", for: UIControl.State.normal)
            AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(1311)) { }
            //feedbackGenerator?.selectionChanged()
            //feedbackGenerator = nil
            //feedbackGenerator.impactOccurred()
            feedbackGenerator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
    
}

