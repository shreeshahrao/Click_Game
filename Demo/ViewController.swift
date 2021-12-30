//
//  ViewController.swift
//  Demo
//
//  Created by Shreesha Rao on 24/12/21.
//

import UIKit

enum GameState {
    case gameOver
    case playing
}

var gamePoint: Int64 = 0

class ViewController: UIViewController {
    

    
    var gameButtons = [UIButton]()
    var timer: Timer?
    var currentButton: UIButton!
    var state = GameState.gameOver

    @IBOutlet weak var startGameButton: UIButton!
    
    @IBOutlet weak var leaderBordButton: UIButton!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var badButton: UIButton!
    
    @IBOutlet weak var goodButton: UIButton!
    
    @IBOutlet weak var gameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pointsLabel.isHidden = true
        gameLabel.isHighlighted = true
        gameButtons = [goodButton , badButton]
        
        setUpFreshGameState()
    }
    
    
    @IBAction func leaderBordPressed(_ sender: UIButton) {
        let leaderBordVC = self.storyboard?.instantiateViewController(withIdentifier: "leaderBordViewController")
        leaderBordVC?.modalPresentationStyle = .fullScreen
        self.present(leaderBordVC!, animated: true, completion: nil)
    }
    

    @IBAction func startPressed(_ sender: UIButton) {
        print("Start Game was Pressed")
        state = GameState.playing
        startNewGame()
    }
    
    @IBAction func badPressed(_ sender: UIButton) {
        print("Bad Button")
        badButton.isHidden = true
        timer?.invalidate()
        gameOver()
        
    }
    
    @IBAction func goodPressed(_ sender: UIButton) {
        print("Good Button")
        gamePoint = gamePoint + 1
        updatePointsLabel(gamePoint)
        goodButton.isHidden = true
        timer?.invalidate()
        oneGameRound()
    }
    
    func startNewGame() {
        gameLabel.isHidden = true
        startGameButton.isHidden = true
        leaderBordButton.isHidden = true
        pointsLabel.isHidden = false
        gamePoint = 0
        updatePointsLabel(gamePoint)
        pointsLabel.textColor = .magenta
        pointsLabel.alpha = 0.3
        oneGameRound()
    }
    
    func oneGameRound() {
        updatePointsLabel(gamePoint)
        displayRandomButton()
        
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in
            if self.state == GameState.playing {
                if self.currentButton == self.goodButton {
                    self.gameOver()
                } else {
                    self.oneGameRound()
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpFreshGameState()
        gamePoint = 0
    }
    
    func displayRandomButton() {
        for myButton in gameButtons {
            myButton.isHidden = true
        }
        let buttonIndex = Int.random(in: 0..<gameButtons.count)
        currentButton = gameButtons[buttonIndex]
        currentButton.center = CGPoint(x: randomXCoordinate(), y: randomYCoordinate())
        currentButton.isHidden = false
    }
    
    func gameOver() {
        state = GameState.gameOver
        pointsLabel.textColor = .brown
        goToAddName()
    }
    
    func goToAddName() {
        let addNameVC = self.storyboard?.instantiateViewController(withIdentifier: "addNameViewController")
        addNameVC!.modalPresentationStyle = .fullScreen
        self.present(addNameVC!, animated: true, completion: nil)
        
        
    }
    
   
    
    func setUpFreshGameState() {
        startGameButton.isHidden = false
        leaderBordButton.isHidden = false
        gameLabel.isHidden = false
        gameLabel.isHighlighted = true
        
        for mybutton in gameButtons{
            mybutton.isHidden = true
        }
        pointsLabel.alpha = 0.15
        currentButton = goodButton
        state = GameState.gameOver
    }
    
    func randCGFloat(_ min: CGFloat, _ max: CGFloat) -> CGFloat {
        return CGFloat.random(in: min..<max)
    }
    
    func randomXCoordinate() -> CGFloat {
        let left = view.safeAreaInsets.left + currentButton.bounds.width
        let right = view.bounds.width - view.safeAreaInsets.right - currentButton.bounds.width
        
        return randCGFloat(left, right)
    }
    
    func randomYCoordinate() -> CGFloat {
        let top = view.safeAreaInsets.top + currentButton.bounds.height
        let bottom = view.bounds.height - view.safeAreaInsets.bottom - currentButton.bounds.height
        
        return randCGFloat(top, bottom)
    }
    
    func updatePointsLabel(_ newValue: Int64) {
        pointsLabel.text = "\(newValue)"
    }
    
}

