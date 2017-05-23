//
//  BoolSetIndexer.swift
//  boolDaxaTest
//
//  Created by Andrew Moriarity on 2017-05-21.
//  Copyright © 2017 AndrewMoriarity. All rights reserved.
//
/*
/*
 / 
 */
public struct BoolSetIndexer<Bits> : IteratorProtocol where Bits : FixedWidthInteger {
    
    public typealias Element = Int
    
    private var shiftCounter : Int
    
    private var bits : Bits
    
    internal init(bits: Bits) {
        self.bits = bits
        
        self.shiftCounter = 0
    }
    
    /*
     /  
     */
    public mutating func next() -> Int? {
        if self.bits == 0 { //bits have no 'on' indexes left
            return nil
        } else {
            
            
            let index : Bits = self.bits & ~(self.bits - 1) //finds lowest 'on' bit
            self.bits = self.bits ^ index //remove lowest bit
            
            //mimic 'leadingZeros' method, by shifting to
            while (self.bits >> Bits(self.shiftCounter)) > 1{
                self.shiftCounter = self.shiftCounter + 1 //increment shift counter to next index
            }
            
            return Int(shiftCounter)
        }
    }
}
*/
