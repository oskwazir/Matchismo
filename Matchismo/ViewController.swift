//
//  ViewController.swift
//  Matchismo
//
//  Created by Omer Wazir on 7/26/14.
//  Copyright (c) 2014 Omer Wazir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let playingCardDeck:PlayingCardDeck = PlayingCardDeck()
    
    @IBAction func touchCardButton(sender: UIButton) {
        
        // Need to safely unwrap this because no text in currentTitle is a nil value
        
        if sender.currentTitle {
            sender.setBackgroundImage(UIImage(named: "cardBack"), forState: UIControlState.Normal)
            sender.setTitle(nil, forState: UIControlState.Normal)
        } else {
            //a nil will be returned if the deck is finished
            if let card = playingCardDeck.drawRandomCard(){
                sender.setBackgroundImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
                sender.setTitle(card.content, forState: UIControlState.Normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

