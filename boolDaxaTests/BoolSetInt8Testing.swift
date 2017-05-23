//
//  BoolSetTesting.swift
//  bitDaxa
//
//  Created by Andrew Moriarity on 2017-05-21.
//
//

import XCTest

/*
 /
 */
protocol SetAlgebraTesting : SetAlgebra {
    
    static func random() -> Self
    
    static func randomElement() -> Element
    
}

struct BoolSetTest<Integer : FixedWidthInteger> : BoolSet, SetAlgebraTesting {
        
    let bits : Integer
    
    init(bits: Integer) {
        self.bits = bits
    }
    
    static func random() -> BoolSetTest<Integer> {
        return BoolSetTest(bits: Integer(Int(arc4random_uniform(UInt32(Int16.max)))))
    }
    
    static func randomElement() -> BoolSetIndex<Integer> {
        return BoolSetIndex<Integer>(Int(arc4random_uniform(UInt32(Integer.bitWidth))), true)
    }
}

class BoolSetTestingCases : XCTestCase {
        
    let element : BoolSetTest<Int16>.Element = BoolSetTest<Int16>.randomElement()
    
    let y : BoolSetTest<Int16> = BoolSetTest<Int16>.random()
    let x : BoolSetTest<Int16> = BoolSetTest<Int16>.random()
    
    let emptyByArray : BoolSetTest<Int16> = []
    
    var c : BoolSetTest<Int16> = [5, 2]
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    //#MARK: SetAlgebra conformity
    
    /*
     / tests all the rules associated SetAlgebra conformity
     */
    func testEquality() { //S() == []
        XCTAssertEqual(BoolSetTest<Int16>(), [], "Empty set by init and empty set by array literal not equal.")
    }
    func testElementIntersection() { //x.intersection(x) == x
        XCTAssertEqual(x.intersection(x), x, "Intersection of set with self, is not self.")
    }
    func testSetIntersection() { //x.intersection([]) == []
        XCTAssertEqual(x.intersection([]), [], "Intersection of set with empty is not empty.")
    }
    func testElementUnion() { //x.union(x) == x
        XCTAssertEqual(x.union(x), x, "Union of set with self, is not self.")
    }
    func testSetUnion() { //x.union([]) == x
        XCTAssertEqual(x.union([]), x, "Empty set by init and empty set by array literal not equal.")
    }
    func testContains() { //x.contains(e) implies x.union(y).contains(e)
        //is failable if the element is not in x but is in y 
        XCTAssertEqual(x.contains(element) == true, x.union(y).contains(element), "Union of set with another set does not contain an element in the original set.")
    }
    func testUnionContains() { //x.union(y).contains(e) implies x.contains(e) || y.contains(e)
        XCTAssertEqual(x.union(y).contains(element), x.contains(element) || y.contains(element), "An element from the union of two sets is not contained in either set.")
    }
    func testIntersectionContains() { //x.contains(e) && y.contains(e) if and only if x.intersection(y).contains(e)
        XCTAssertEqual(x.contains(element) && y.contains(element), x.intersection(y).contains(element), "An element from the intersection of two sets is not contained in either set.")
    }
    func testSubsetSuperset() { //x.isSubset(of: y) if and only if y.isSuperset(of: x)
        XCTAssertEqual(x.isSubset(of: y), y.isSuperset(of: x), "The subset of a set does not have that set as its superset.")
    }
    func testStrictSuperset(){ //x.isStrictSuperset(of: y) if and only if x.isSuperset(of: y) && x != y
        XCTAssertEqual(x.isStrictSuperset(of: y), x.isSuperset(of: y) && x != y, "The strict superset of a set is not also its superset.")
    }
    func testStrictySubset() { //x.isStrictSubset(of: y) if and only if x.isSubset(of: y) && x != y
        XCTAssertEqual(x.isStrictSubset(of: y), x.isSubset(of: y) && x != y, "The strict subset of a set is not also its subset.")
    }
    
    
    
    func testCollectionAccess() {
        
        c[4] = false
        
        for (index, bool) in c.enumerated() {
            if index == 4 {
                XCTAssertEqual(bool, false, "Specified index is not as set.")
            } else if index == 2 || index == 5 {
                XCTAssertEqual(bool, true, "Specified index is not as set.")
            }
        }
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
