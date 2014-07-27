//
//  ViewController.swift
//  Matchismo
//
//  Created by Omer Wazir on 7/26/14.
//  Copyright (c) 2014 Omer Wazir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //workaround until outlet collections are supported in Swift
   
    @IBOutlet strong var cardButtons: NSArray!
    
    private lazy var game:CardMatchingGame = CardMatchingGame(count: self.cardButtons.count, deck: self.createDeck())
    
    func createDeck() -> PlayingCardDeck {
        return PlayingCardDeck()
    }
    
    @IBAction func touchCardButton(sender: UIButton) {
      //  let chosenButtonIndex = self.cardButtons.indexOfObject(sender)
        self.updateUI()
    }
    
    private func updateUI(){
        for index in 0..<self.cardButtons.count {
            let cardButton = self.cardButtons[index] as UIButton
            let cardButtonIndex = self.cardButtons.indexOfObject(cardButton)
            let card = self.game.cardAtIndex(cardButtonIndex)
            cardButton.setTitle(self.titleForCard(card!), forState: UIControlState.Normal)
            cardButton.setBackgroundImage(self.backgroundImageForCard(card!), forState: UIControlState.Normal)
            cardButton.enabled = !card?.matched
        }
    }
    
    private func titleForCard(card:Card)->String{
        return card.chosen ? card.content : ""
    }
    
    private func backgroundImageForCard(card:Card) -> UIImage{
        return UIImage(named: card.chosen ? "cardFront" : "cardBack")
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

