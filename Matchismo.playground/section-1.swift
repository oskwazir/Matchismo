// Playground - noun: a place where people can play

import UIKit


// a class for a generic card
class Card{
    
    var content:String = ""
    
    var chosen:Bool = false;
    var matched:Bool = false;
    
    func matchOtherCards(otherCards:[Card]) -> (Int){
        var score = 0;
        
        for card in otherCards{
            if(card.content == self.content){
                score = 1;
            }
        }
        
        return score
        
    }
    
}

//a class for a deck of any kind of card
class Deck{
    
    private var cards:[Card] = []
    
    func addCard(#card:Card, isAtTop:Bool = false){
        
        if isAtTop {
            self.cards.insert(card, atIndex:0);
        } else {
            self.cards.append(card);
        }
    }
    
    func drawRandomCard() -> Card?{
        let index = Int(arc4random_uniform(UInt32(self.cards.count)))
        //once cards are exhausted need to return nil
        if self.cards.isEmpty {
            return nil
        }
        let randomCard:Card = self.cards[index]
        self.cards.removeAtIndex(index);
        
        return randomCard;
    }
}

//a subclass of Card
class PlayingCard:Card{
    
    let suit:String?
    
    let rank:Int?
    
    // validSuits and rankStrings are type properties.
    // No need for individual instances to dupe these properties
    public class var validSuits:[String] {
    return ["\u{2665}","\u{2666}","\u{2663}","\u{2660}"]
    }
    
    public class var rankStrings:[String] {
    return ["?","A","2","3","4","5","6","7","8","9","10","J","Q","K"]
    }
    
    init(suit:String,rank:Int){
        super.init()
        if(contains(PlayingCard.validSuits, suit)){
            self.suit = suit;
        }
        
        self.rank = rank;
        
        self.content = "\(PlayingCard.rankStrings[self.rank!])\(self.suit!)"
    }
    
    class func maxRank() -> Int {
        return PlayingCard.rankStrings.count - 1
    }
}

class PlayingCardDeck: Deck{
    
    init() {
        super.init()
        for suit:String in PlayingCard.validSuits{
            for(var rank = 1; rank <= PlayingCard.maxRank();rank++){
                let card:PlayingCard = PlayingCard(suit: suit, rank: rank)
                self.addCard(card: card)
            }
        }
    }
}

var cardCollection:[Card] = []
let deck:Deck = PlayingCardDeck()

for index in 1...53{
    if let card = deck.drawRandomCard(){
        cardCollection.append(card)
    } else {
        println("deck ran out of cards after \(index)")
    }
}

let foo = [1,2,3,4,5]
let index = 100
let number:Int? = index < foo.count ? foo[index] : nil

class CardMatchingGame{
    
    //Check if swift has public readonly, private readwrite support
    //or do I need to keep using underscores?
    private var _score:Int = 0;
    private lazy var cards:[Card] = []
    public var score:Int {
    return self._score;
    }
    
    
    // check swift property accessors.
    // I forgot that too.
    
    init(count:Int, deck:Deck){
        for index in 0..<count{
            //drawRandomCard returns nil if the deck empties out.
            if let card = deck.drawRandomCard(){
                self.cards.append(card)
            } else {
                ///How to raise an error in Swift?
                break
            }
            
        }
    }
    
    func cardAtIndex(index:Int) -> Card{
        //Swift returns MAX_INT if you access outside it's bounds???
        //check on that.
        return self.cards[index];
    }
    
    func chooseCardAtIndex(index:UInt){
        
    }
}






