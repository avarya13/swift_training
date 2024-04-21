let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)


var optionalName: String? = nil
var greeting = "Hello!"
if let name = optionalName {
  greeting = "Hello, \(name)"
}
else{
    greeting = "Hello, anyone"
}
print(greeting)



let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}


let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
var num_type = ""
for (type, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            num_type = type
        }
    }
}
print(largest)
print(num_type)

var n = 2
while n < 100 {
    n *= 2
}
print(n)
var m = 2
repeat {
    m *= 2
} while m < 100
print(m)



func greet(person: [String: String]) {
    guard let name = person["name"] else {
        print("Hello anybody! What is your name and where are you?")
        return 
    }
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}

//guard expression else {
  // statements
  // control statement: return, break, continue or throw, or it can call a function or method that doesn’t return, such as
// fatalError(_:file:line:).
//}

greet(person: ["name": "John"])
greet(person: ["name": "John", "location": "Moscow"])
greet(person: ["location": "Moscow"])

// Result:

//Hello John!
//I hope the weather is nice near you.
//Hello John!
//I hope the weather is nice in Moscow.
//Hello anybody! What is your name and where are you?
