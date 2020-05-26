import Foundation

//: # Protocols
//: Protocols are, as per Apple's definition in the _Swift Programming Language_ book:
//:
//: "... a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol."
//:
//: The below example shows a protocol that requires conforming types have a particular property defined.


// Getter - ability to read access
// Setter - write access

protocol fullyNamed {
    var fullName: String { get }
}

// Step1 - Adoption : fullyNamed
// Step2 - Conformance - adds the properties

struct Person: fullyNamed {
    var fullName: String
}

let Johny = Person(fullName: "Johnny Hicks")
let Donna = Person(fullName: "Donna Mayfield")

print(Donna.fullName)

class Starship: fullyNamed {
    var prefix: String?
    var name: String
    
    init (name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    // Computed property (calculated property)
    var fullName: String {
        // ternary operators
        return (prefix != nil ? prefix! + " ": "") + self.name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName
ncc1701.prefix
ncc1701.name

var fireFly = Starship(name: "Serenity")
fireFly.fullName
fireFly.prefix

//: Protocols can also require that conforming types implement certain methods.

protocol GeneratesRandomNumbers {
    func random() -> Int
}

class OneThroughTen: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...10)
    }
}

let rand = OneThroughTen()
rand.random()

//: Using built-in Protocols

if "John" == "john" {
    print("They are the same")
}

extension Starship: Equatable {
    static func == (lhs: Starship, rhs: Starship) -> Bool {
        if lhs.fullName == rhs.fullName { return true }
        else { return false }
    }
}

if ncc1701 == fireFly {
    print("Same Starship")
}

struct Person2 {
    static let species = "Boo"
}

print(Person2.species)

//: ## Protocols as Types
class Dice {
    let sides: Int
    let generator: GeneratesRandomNumbers // the generator can be of any type that conforms to the protocol GeneratesRandomNumbers
    
    init (sides: Int, generator: GeneratesRandomNumbers) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() % sides) + 1
        // Dice has 6 sides
        // 1 % 6 = 5 + 1 = 6
        // 2 % 6 = 4 + 1 = 5
        // ...
        // 10 % 6  = 4 + 1 = 5
    }
}

var d6 = Dice(sides: 6, generator: OneThroughTen())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}



