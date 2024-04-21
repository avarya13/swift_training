// Морской бой - Шаблон MVC

// Модель (Model) - данные и логика игры
class GameModel {
    var gridSize = 10
    var grid: [[String]] = [[]]
    var playerGrid: [[String]] = [[]]
    var numOfShips = 3
    var numOfShipsSunk = 0
    var bulletsLeft = 50
    var shipPositions: [[Int]] = [[]]
    var playerShipPositions: [[Int]] = [[]]
    var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var gameOver: Bool = false

    func validateGridAndPlaceShip(startRow: Int, endRow: Int, startCol: Int, endCol: Int) -> Bool {
        var allValid = true
    
        for r in startRow..<endRow {
            for c in startCol..<endCol {
                if grid[r][c] != "." {
                    allValid = false
                    break
                }
            }
        }
    
        if allValid {
            shipPositions.append([startRow, endRow, startCol, endCol])
            for r in startRow..<endRow {
                for c in startCol..<endCol {
                    grid[r][c] = "O"
                }
            }
        }
    
        return allValid
    }
    
    
    func tryToPlaceShipOnGrid(row: Int, col: Int, direction: String, length: Int) -> Bool {
        var startRow = row
        var endRow = row + 1
        var startCol = col
        var endCol = col + 1
    
        if direction == "left" {
            if col - length < 0 {
                return false
            }
            startCol = col - length + 1
    
        } else if direction == "right" {
            if col + length >= gridSize {
                return false
            }
            endCol = col + length
    
        } else if direction == "up" {
            if row - length < 0 {
                return false
            }
            startRow = row - length + 1
    
        } else if direction == "down" {
            if row + length >= gridSize {
                return false
            }
            endRow = row + length
        }
    
        return validateGridAndPlaceShip(startRow: startRow, endRow: endRow, startCol: startCol, endCol: endCol)
    }
    

    func createComputerGrid() {
        let rows = gridSize
        let cols = gridSize
    
        grid = Array(repeating: Array(repeating: ".", count: cols), count: rows)
    
        var numShipsPlaced = 0
        shipPositions = []
    
        while numShipsPlaced != numOfShips {
            let randomRow = Int.random(in: 0..<rows)
            let randomCol = Int.random(in: 0..<cols)
            let direction = ["left", "right", "up", "down"].randomElement()!
            let shipSize = Int.random(in: 3...5)
            
            if tryToPlaceShipOnGrid(row: randomRow, col: randomCol, direction: direction, length: shipSize) {
                numShipsPlaced += 1
            }
        }
    }


    
    
    
        func acceptValidBulletPlacement() -> (Int, Int) {
    var isValidPlacement = false
    var row = -1
    var col = -1
    
    while !isValidPlacement {
        print("Enter row (A-J) and column (0-9) such as A3: ", terminator: "")
        if let placement = readLine()?.uppercased() {
            if placement.count != 2 {
                print("Error: Please enter only one row and column such as A3")
                continue
            }
            
            let rowChar = placement[placement.startIndex]
            let colStr = placement[placement.index(after: placement.startIndex)]
            
            if let currentRow = alphabet.firstIndex(of: rowChar) {
                row = alphabet.distance(from: alphabet.startIndex, to: currentRow)
            } else {
                print("Error: Please enter letter (A-J) for row")
                continue
            }
            
            if let currentCol = Int(String(colStr)) {
                if (0..<gridSize).contains(currentCol) {
                    col = currentCol
                } else {
                    print("Error: Please enter a number (0-9) for column")
                    continue
                }
            } else {
                print("Error: Please enter a number (0-9) for column")
                continue
            }
            
            if grid[row][col] == "#" || grid[row][col] == "X" {
                print("You have already shot a bullet here, pick somewhere else")
                continue
            }
            
            if grid[row][col] == "." || grid[row][col] == "O" {
                isValidPlacement = true
            }
        }
    }
    
    
    
    return (row, col)
}




    
    func checkForShipSunk(row: Int, col: Int) -> Bool {
        for position in shipPositions {
            let startRow = position[0]
            let endRow = position[1]
            let startCol = position[2]
            let endCol = position[3]
            
            if startRow <= row && row <= endRow && startCol <= col && col <= endCol {
                for r in startRow...endRow {
                    for c in startCol...endCol {
                        if grid[r][c] != "X" {
                            return false
                        }
                    }
                }
            }
        }
        return true
    }
    
    func shootBullet() {
        let (row, col) = acceptValidBulletPlacement()
        print("")
        print("----------------------------")
    
        if grid[row][col] == "." {
            print("You missed, no ship was shot")
            grid[row][col] = "#"
        } else if grid[row][col] == "O" {
            print("You hit!", terminator: " ")
            grid[row][col] = "X"
            if checkForShipSunk(row: row, col: col) {
                print("A ship was completely sunk!")
                numOfShipsSunk += 1
            } else {
                print("A ship was shot")
            }
        }
    
        bulletsLeft -= 1
    }
    
    func checkForGameOver() {
        if numOfShips == numOfShipsSunk {
            print("Congrats you won!")
            gameOver = true
        } else if bulletsLeft <= 0 {
            print("Sorry, you lost! You ran out of bullets, try again next time!")
            gameOver = true
        }
    } 



}




// Представление (View) - отображение игрового состояния
class GameView {
    func printGrid(grid: [[String]]) {
        // Логика для отображения игрового поля
        let debugMode = true
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let rows = grid.count

        for row in 0..<rows {
            print("\(alphabet[alphabet.index(alphabet.startIndex, offsetBy: row)]) ", terminator: "")

            for col in 0..<grid[row].count {
                if grid[row][col] == "O" {
                    if debugMode {
                        print("O ", terminator: "")
                    } else {
                        print(". ", terminator: "")
                    }
                } else {
                    print("\(grid[row][col]) ", terminator: "")
                }
            }
            print("")
        }

        print("  ", terminator: "")
        for i in 0..<grid[0].count {
            print("\(i) ", terminator: "")
        }
        print("")
    }
}



// Контроллер (Controller) - обработка ввода и взаимодействие модели и представления
class GameController {
    var gameModel: GameModel
    var gameView: GameView

    init(model: GameModel, view: GameView) {
        self.gameModel = model
        self.gameView = view
    }
 
    
    func playGame() {
        print("-----Welcome to Battleships-----")
        print("You have 50 bullets to take down 8 ships, may the battle begin!")

        gameModel.createComputerGrid()

        while !gameModel.gameOver {
            gameView.printGrid(grid: gameModel.grid)
            print("Number of ships remaining: \(gameModel.numOfShips - gameModel.numOfShipsSunk)")
            print("Number of bullets left: \(gameModel.bulletsLeft)")
            gameModel.shootBullet()
            print("----------------------------")
            print("")
            gameModel.checkForGameOver()
        }
    }
}

// Инициализация и запуск игры
let model = GameModel()
let view = GameView()
let controller = GameController(model: model, view: view)
controller.playGame()
