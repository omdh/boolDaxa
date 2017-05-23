//
//  BoolSetSequence.swift
//  boolDaxaTest
//
//  Created by Andrew Moriarity on 2017-05-21.
//  Copyright © 2017 AndrewMoriarity. All rights reserved.
//

//#MARK: - BoolSet Sequence conformity

/*
 / Allows a BoolSet type to gain Sequence conformity through default methods centered around the Self.Bits type.
 */
public extension BoolSet {
    
    public typealias Iterator = BoolSetIterator<Bits>
    
    /*
     / All BoolSet types can default to BoolSetIterator, which converts all bits in self.bits into boolean values
     */
    public func makeIterator() -> BoolSetIterator<Bits> {
        return BoolSetIterator<Bits>(bits: self.bits, bitWidth: Bits(Bits.bitWidth))
    }
}
