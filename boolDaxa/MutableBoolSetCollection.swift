//
//  MutableBoolSetCollection.swift
//  boolDaxaTest
//
//  Created by Andrew Moriarity on 2017-05-21.
//  Copyright © 2017 AndrewMoriarity. All rights reserved.
//

//#MARK: - BoolSet MutableCollection conformity

/*
 / Allows a BoolSet type to gain MutableCollection conformity through default methods centered around the Self.Bits type.
 */
public extension BoolSet where Self : MutableCollection {
    /*
     / Access a BoolSet index in a bits to get wether the bit is turned 'on' (true) or 'off' (false)
     / get: Runs in 3 operations (2 bit operations and a cast)
     / set: Runs in 3 opeartions to set 'on', and 4 for 'off', last operation of both is a cast
     */
    public subscript(index: Int) -> Bool {
        get{
            precondition(index <= self.endIndex, "Index above BoolSet index range")
            precondition(index >= self.startIndex, "Index below BoolSet index range")
            
            return (self.bits & (1 << Bits(index))) > 0
        } set (newValue) {
            precondition(index <= self.endIndex, "Index above BoolSet index range")
            precondition(index >= self.startIndex, "Index below BoolSet index range")
            
            self = Self(bits: newValue ? self.bits | (1 << Bits(index)) : self.bits & ~(1 << Bits(index)))
        }
    }
}
