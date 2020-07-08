import UIKit

class TestClass {
    
    var value: String?
    
    init(value: String) {
        self.value = value
    }
}

struct TestStruct {
    var value: String?
    
    init(from testClass: TestClass) {
        self.value = testClass.value
    }
}


let c = TestClass(value: "Test Class value string")
var s = TestStruct(from: c)

print("Class: ", c, c.value)
print("struct: ", s)
print("------")

c.value = "New class string"

print("Class: ", c, c.value)
print("struct: ", s)
print("------")

s.value = "new"

print("Class: ", c, c.value)
print("struct: ", s)
print("------")

