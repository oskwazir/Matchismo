//
//  CardMatchingGame.swift
//  Matchismo
//
//  Created by Omer Wazir on 7/27/14.
//  Copyright (c) 2014 Omer Wazir. All rights reserved.
//

import Foundation


//Worth testing this in a playground.
class CardMatchingGame{
    
    //any argument dealing with the index of a card could be UInt, but does that make sense to implement?
    
    //Swift doesn't support public readonly private readwrite, so I use underscores to kind sorta implement that.
    private var _score:Int = 0
    private let _mismatchPenalty = 2
    private let _matchBonus = 4
    private let _costToChoose = 1
    private lazy var _cards:[PlayingCard] = []
    public var score:Int {
        return self._score;
    }

    init(count:Int, deck:Deck){
        for _ in 1...count{
            //drawRandomCard returns nil if the deck is empty.
            if let card = deck.drawRandomCard(){
                self._cards.append(card as PlayingCard)
            } else {
                //Need to log that the deck is empty
                //How do I throw an exception in Swift?
                break
            }
        }
    }
    
    func cardAtIndex(index:Int) -> Card?{
        return index < self._cards.count ? self._cards[index] : nil;
    }
    
    
    func chooseCardAtIndex(index:Int){
        if let card = self.cardAtIndex(index){
            
            if !card.matched {
            
                if card.chosen{
                    card.chosen = false
                } else {
                    //match against other chosen cards
                    
                    //just iterate through the other cards in the game
                    for otherCard in self._cards{
                        
                        
                        //isChosen and isMatched are better names for getters
                        //does Swift allow getter and setter to be named differently?
                        if (otherCard.chosen && !otherCard.matched){
                            
                            //matchOtherCards expects an array of cards, so for now
                            //I put otheCard in an array all by itself...
                            let matchScore = card.matchOtherCards([otherCard])
                            
                            //matchOtherCards returns 0 if there was no match
                            if matchScore > 0{
                                self._score += matchScore * self._matchBonus
                                card.matched = true
                                otherCard.matched = true
                            } else {
                                self._score -= self._mismatchPenalty
                                otherCard.chosen = false
                            }
                        
                            break //can only choose two cards for now
                        }
                    }
                    
                    //penalty for choosing a card
                    self._score -= self._costToChoose
                    card.chosen = true
                    
                }
            }
            
        } else {
        // if index is out of bounds just get out of here
         return
        }
        
    }
    
    


}
