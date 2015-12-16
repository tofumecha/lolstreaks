//
//  SearchViewController.swift
//  lolstreaks
//
//  Created by Sean Chang on 12/2/15.
//  Copyright © 2015 Sean Chang. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var bgView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var regionTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBAction func searchButtonTapped(sender: AnyObject) {
        //1
        PlayerController.sharedInstance.searchForPlayer(regionTextField.text!.lowercaseString, playerName: usernameTextField.text!) { (success) -> Void in
            if success {
                //3 calls
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.statusLabel.text = "player found, searching for current game..."
                })
                CurrentGameController.sharedInstance.searchForCurrentGame(self.regionTextField.text!, summonerId: PlayerController.sharedInstance.currentPlayer.summonerID, completion: { (success) -> Void in
                    if success {
                        if CurrentGameController.sharedInstance.currentGame.gameId != 0 && CurrentGameController.sharedInstance.currentGame.gameId != -1 {
                            print("current game success")
                            
                            NSThread.sleepForTimeInterval(3)
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.statusLabel.text = "current game found, please wait..."
                            })
                            //13 requests
                            let allIds = CurrentGameController.sharedInstance.allIds
                            for id in allIds {
                                NSThread.sleepForTimeInterval(1)
                                PastGameController.sharedInstance.searchForTenRecentGames(self.regionTextField.text!, summonerId: id, completion: { (success) -> Void in
                                    print("past games appended to Player: \(id)")

                                })
                            }
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.performSegueWithIdentifier("searchToCollection", sender: self)
                            })
                            
                        }
                    } else {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.statusLabel.text = " "
                            print("try again")
                            let noGameAlert = UIAlertController(title: "No game", message: "Player is currently not in a game", preferredStyle: .Alert)
                            noGameAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                            noGameAlert.addAction(UIAlertAction(title: "Go to profile", style: .Default, handler: { (action) -> Void in
                                self.performSegueWithIdentifier("alertToProfile", sender: self)
                            }))
                            self.presentViewController(noGameAlert, animated: true, completion: nil)
                        })

                    }

                })
                
            } else {
                print("error")
                //alertcontroller
                let noPlayerAlert = UIAlertController(title: "No player", message: "No player found by that name", preferredStyle:  .Alert)
                noPlayerAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(noPlayerAlert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = " "
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        statusLabel.text = " "
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
