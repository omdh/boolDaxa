//
//  BoolSetCollection .swift
//  boolDaxaTest
//
//  Created by Andrew Moriarity on 2017-05-21.
//  Copyright © 2017 AndrewMoriarity. All rights reserved.
//

//#MARK: - BoolSet Collection conformity 

/*
 / Allows a BoolSet type to gain Collection conformity through default methods centered around the Self.Bits type.
 */
public extension BoolSet {
        
    public typealias IndexDistance = Int
    
    public typealias SubSequence = BoolSetSlice<Bits>
    
    /*
     / Common collection attributes that gain effiency from using BitManagement methods 
     */
    public var count : Int { return Bits.bitWidth }
    
    public var first : Bool? { return (self.bits & 1 > 0) ? true : false } //returns wether the first bit is on or off, since there will always be a first element
    
    public var startIndex : Int { return 0 }
    
    public var endIndex : Int { return Bits.bitWidth - 1 }
    
    /*
     / If the Bits type is 0 (all bits are 'off') then the bool set is considered empty (no 'on/true' values are present)
     */
    public var isEmpty : Bool {return self.bits == 0 }
    
    /*
     / Bullshit collection method
     */
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    /*
     / Returns a copy of self with only the indexes of self turned on.
     */
    public subscript(bounds: Range<Int>) -> BoolSetSlice<Bits> {
        get {
            precondition(bounds.upperBound <= self.endIndex, "Range upperBound above BoolSet index range")
            precondition(bounds.lowerBound >= self.startIndex, "Range lowerBound below BoolSet index range")
            
            return BoolSetSlice<Bits>(bits: self.bits, range: bounds)
        }
    }
}









