import Foundation

var weight = 1.0  
let input = 1.0   
let y_true = 42.0 

let lr = 0.1     
var y_pred = 0.0 
var error = 0.0  


for _ in 1...100 {
    y_pred = input * weight  
    error = y_pred - y_true  
    weight -= lr * error * input  
}


y_pred = input * weight
print(y_pred)  