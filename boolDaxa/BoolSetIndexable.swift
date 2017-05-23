//
//  MutableBoolSet.swift
//  bitDaxaTemp
//
//  Created by Andrew Moriarity on 2017-05-17.
//  Copyright © 2017 AndrewMoriarity. All rights reserved.
//

//#MARK: - BoolSetIndexable
/*
/*
 /
 */
public protocol BoolSetIndexable : BoolSet {}

public extension BoolSetIndexable {
    /*
     / 
     */
    public typealias BoolIndexes = BoolSetIndexer<Bits>
    
    /*
     / Iterates over all indexes that have the boolean type supplied
     / If provided with a false value, will inverse the bits in the bool set and iterate over its 'on' values. If provided true there is no need ot inverse, and it will just return an iterator over the bool sets 'on' values
     */
    public func indexes(for boolean: Bool) -> BoolSetIndexer<Bits> {
        return BoolSetIndexer<Bits>(bits: boolean ? self.bits : ~self.bits) 
    }
}
*/
