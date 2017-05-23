//
//  BoolSetIterator.swift
//  boolDaxaTest
//
//  Created by Andrew Moriarity on 2017-05-21.
//  Copyright © 2017 AndrewMoriarity. All rights reserved.
//

//#MARK: - BoolSet Iterator

/*
 / 'Walks' the bits for a BoolSet
 */
public struct BoolSetIterator<Bits> : IteratorProtocol where Bits : FixedWidthInteger {
    
    public typealias Element = Bool //All elements of the BoolSet are Bools
    
    private let bits : Bits //the Integer being iterated over
    private let endIndex : Bits //bitWidth of the UInt bitarray (casted to self, instead of Int)
    
    private var currentIndex : Bits //represents the current index in the next? call
    
    /*
     / Used by Boolsets to iterate over all elements from 0 (startIndex) to their endIndex (one less than the bitWidth of the UnsignedInteger)
     / Pass by value is used (cheap for integer types) to provide stability in threading.
     / 'bitWidth' is available from the UIntBitManagement protocol, but would require a cast (not contained within a stdlib protocol, future or present)
     */
    internal init(bits: Bits, bitWidth: Bits) {
        self.init(bitsSlice: bits, startIndex: 0, endIndex: bitWidth - 1)
    }
    
    /*
     / Used by BoolSet slices to iterate over their range of bits. The range of the iteration includes both the start and end index.
     */
    internal init(bitsSlice: Bits, startIndex: Bits, endIndex: Bits) {
        self.bits = bitsSlice
        
        self.currentIndex = startIndex
        self.endIndex = endIndex
    }
    
    /*
     / Uses bit shifting to decrease calls to subscript and conversion from UInt type to Int (and vice versa)
     */
    public mutating func next() -> Bool? {
        if self.currentIndex <= self.endIndex {
            let isolatedBit : Bits = self.bits & (1 << self.currentIndex)
            self.currentIndex = self.currentIndex + 1
            return isolatedBit > 0 ? true : false
        } else {
            return nil
        }
    }
}
