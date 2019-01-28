//
//  GameElements.swift
//  SkyConquer
//
//  Created by Marko Splajt on 05/04/2018.
//  Copyright © 2018 MarkoSplajt. All rights reserved.
//

import Foundation
import SpriteKit

let totalScoreLbl = SKLabelNode()

struct CollisionBitMask
{
    static let groundCategory: UInt32 = 0x1 << 0
    static let pillarCategory: UInt32 = 0x1 << 1
    static let batCategory: UInt32 = 0x1 << 2
    static let foodCategory: UInt32 = 0x1 << 3
    static let midWallCategory: UInt32 = 0x1 << 4
    static let bombCategory: UInt32 = 0x1 << 5
    static let owlCategory: UInt32 = 0x1 << 6
    static let eagleBirdCategory: UInt32 = 0x1 << 7
    //static let munitionCategory: UInt32 = 0x1 << 8
}

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom

let batView = UIImageView(image: UIImage(named: "favouritesView"))
let owlView = UIImageView(image: UIImage(named: "favouritesView"))
let eagleBirdView = UIImageView(image: UIImage(named: "favouritesView"))

extension GameScene
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if (isGameStarted == true)
        {
            self.bat.run(repeatActionBat)
            self.owl.run(repeatActionOwl)
            self.eagleBird.run(repeatActionEagleBird)
            
            switch  (deviceIdiom)
            {
                
            case .phone:
                switch screenWidth
                {
                case 0...320: // iPhone 5, SE
                    bat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    bat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 45))
                    
                    owl.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    owl.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 35))
                    
                    eagleBird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    eagleBird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 45))
                    
                case 321...375: // iPhone 6, 7, 8
                    bat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    bat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
                    
                    owl.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    owl.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 45))
                    
                    eagleBird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    eagleBird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 55))
                    
                case 376...414: // iPhone 6+, 7+, 8+
                    bat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    bat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 75))
                    
                    owl.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    owl.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
                    
                    eagleBird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    eagleBird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 75))
                    
                default:
                    break
                }
            default:
                break
            }
            
            if UIDevice().userInterfaceIdiom == .phone
            {
                switch UIScreen.main.nativeBounds.height
                {
                case 1792: // iPhone XR
                    bat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    bat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 55))
                    
                    owl.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    owl.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
                    
                    eagleBird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    eagleBird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 55))
                case 2436: // iPhone X, Xs
                    bat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    bat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
                    
                    owl.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    owl.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 45))
                    
                    eagleBird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    eagleBird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
                case 2688: // iPhone Xs Max
                    bat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    bat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 75))
                    
                    owl.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    owl.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 55))
                    
                    eagleBird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    eagleBird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 75))
                    
                default:
                    print("unknown")
                }
            }
        }
        
        for touch in touches
        {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
           
            if (!isTimerStarted && !isGameStarted)
            {
                if (node.name == "playerOne")
                {
                    chooseLbl.run(SKAction.scale(to: 0.5, duration: 0.3), completion:
                        {
                        self.chooseLbl.removeFromParent()
                    })
                    bat.run(SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.midY), duration: 1))
                    timerLabel = createTimerLbl()
                    self.addChild(timerLabel)
                    runTimer()
                    updateTimer()
                    owl.removeFromParent()
                    eagleBird.removeFromParent()
                    batView.removeFromSuperview()
                    owlView.removeFromSuperview()
                    eagleBirdView.removeFromSuperview()
                }
                else if (node.name == "playerTwo")
                {
                    chooseLbl.run(SKAction.scale(to: 0.5, duration: 0.3), completion:
                        {
                        self.chooseLbl.removeFromParent()
                    })
                    owl.run(SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.midY), duration: 1))
                    timerLabel = createTimerLbl()
                    self.addChild(timerLabel)
                    runTimer()
                    updateTimer()
                    bat.removeFromParent()
                    eagleBird.removeFromParent()
                    batView.removeFromSuperview()
                    owlView.removeFromSuperview()
                    eagleBirdView.removeFromSuperview()
                }
                else if (node.name == "playerThree")
                {
                    chooseLbl.run(SKAction.scale(to: 0.5, duration: 0.3), completion:
                        {
                        self.chooseLbl.removeFromParent()
                    })
                    eagleBird.run(SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.midY), duration: 1))
                    timerLabel = createTimerLbl()
                    self.addChild(timerLabel)
                    runTimer()
                    updateTimer()
                    bat.removeFromParent()
                    owl.removeFromParent()
                    batView.removeFromSuperview()
                    owlView.removeFromSuperview()
                    eagleBirdView.removeFromSuperview()
                }
            }
            
            if isDead == true
            {
                if restartBtn.contains(location)
                {
                    if UserDefaults.standard.object(forKey: "highestScore") != nil
                    {
                        let hScore = UserDefaults.standard.integer(forKey: "highestScore")
                        if hScore < Int(scoreLbl.text!)! {
                            UserDefaults.standard.set(scoreLbl.text, forKey: "highestScore")
                        }
                    }
                    else
                    {
                        UserDefaults.standard.set(0, forKey: "highestScore")
                    }
                    restartScene()
                    //gameSeconds = 21
                }
            }
            else
            {
                if pauseBtn.contains(location)
                {
                    if self.isPaused == false
                    {
                        self.isPaused = true
                        pauseBtn.texture = SKTexture(imageNamed: "play")
                        //gameTimer.invalidate()
                        //jumpButton.isHidden = true
                        //fireButton.isEnabled = false
                    }
                    else if self.isPaused == true || isDead == true
                    {
                        self.isPaused = false
                        pauseBtn.texture = SKTexture(imageNamed: "pause")
                        /*runGameTimer()
                        updateGameTimer()*/
                        /*jumpButton.isEnabled = true
                        jumpButton.isHidden = false*/
                        //fireButton.isEnabled = true
                    }
                }
            }
        }
    }
    
    func createBat() -> SKSpriteNode
    {
        let bat = SKSpriteNode(texture: SKTextureAtlas(named: "player").textureNamed("bat1"))
        
        switch  (deviceIdiom)
        {
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                bat.size = CGSize(width: 60, height: 60)
                bat.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 85)
                batView.frame = CGRect(x: self.frame.midX - 45, y: self.frame.midY + 40, width: 90.0, height: 90.0)
                
            case 321...375: // iPhone 6, 7, 8, X, Xs
                bat.size = CGSize(width: 70, height: 70)
                bat.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
                batView.frame = CGRect(x: self.frame.midX - 50, y: self.frame.midY + 50, width: 100.0, height: 100.0)
                
            case 376...414: // iPhone 6+, 7+, 8+, XR, Xs Max
                bat.size = CGSize(width: 80, height: 80)
                bat.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 110)
                batView.frame = CGRect(x: self.frame.midX - 55, y: self.frame.midY + 55, width: 110.0, height: 110.0)
                
            default:
                break
            }
        default:
            break
        }
        
        bat.name = "playerOne"
        bat.physicsBody = SKPhysicsBody(circleOfRadius: bat.size.width / 2)
        bat.physicsBody?.linearDamping = 1.1
        bat.physicsBody?.restitution = 0
        bat.zPosition = 3
        
        bat.physicsBody?.categoryBitMask = CollisionBitMask.batCategory
        bat.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
        bat.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory | CollisionBitMask.foodCategory | CollisionBitMask.bombCategory | CollisionBitMask.midWallCategory
        bat.physicsBody?.affectedByGravity = false
        bat.physicsBody?.isDynamic = true
        
        batView.contentMode = .scaleToFill
        view?.addSubview(batView)

        return bat
    }
    
    func createOwl() -> SKSpriteNode
    {
        let owl = SKSpriteNode(texture: SKTextureAtlas(named: "playerTwo").textureNamed("owl1"))
        
        switch  (deviceIdiom)
        {
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                owl.size = CGSize(width: 50, height: 50)
                owl.position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY - 85)
                owlView.frame = CGRect(x: self.frame.midX + 55, y: self.frame.midY + 40, width: 90.0, height: 90.0)

            case 321...375: // iPhone 6, 7, 8, X, Xs
                owl.size = CGSize(width: 60, height: 60)
                owl.position = CGPoint(x: self.frame.midX + 120, y: self.frame.midY - 100)
                owlView.frame = CGRect(x: self.frame.midX + 65, y: self.frame.midY + 50, width: 100.0, height: 100.0)

            case 376...414: // iPhone 6+, 7+, 8+, XR, Xs Max
                owl.size = CGSize(width: 70, height: 70)
                owl.position = CGPoint(x: self.frame.midX + 132, y: self.frame.midY - 110)
                owlView.frame = CGRect(x: self.frame.midX + 75, y: self.frame.midY + 55, width: 110.0, height: 110.0)

            default:
                break
            }
        default:
            break
        }
        
        owl.name = "playerTwo"
        owl.physicsBody = SKPhysicsBody(circleOfRadius: owl.size.width / 2)
        owl.physicsBody?.linearDamping = 1.1
        owl.physicsBody?.restitution = 0
        owl.zPosition = 3
        
        owl.physicsBody?.categoryBitMask = CollisionBitMask.owlCategory
        owl.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
        owl.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory | CollisionBitMask.foodCategory | CollisionBitMask.bombCategory | CollisionBitMask.midWallCategory
        owl.physicsBody?.affectedByGravity = false
        owl.physicsBody?.isDynamic = true
        
        owlView.contentMode = .scaleToFill
        view?.addSubview(owlView)
        
        return owl
    }
    
    func createEagleBird() -> SKSpriteNode {
        
        let eagleBird = SKSpriteNode(texture: SKTextureAtlas(named: "playerThree").textureNamed("eagle1"))
        
        switch  (deviceIdiom)
        {
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                eagleBird.size = CGSize(width: 60, height: 60)
                eagleBird.position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY - 85)
                eagleBirdView.frame = CGRect(x: self.frame.midX - 145, y: self.frame.midY + 40, width: 90.0, height: 90.0)

            case 321...375: // iPhone 6, 7, 8, X, Xs
                eagleBird.size = CGSize(width: 70, height: 70)
                eagleBird.position = CGPoint(x: self.frame.midX - 120, y: self.frame.midY - 100)
                eagleBirdView.frame = CGRect(x: self.frame.midX - 170, y: self.frame.midY + 50, width: 100.0, height: 100.0)

            case 376...414: // iPhone 6+, 7+, 8+, XR, Xs Max
                eagleBird.size = CGSize(width: 80, height: 80)
                eagleBird.position = CGPoint(x: self.frame.midX - 132, y: self.frame.midY - 110)
                eagleBirdView.frame = CGRect(x: self.frame.midX - 190, y: self.frame.midY + 55, width: 110.0, height: 110.0)

            default:
                break
            }
        default:
            break
        }
        
        eagleBird.name = "playerThree"
        eagleBird.physicsBody = SKPhysicsBody(circleOfRadius: eagleBird.size.width / 2)
        eagleBird.physicsBody?.linearDamping = 1.1
        eagleBird.physicsBody?.restitution = 0
        eagleBird.zPosition = 3
        
        eagleBird.physicsBody?.categoryBitMask = CollisionBitMask.eagleBirdCategory
        eagleBird.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
        eagleBird.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory | CollisionBitMask.foodCategory | CollisionBitMask.bombCategory | CollisionBitMask.midWallCategory
        eagleBird.physicsBody?.affectedByGravity = false
        eagleBird.physicsBody?.isDynamic = true
        
        eagleBirdView.contentMode = .scaleToFill
        view?.addSubview(eagleBirdView)
        
        return eagleBird
        
    }
    
    func createHighScoreLbl() -> SKLabelNode
    {
        
        let highScoreLbl = SKLabelNode()
        
        switch (deviceIdiom)
        {
            
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                highScoreLbl.fontSize = 20
                highScoreLbl.position = CGPoint(x: self.frame.width - 70, y: self.frame.height - 25)
                
            case 321...375: // iPhone 6, 7, 8, X
                highScoreLbl.fontSize = 25
                highScoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 30)
                
            case 376...414: // iPhone 6+, 7+, 8+
                highScoreLbl.fontSize = 28
                highScoreLbl.position = CGPoint(x: self.frame.width - 90, y: self.frame.height - 34)
                
            default:
                break
            }
        default:
            break
        }
        
        if UIDevice().userInterfaceIdiom == .phone // iPhone X
        {
            switch UIScreen.main.nativeBounds.height
            {
            case 1792: // iPhone XR
                highScoreLbl.position = CGPoint(x: self.frame.width - 90, y: self.frame.height - 60)
            case 2436: // iPhone X, Xs
                highScoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 55)
            case 2688: // iPhone Xs Max
                highScoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 60)
            default:
                print("unknown")
            }
        }
        
        if let highestScore = UserDefaults.standard.object(forKey: "highestScore")
        {
            highScoreLbl.text = "Highscore: \(highestScore)"
        }
        else
        {
            highScoreLbl.text = "Highscore: 0"
        }
        highScoreLbl.zPosition = 5
        highScoreLbl.fontName = "Dwerneck"
        return highScoreLbl
    }
    
    func createTotalScoreLbl() -> SKLabelNode
    {
        switch (deviceIdiom)
        {
            
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                totalScoreLbl.fontSize = 20
                totalScoreLbl.position = CGPoint(x: self.frame.width - 240, y: self.frame.height - 25)
            case 321...375: // iPhone 6, 7, 8, X
                totalScoreLbl.fontSize = 25
                totalScoreLbl.position = CGPoint(x: self.frame.width - 280, y: self.frame.height - 30)
            case 376...414: // iPhone 6+, 7+, 8+
                totalScoreLbl.fontSize = 28
                totalScoreLbl.position = CGPoint(x: self.frame.width - 300, y: self.frame.height - 35)
            default:
                break
            }
        default:
            break
        }
        
        if UIDevice().userInterfaceIdiom == .phone // iPhone X
        {
            switch UIScreen.main.nativeBounds.height
            {
            case 1792: // iPhone XR
                totalScoreLbl.position = CGPoint(x: self.frame.width - 320, y: self.frame.height - 60)
            case 2436: // iPhone X, Xs
                totalScoreLbl.position = CGPoint(x: self.frame.width - 290, y: self.frame.height - 55)
            case 2688: // iPhone Xs Max
                totalScoreLbl.position = CGPoint(x: self.frame.width - 320, y: self.frame.height - 60)
            default:
                print("unknown")
            }
        }
        
        totalScoreLbl.zPosition = 6
        totalScoreLbl.fontName = "Dwerneck"
        totalScoreLbl.text = "Total Score: \(totalScore)"
        return totalScoreLbl
    }
    
    func createLogoLbl() -> SKLabelNode
    {
        
        let logoLbl = SKLabelNode(fontNamed: "Decay")
        
        switch (deviceIdiom)
        {
            
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                logoLbl.fontSize = 24
                logoLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 140)

            case 321...375: // iPhone 6, 7, 8
                logoLbl.fontSize = 28
                logoLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 160)

            case 376...414: // iPhone 6+, 7+, 8+
                logoLbl.fontSize = 31
                logoLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 180)

            default:
                break
            }
        default:
            break
        }
        if UIDevice().userInterfaceIdiom == .phone // iPhone X
        {
            switch UIScreen.main.nativeBounds.height
            {
            
            case 1792: // iPhone XR
                logoLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 220)
            case 2436: // iPhone X, Xs
                logoLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 200)
            case 2688: // iPhone Xs Max
                logoLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 220)
            default:
                print("unknown")
            }
        }
        
        logoLbl.zPosition = 6
        logoLbl.fontColor = SKColor.black
        logoLbl.text = "Sewer Conquer"
        
        return logoLbl
    }
    
    func createChooseLbl() -> SKLabelNode
    {
        
        let chooseLbl = SKLabelNode(fontNamed: "Decay")
        
        switch (deviceIdiom)
        {
            
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                chooseLbl.fontSize = 13
                chooseLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 25)

            case 321...375: // iPhone 6, 7, 8
                chooseLbl.fontSize = 15
                chooseLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 30)

            case 376...414: // iPhone 6+, 7+, 8+
                chooseLbl.fontSize = 17
                chooseLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 32)

            default:
                break
            }
        default:
            break
        }
        
        chooseLbl.zPosition = 6
        chooseLbl.fontColor = SKColor.yellow
        chooseLbl.text = "Choose your favourite"
        
        return chooseLbl
        
    }
    
    func createTimerLbl() -> SKLabelNode
    {
        
        let timerLabel = SKLabelNode(fontNamed: "Digits")
        
        switch (deviceIdiom)
        {
            
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                timerLabel.fontSize = 68
                timerLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 110)

            case 321...375: // iPhone 6, 7, 8, X
                timerLabel.fontSize = 70
                timerLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 130)

            case 376...414: // iPhone 6+, 7+, 8+
                timerLabel.fontSize = 72
                timerLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 135)

            default:
                break
            }
        default:
            break
        }
        
        timerLabel.zPosition = 6
        timerLabel.fontColor = SKColor.black
        timerLabel.text = ""
        
        return timerLabel
        
    }
    
    func createGameTimerLbl() -> SKLabelNode
    {
        
        let gameTimerLabel = SKLabelNode(fontNamed: "Chalkduster")
        
        switch (deviceIdiom)
        {
            
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                gameTimerLabel.fontSize = 54
                gameTimerLabel.position = CGPoint(x: self.frame.midX - 95, y: self.frame.midY)
                
            case 321...375: // iPhone 6, 7, 8, X
                gameTimerLabel.fontSize = 56
                gameTimerLabel.position = CGPoint(x: self.frame.midX - 110, y: self.frame.midY)
                
            case 376...414: // iPhone 6+, 7+, 8+
                gameTimerLabel.fontSize = 58
                gameTimerLabel.position = CGPoint(x: self.frame.midX - 125, y: self.frame.midY)
                
            default:
                break
            }
        default:
            break
        }
        
        gameTimerLabel.zPosition = 6
        gameTimerLabel.fontColor = SKColor.black
        gameTimerLabel.text = ""
        
        return gameTimerLabel
        
    }
    
    func createRestartBtn()
    {
        restartBtn = SKSpriteNode(imageNamed: "restart")
        
        switch  (deviceIdiom)
        {
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                restartBtn.size = CGSize(width: 80, height: 80)
                restartBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)

            case 321...375: // iPhone 6, 7, 8, X
                restartBtn.size = CGSize(width: 100, height: 100)
                restartBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)

            case 376...414: // iPhone 6+, 7+, 8+
                restartBtn.size = CGSize(width: 110, height: 110)
                restartBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)

            default:
                break
            }
        default:
            break
        }
        
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        self.addChild(restartBtn)
        restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    func createPauseBtn()
    {
        pauseBtn = SKSpriteNode(imageNamed: "pause")
        
        switch  (deviceIdiom)
        {
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                pauseBtn.size = CGSize(width: 45, height: 45)
                pauseBtn.position = CGPoint(x: self.frame.midX, y: 85)
                
            case 321...375: // iPhone 6, 7, 8
                pauseBtn.size = CGSize(width: 50, height: 50)
                pauseBtn.position = CGPoint(x: self.frame.midX, y: 90)
                
            case 376...414: // iPhone 6+, 7+, 8+
                pauseBtn.size = CGSize(width: 60, height: 60)
                pauseBtn.position = CGPoint(x: self.frame.midX, y: 95)
                
            default:
                break
            }
        default:
            break
        }
        
        if UIDevice().userInterfaceIdiom == .phone // iPhone X
        {
            switch UIScreen.main.nativeBounds.height
            {
            
            case 1792: // iPhone XR
                pauseBtn.size = CGSize(width: 60, height: 60)
                pauseBtn.position = CGPoint(x: self.frame.midX, y: 130)
            case 2436: // iPhone X, Xs
                pauseBtn.size = CGSize(width: 60, height: 60)
                pauseBtn.position = CGPoint(x: self.frame.midX, y: 130)
            case 2688: // iPhone Xs Max
                pauseBtn.size = CGSize(width: 60, height: 60)
                pauseBtn.position = CGPoint(x: self.frame.midX, y: 130)
            default:
                print("unknown")
            }
        }
        
        pauseBtn.zPosition = 6
        self.addChild(pauseBtn)
    }
    
    func createScoreLbl() -> SKLabelNode
    {
        let scoreLbl = SKLabelNode()
        
        switch (deviceIdiom)
        {
            
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                scoreLbl.fontSize = 46
                scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 3)

            case 321...375: // iPhone 6, 7, 8
                scoreLbl.fontSize = 50
                scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 3)

            case 376...414: // iPhone 6+, 7+, 8+
                scoreLbl.fontSize = 56
                scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 3)

            default:
                break
            }
        default:
            break
        }
        
        if UIDevice().userInterfaceIdiom == .phone // iPhone X
        {
            switch UIScreen.main.nativeBounds.height
            {
            case 1792: // iPhone XR
                scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 3.5)
            case 2436: // X, Xs
                scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 3.5)
            case 2688: // iPhone Xs Max
                scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 3.5)
            
            default:
                print("unknown")
            }
        }
        
        scoreLbl.zPosition = 5
        scoreLbl.text = "\(score)"
        scoreLbl.fontName = "Dwerneck"
        
        return scoreLbl
    }
    
    func createWalls() -> SKNode
    {
        let foodNode = SKSpriteNode(imageNamed: "worm")
        let bombNode = SKSpriteNode(imageNamed: "bomb")
        
        let topWall = SKSpriteNode(imageNamed: "pillar")
        let bottomWall = SKSpriteNode(imageNamed: "pillar")
        let midWall = SKSpriteNode(imageNamed: "midWall")
        
        let randomInsect = random(min: -5, max: 5)
        
        foodNode.color = SKColor.blue
        foodNode.physicsBody = SKPhysicsBody(rectangleOf: foodNode.size)
        foodNode.physicsBody?.affectedByGravity = false
        foodNode.physicsBody?.isDynamic = false
        foodNode.physicsBody?.collisionBitMask = 0
        foodNode.physicsBody?.categoryBitMask = CollisionBitMask.foodCategory
        foodNode.physicsBody?.contactTestBitMask = CollisionBitMask.batCategory | CollisionBitMask.owlCategory | CollisionBitMask.eagleBirdCategory
        
        bombNode.color = SKColor.blue
        bombNode.physicsBody = SKPhysicsBody(rectangleOf: bombNode.size)
        bombNode.physicsBody?.affectedByGravity = false
        bombNode.physicsBody?.isDynamic = false
        bombNode.physicsBody?.collisionBitMask = 0
        bombNode.physicsBody?.categoryBitMask = CollisionBitMask.bombCategory
        bombNode.physicsBody?.contactTestBitMask = CollisionBitMask.batCategory | CollisionBitMask.owlCategory | CollisionBitMask.eagleBirdCategory
        
        if(randomInsect < 0)
        {
            switch  (deviceIdiom)
            {
            case .phone:
                switch screenWidth
                {
                case 0...320: // iPhone 5, SE
                    foodNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 80)
                    bombNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 80)
                    
                case 321...375: // iPhone 6, 7, 8, X
                    foodNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 100)
                    bombNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 100)
                    
                case 376...414: // iPhone 6+, 7+, 8+
                    foodNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 120)
                    bombNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 120)
                    
                default:
                    break
                }
            default:
                break
            }
        }
        else
        {
            switch  (deviceIdiom)
            {
            case .phone:
                switch screenWidth
                {
                case 0...320: // iPhone 5, SE
                    foodNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 80)
                    bombNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 80)
                    
                case 321...375: // iPhone 6, 7, 8, X
                    foodNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 100)
                    bombNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 100)
                    
                case 376...414: // iPhone 6+, 7+, 8+
                    foodNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 120)
                    bombNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 120)
                    
                default:
                    break
                }
            default:
                break
            }
        }
        
        wallPair = SKNode()
        wallPair.name = "wallPair"
             
        switch (deviceIdiom)
        {
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                topWall.setScale(0.4)
                bottomWall.setScale(0.4)
                midWall.setScale(0.4)
                
                topWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 400)
                bottomWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 400)
                midWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
                
                foodNode.size = CGSize(width: 40, height: 40)
                bombNode.size = CGSize(width: 40, height: 40)
                
            case 321...375: // iPhone 6, 7, 8, X
                topWall.setScale(0.5)
                bottomWall.setScale(0.5)
                midWall.setScale(0.5)
                
                topWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 500)
                bottomWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 500)
                midWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
                
                foodNode.size = CGSize(width: 50, height: 50)
                bombNode.size = CGSize(width: 50, height: 50)
                
            case 376...414: // iPhone 6+, 7+, 8+
                topWall.setScale(0.6)
                bottomWall.setScale(0.6)
                midWall.setScale(0.6)
                
                topWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 600)
                bottomWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 600)
                midWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
                
                foodNode.size = CGSize(width: 60, height: 60)
                bombNode.size = CGSize(width: 60, height: 60)
                
            default:
                break
            }
        default:
            break
        }
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.affectedByGravity = false
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        topWall.physicsBody?.contactTestBitMask = CollisionBitMask.batCategory
        topWall.physicsBody?.collisionBitMask = CollisionBitMask.batCategory
        topWall.zRotation = CGFloat(Double.pi)
        
        bottomWall.physicsBody = SKPhysicsBody(rectangleOf: bottomWall.size)
        bottomWall.physicsBody?.affectedByGravity = false
        bottomWall.physicsBody?.isDynamic = false
        bottomWall.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        bottomWall.physicsBody?.contactTestBitMask = CollisionBitMask.batCategory
        bottomWall.physicsBody?.collisionBitMask = CollisionBitMask.batCategory
        
        midWall.physicsBody = SKPhysicsBody(rectangleOf: midWall.size)
        midWall.physicsBody?.affectedByGravity = false
        midWall.physicsBody?.isDynamic = false
        midWall.physicsBody?.categoryBitMask = CollisionBitMask.midWallCategory
        midWall.physicsBody?.contactTestBitMask = CollisionBitMask.batCategory
        midWall.physicsBody?.collisionBitMask = CollisionBitMask.batCategory
        midWall.physicsBody?.contactTestBitMask = CollisionBitMask.owlCategory
        midWall.physicsBody?.collisionBitMask = CollisionBitMask.owlCategory
        midWall.physicsBody?.contactTestBitMask = CollisionBitMask.eagleBirdCategory
        midWall.physicsBody?.collisionBitMask = CollisionBitMask.eagleBirdCategory
        
        wallPair.addChild(topWall)
        wallPair.addChild(bottomWall)
        wallPair.addChild(midWall)
        wallPair.zPosition = 1
        
        let randomPosition = random(min: -200, max: 200)
        wallPair.position.y = wallPair.position.y + randomPosition
        wallPair.addChild(foodNode)
        wallPair.addChild(bombNode)

        wallPair.run(moveAndRemove)
        
        return wallPair
    }
    
    func random() -> CGFloat
    {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat
    {
        return random() * (max - min) + min
    }
    
    func spawnWalls()
    {
        let spawn = SKAction.run(
        {
            () in
            self.wallPair = self.createWalls()
            self.addChild(self.wallPair)
        })
        
        let delay = SKAction.wait(forDuration: 1.6)
        let spawnDelay = SKAction.sequence([spawn, delay])
        let spawnDelayForever = SKAction.repeatForever(spawnDelay)
        self.run(spawnDelayForever)
        
        let distance = CGFloat(self.frame.width + wallPair.frame.width)
        let movePillars = SKAction.moveBy(x: -distance - 50, y: 0, duration: TimeInterval(0.008 * distance))
        let removePillars = SKAction.removeFromParent()
        moveAndRemove = SKAction.sequence([movePillars, removePillars])
    }
    
    /*@objc func fireMunition()
    {
        let munition = SKSpriteNode(imageNamed: "bullet")
        munition.name = "bullet"
        munition.setScale(1)
        munition.position = bat.position
        munition.zPosition = 1
        munition.physicsBody = SKPhysicsBody(rectangleOf: munition.size)
        munition.physicsBody?.affectedByGravity = false
        munition.physicsBody?.isDynamic = false
        munition.physicsBody?.categoryBitMask = CollisionBitMask.munitionCategory
        munition.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.foodCategory | CollisionBitMask.bombCategory | CollisionBitMask.midWallCategory
        munition.physicsBody?.contactTestBitMask = 0
        
        munition.physicsBody = SKPhysicsBody(circleOfRadius: munition.size.width / 2)
        munition.physicsBody?.linearDamping = 1.1
        munition.physicsBody?.restitution = 0
        
        self.addChild(munition)
        
        let moveMunition = SKAction.moveTo(x: self.size.height + munition.size.height, duration: 1)
        let deleteMunition = SKAction.removeFromParent()
        let munitionSequence = SKAction.sequence([/*bulletSound*/moveMunition, deleteMunition])
        
        munition.run(munitionSequence)
        
    }*/
    
}







