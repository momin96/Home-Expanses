import Foundation

let arr2D = [
    [1, 1, 1, 0, 0, 0],
    [0, 1, 0, 0, 0, 0],
    [1, 1, 1, 0, 0, 0],
    [0, 0, 2, 4, 4, 0],
    [0, 0, 0, 2, 0, 0],
    [0, 0, 1, 2, 4, 0]]


func hourglassSum(arr: [[Int]]) -> Int {
    
    
    //    let totalElement = 36
    //    let totalEleInHG = 9
    //let noOfElement = 3
    
    let totalHG = 36 / 9
    
    var sum = 0
    
    for rowCounter in 0..<totalHG {
        var rowSum = 0
        
        var str = ""
        
        for colCounter in 0..<totalHG {
            
            var mx = 0
            
            for row in rowCounter..<(6 - 3 + rowCounter) {
                
                if row % 2 == 0 {
                    
                    // perform loop for column
                    for col in colCounter..<(6 - 3 + colCounter) {
                        if row < 6 && col < 6 {
                            let e = arr2D[row][col]
                            mx += e
                            str.append("\(e) -> ")
                        }
                    }
                }
                else {
                    // directly fetch
                    let middle = row + colCounter
                    if row < 6 && middle < 6 {
                        let e = arr2D[row][middle]
                        mx += e
                        str.append("\(e) -> ")
                    }
                }
            }
            rowSum += mx
        }
        print(str)
        //print(rowSum)
        print("----")
        sum = max(sum, rowSum)
        
    }
    print(sum)
    return sum
}

hourglassSum(arr: arr2D)
