# boolDaxa

Boolean set algebra abstractions over bit operations on integer types. 

Synopsis   
--------
**Caution: This library has yet to be tested in a submission to the Apple App Store, which means 
caution should be taken in development code.**

Provides access to boolean set algebra methods (thru the SetAlgebra protocol) with near O(1) 
computation of set functions (union/disjoint/intersection etc). 

This is accomplished by using bit operations on integer values. True values are mapped to 'on' 
bits (1s) and false values to 'off' bits (0's). Bitwise operations are than used to provide 
default behaviour for SetAlgebra functions, with up to 64 comparisons (on 64bit machines) 
per processor cycle or 32 comparisons (on 32bit machines).

Currently, using integer values limits the set size maximum to 64 indexes (Int64 and UInt64). 
Work is being done to implement a custom integer type that removes that limit, but since performance 
is a key design objective of this library, it may take a while. 

Abstraction can also be made easier to manage. By adopting the BoolSet protocol, an abstract data type 
can be given specificity. This improves readability, a cornerstone of composable design and shortening 
development time.

BoolSet extends the Swift Standard Library protocols SetAlgebra and MutableCollection. All 
types that conform to BoolSet will inherently conform to SetAlgebra and MutableCollection. 

Motivation 
----------
I wanted to balance code write speed and performance. By abstracting from bit operations on processors 
(near constant time execution) onto set algebra methods, performance of bit operations can be maintained 
while quickening development time (simple BoolSet protocol adoption). It also allows someone who is familiar 
with the SetAlgebra functions in swift to more easily understand BoolSet's use, instead of requiring a learning
of bit operations. 

Motivation for this library was taken from Swift's OptionSet type, also a SetAlgebra abstraction over bit 
operations. 

Code Example  
------------
To implement a Boolean SetAlgebra type, implement the two BoolSet protocol requirements; a bits read only 
attribute and an initializer that takes a bits parameter. 
```swift
struct DataName : BoolSet {

  let bits : Int32 //Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64 are all compatible
  
  init(bits: Int32) { //must be same type as bits 
    self.bits = bits 
  }
}
```
The bitWidth of the integer (number on the end of the integer name) needs to be larger than your expected 
set size. So for a set of size 54, Int64 or UInt64 types are plausible. You should declare no other attributes 
for your BoolSet type besides the 'bits' attribute. If you require more attributes, consider using your BoolSet 
type as an attribute for another class/struct. 

A BoolSet can be initialized from an array literal ('[...]'), by providing the indexes of all values that 
you want to set as 'true'. Initializing a BoolSet with no parameters, sets all elements to false. BoolSets 
can also be initialzed from other BoolSets with the same 'bits' type.
```swift
let data = [3, 8, 23, 5, 19] //indexes 3, 8, 23, 5 and 19 will be set to true, all other indexes will be false
  
let dataAllFalse = DataName() //all indexes will be false 

let data2 = DataName(data) //will have same true/false values as dataTrue 
```
The design decision of providing only indexes for the array literal, instead of a dictionary tuple (Index, Bool),
was to make code less verbose. Though it does effect readability. 

If you need a code interface for SetAlgebra element functions, it is recommended you use the collection subscript methods 
for contains/update/remove/insert. Otherwise it would require a cast to BoolSetIndex(Int, Bool). Since all values in a 
BoolSet are either true or false, asking a BoolSet if it contains true or false does not provide enough fideltiy about 
the state of the BoolSet. 

```swift
var element : Bool = data[3] //data does contain a true at index 3, so will return true

data[3] = false //index 3 is now set to false 
```

Installation 
-------------
**System Requirements:** iOS 8+ 

boolDaxa can be included in one of two ways:
 
**Carthage**

- Add boolDaxa to your Cartfile
- Run `carthage update`
- Drag the relevant copy of boolDaxa into your project.
- Expand the Link Binary With Libraries phase
- Click the + and add boolDaxa
- Click the + at the top left corner to add a Copy Files build phase
- Set the directory to `Frameworks`
- Click the + and add boolDaxa
 
**Framework**

- Drag boolDaxa.xcodeproj into your project tree
  as a subproject
- Under your project's Build Phases, expand Target Dependencies
- Click the + and add boolDaxa
- Expand the Link Binary With Libraries phase
- Click the + and add boolDaxa
- Click the + at the top left corner to add a Copy Files build phase
- Set the directory to Frameworks
- Click the + and add boolDaxa

API Reference 
-------------
For a list of SetAlgebra and MutableCollection functions that are accessible thru the BoolSet 
protocol, see the Swift standard docs: [SetAlgebra](http://swiftdoc.org/v3.0/protocol/SetAlgebra/), [MutableCollection](http://swiftdoc.org/v3.0/protocol/MutableCollection/)
