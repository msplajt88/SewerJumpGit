//
//  GameScene.swift
//  SkyConquer
//
//  Created by Marko Splajt on 05/04/2018.
//  Copyright © 2018 MarkoSplajt. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreData
import Foundation
import UIKit

var totalScore = UserDefaults.standard.integer(forKey: "totalScoreSaved")
let defaults = UserDefaults()
var timesDead = 5
var currentTimesDead = 0
var isLoadedTimesDead = false

//let jumpButton = UIButton(type: .custom) as UIButton

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var isGameStarted = false
    var isDead = false
    let coinSound = SKAction.playSoundFileNamed("CoinSound.mp3", waitForCompletion: false)
    let bombCoin = SKAction.playSoundFileNamed("toiletFlush.mp3", waitForCompletion: false)

    var seconds = 4
    var gameSeconds = 21
    var timer = Timer()
    var gameTimer = Timer()
    var timerLabel = SKLabelNode()
    var gameTimerLabel = SKLabelNode()
    var isTimerStarted = false
    
    var score = 0
    var chooseLbl = SKLabelNode()
    var scoreLbl = SKLabelNode()
    var highScoreLbl = SKLabelNode()
    var totalScoreLbl = SKLabelNode()
    var pauseBtn = SKSpriteNode()
    var restartBtn = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var logoLbl = SKLabelNode()
        
    var bat = SKSpriteNode()
    let batAtlas = SKTextureAtlas(named: "player")
    var repeatActionBat = SKAction()
    var batSprites = Array<Any>()
    
    var owl = SKSpriteNode()
    let owlAtlas = SKTextureAtlas(named: "playerTwo")
    var repeatActionOwl = SKAction()
    var owlSprites = Array<Any>()
    
    var eagleBird = SKSpriteNode()
    let eagleBirdAtlas = SKTextureAtlas(named: "playerThree")
    var repeatActionEagleBird = SKAction()
    var eagleBirdSprites = Array<Any>()
    
    //let fireButton = UIButton(type: .custom) as UIButton
    
    override func didMove(to view: SKView)
    {
        createScene()
    }
    
    func createScene()
    {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.batCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.batCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.owlCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.owlCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.eagleBirdCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.eagleBirdCategory
        
        self.physicsWorld.contactDelegate = self
        
        for i in 0..<2
        {
            let background = SKSpriteNode(imageNamed: "sewerBg")
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x: CGFloat(i) * self.size.width, y: 0)
            background.size = (self.view?.bounds.size)!
            background.name = "background"
            self.addChild(background)
        }
        
        batSprites.append(batAtlas.textureNamed("bat1"))
        batSprites.append(batAtlas.textureNamed("bat2"))
        batSprites.append(batAtlas.textureNamed("bat3"))
        batSprites.append(batAtlas.textureNamed("bat4"))
        
        self.bat = createBat()
        self.addChild(bat)
        let animateBat = SKAction.animate(with: self.batSprites as! [SKTexture], timePerFrame: 0.1)
        self.repeatActionBat = SKAction.repeatForever(animateBat)
        
        owlSprites.append(owlAtlas.textureNamed("owl1"))
        owlSprites.append(owlAtlas.textureNamed("owl2"))
        owlSprites.append(owlAtlas.textureNamed("owl3"))
        owlSprites.append(owlAtlas.textureNamed("owl4"))
        owlSprites.append(owlAtlas.textureNamed("owl5"))
        owlSprites.append(owlAtlas.textureNamed("owl6"))
        owlSprites.append(owlAtlas.textureNamed("owl7"))
        owlSprites.append(owlAtlas.textureNamed("owl8"))
        
        self.owl = createOwl()
        self.addChild(owl)
        let animateOwl = SKAction.animate(with: self.owlSprites as! [SKTexture], timePerFrame: 0.1)
        self.repeatActionOwl = SKAction.repeatForever(animateOwl)
        
        eagleBirdSprites.append(eagleBirdAtlas.textureNamed("eagle1"))
        eagleBirdSprites.append(eagleBirdAtlas.textureNamed("eagle2"))
        eagleBirdSprites.append(eagleBirdAtlas.textureNamed("eagle3"))
        eagleBirdSprites.append(eagleBirdAtlas.textureNamed("eagle4"))
        
        self.eagleBird = createEagleBird()
        self.addChild(eagleBird)
        let animateEagleBird = SKAction.animate(with: self.eagleBirdSprites as! [SKTexture], timePerFrame: 0.1)
        self.repeatActionEagleBird = SKAction.repeatForever(animateEagleBird)
        
        highScoreLbl = createHighScoreLbl()
        self.addChild(highScoreLbl)
        
        totalScoreLbl = createTotalScoreLbl()
        self.addChild(totalScoreLbl)
        
        logoLbl = createLogoLbl()
        self.addChild(logoLbl)
        
        chooseLbl = createChooseLbl()
        self.addChild(chooseLbl)
    }

    func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameScene.updateTimer)), userInfo: nil, repeats: true)
        
        isTimerStarted = true
    }
    
    @objc func updateTimer()
    {
        seconds -= 1
        timerLabel.text = "\(seconds)"

        if seconds == 0
        {
            timer.invalidate()
            isTimerStarted = false
            timerLabel.removeFromParent()
            StartGame()
            
            /*gameTimerLabel = createGameTimerLbl()
            self.addChild(gameTimerLabel)
            runGameTimer()
            updateGameTimer()*/
        }
    }
    
    /*func runGameTimer()
    {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameScene.updateGameTimer)), userInfo: nil, repeats: true)
        
        isTimerStarted = true
    }
    
    @objc func updateGameTimer()
    {
        gameSeconds -= 1
        gameTimerLabel.text = "\(gameSeconds)"
        increaseGameTimer()
        
        if gameSeconds == 0
        {
            gameTimer.invalidate()
            isTimerStarted = false
            isGameStarted = false
        }
        else if isDead == true
        {
            gameTimer.invalidate()
            isTimerStarted = false
        }
    }*/
    
    func StartGame()
    {
        if (isGameStarted == false)
        {
            isGameStarted = true
            
            bat.physicsBody?.affectedByGravity = true
            owl.physicsBody?.affectedByGravity = true
            eagleBird.physicsBody?.affectedByGravity = true
            scoreLbl = createScoreLbl()
            self.addChild(scoreLbl)
            createPauseBtn()
            
            /*createJumpButton()
            jumpButton.isHidden = false*/
            
            /*createFireButton()
            fireButton.isHidden = false*/
            
            logoLbl.run(SKAction.scale(to: 0.5, duration: 0.3), completion: {
                self.logoLbl.removeFromParent()
            })
            spawnWalls()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == CollisionBitMask.batCategory && secondBody.categoryBitMask == CollisionBitMask.pillarCategory || firstBody.categoryBitMask == CollisionBitMask.pillarCategory && secondBody.categoryBitMask == CollisionBitMask.batCategory || firstBody.categoryBitMask == CollisionBitMask.batCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.batCategory || firstBody.categoryBitMask == CollisionBitMask.batCategory && secondBody.categoryBitMask == CollisionBitMask.midWallCategory || firstBody.categoryBitMask == CollisionBitMask.midWallCategory && secondBody.categoryBitMask == CollisionBitMask.batCategory || firstBody.categoryBitMask == CollisionBitMask.owlCategory && secondBody.categoryBitMask == CollisionBitMask.pillarCategory || firstBody.categoryBitMask == CollisionBitMask.pillarCategory && secondBody.categoryBitMask == CollisionBitMask.owlCategory || firstBody.categoryBitMask == CollisionBitMask.owlCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.owlCategory || firstBody.categoryBitMask == CollisionBitMask.owlCategory && secondBody.categoryBitMask == CollisionBitMask.midWallCategory || firstBody.categoryBitMask == CollisionBitMask.midWallCategory && secondBody.categoryBitMask == CollisionBitMask.owlCategory || firstBody.categoryBitMask == CollisionBitMask.eagleBirdCategory && secondBody.categoryBitMask == CollisionBitMask.pillarCategory || firstBody.categoryBitMask == CollisionBitMask.pillarCategory && secondBody.categoryBitMask == CollisionBitMask.eagleBirdCategory || firstBody.categoryBitMask == CollisionBitMask.eagleBirdCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.eagleBirdCategory || firstBody.categoryBitMask == CollisionBitMask.eagleBirdCategory && secondBody.categoryBitMask == CollisionBitMask.midWallCategory || firstBody.categoryBitMask == CollisionBitMask.midWallCategory && secondBody.categoryBitMask == CollisionBitMask.eagleBirdCategory
            {
            enumerateChildNodes(withName: "wallPair", using: ({(node, error) in
                node.speed = 0
                self.removeAllActions()
            }))
            if isDead == false
            {
                isDead = true
                
            if firstBody.categoryBitMask == CollisionBitMask.batCategory && secondBody.categoryBitMask == CollisionBitMask.pillarCategory || firstBody.categoryBitMask == CollisionBitMask.pillarCategory && secondBody.categoryBitMask == CollisionBitMask.batCategory || firstBody.categoryBitMask == CollisionBitMask.batCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.batCategory || firstBody.categoryBitMask == CollisionBitMask.batCategory && secondBody.categoryBitMask == CollisionBitMask.midWallCategory || firstBody.categoryBitMask == CollisionBitMask.midWallCategory && secondBody.categoryBitMask == CollisionBitMask.batCategory || firstBody.categoryBitMask == CollisionBitMask.owlCategory && secondBody.categoryBitMask == CollisionBitMask.pillarCategory || firstBody.categoryBitMask == CollisionBitMask.pillarCategory && secondBody.categoryBitMask == CollisionBitMask.owlCategory || firstBody.categoryBitMask == CollisionBitMask.owlCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.owlCategory || firstBody.categoryBitMask == CollisionBitMask.owlCategory && secondBody.categoryBitMask == CollisionBitMask.midWallCategory || firstBody.categoryBitMask == CollisionBitMask.midWallCategory && secondBody.categoryBitMask == CollisionBitMask.owlCategory || firstBody.categoryBitMask == CollisionBitMask.eagleBirdCategory && secondBody.categoryBitMask == CollisionBitMask.pillarCategory || firstBody.categoryBitMask == CollisionBitMask.pillarCategory && secondBody.categoryBitMask == CollisionBitMask.eagleBirdCategory || firstBody.categoryBitMask == CollisionBitMask.eagleBirdCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.eagleBirdCategory || firstBody.categoryBitMask == CollisionBitMask.eagleBirdCategory && secondBody.categoryBitMask == CollisionBitMask.midWallCategory || firstBody.categoryBitMask == CollisionBitMask.midWallCategory && secondBody.categoryBitMask == CollisionBitMask.eagleBirdCategory{
                    
                bat.removeFromParent()
                owl.removeFromParent()
                eagleBird.removeFromParent()
                totalScore += score
                defaults.set(totalScore, forKey: "totalScoreSaved")
                
                // Decrement counter and show ad
                //timesDeadLoadOnStart()
                //firstVC.timesDeadLoadOnStart()
                
                    //updateGameTimer()
                }
                gameTimerLabel.removeFromParent()
                createRestartBtn()
                pauseBtn.removeFromParent()
                //jumpButton.isHidden = true
                
                //fireButton.isHidden = true
            }
        }
        else if firstBody.categoryBitMask == CollisionBitMask.batCategory && secondBody.categoryBitMask == CollisionBitMask.foodCategory
        {
            run(coinSound)
            score += 2
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.foodCategory && secondBody.categoryBitMask == CollisionBitMask.batCategory
        {
            run(coinSound)
            score += 2
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.batCategory && secondBody.categoryBitMask == CollisionBitMask.bombCategory
        {
            run(bombCoin)
            score -= 1
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.bombCategory && secondBody.categoryBitMask == CollisionBitMask.batCategory
        {
            run(bombCoin)
            score -= 1
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.owlCategory && secondBody.categoryBitMask == CollisionBitMask.foodCategory
        {
            run(coinSound)
            score += 2
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.foodCategory && secondBody.categoryBitMask == CollisionBitMask.owlCategory
        {
            run(coinSound)
            score += 2
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.owlCategory && secondBody.categoryBitMask == CollisionBitMask.bombCategory
        {
            run(bombCoin)
            score -= 1
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.bombCategory && secondBody.categoryBitMask == CollisionBitMask.owlCategory
        {
            run(bombCoin)
            score -= 1
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.eagleBirdCategory && secondBody.categoryBitMask == CollisionBitMask.foodCategory
        {
            run(coinSound)
            score += 2
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.foodCategory && secondBody.categoryBitMask == CollisionBitMask.eagleBirdCategory
        {
            run(coinSound)
            score += 2
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.eagleBirdCategory && secondBody.categoryBitMask == CollisionBitMask.bombCategory
        {
            run(bombCoin)
            score -= 1
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.bombCategory && secondBody.categoryBitMask == CollisionBitMask.eagleBirdCategory
        {
            run(bombCoin)
            score -= 1
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
        }
        /*else if firstBody.categoryBitMask == CollisionBitMask.munitionCategory && secondBody.categoryBitMask == CollisionBitMask.pillarCategory
        {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.pillarCategory && secondBody.categoryBitMask == CollisionBitMask.munitionCategory
        {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.munitionCategory && secondBody.categoryBitMask == CollisionBitMask.midWallCategory
        {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.midWallCategory && secondBody.categoryBitMask == CollisionBitMask.munitionCategory
        {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.munitionCategory && secondBody.categoryBitMask == CollisionBitMask.foodCategory
        {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.foodCategory && secondBody.categoryBitMask == CollisionBitMask.munitionCategory
        {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.munitionCategory && secondBody.categoryBitMask == CollisionBitMask.bombCategory
        {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.bombCategory && secondBody.categoryBitMask == CollisionBitMask.munitionCategory
        {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }*/
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        if isGameStarted == true
        {
            if isDead == false
            {
                //jumpButton.isHidden = false
                pauseBtn.texture = SKTexture(imageNamed: "pause")
                
                enumerateChildNodes(withName: "background", using: ({ (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                    if bg.position.x <= -bg.size.width
                    {
                        bg.position = CGPoint(x: bg.position.x + bg.size.width * 2, y: bg.position.y)
                    }
                }))
            }
        }
    }
    
    func restartScene()
    {
        self.removeAllActions()
        self.removeAllChildren()
        score = 0
        isDead = false
        isGameStarted = false
        createScene()
        seconds = 4
        //gameSeconds = 21
    }
    
    func increaseGameTimer()
    {
        switch score
        {
        case 3, 7:
            gameSeconds += 4
            gameTimerLabel.text = "\(gameSeconds)"
        case 5, 10:
            gameSeconds += 8
            gameTimerLabel.text = "\(gameSeconds)"
        case 13, 20:
            gameSeconds += 10
            gameTimerLabel.text = "\(gameSeconds)"
        case 16, 25:
            gameSeconds += 12
            gameTimerLabel.text = "\(gameSeconds)"
        case 28, 38, 48, 58, 68, 78, 88, 98:
            gameSeconds += 14
            gameTimerLabel.text = "\(gameSeconds)"
        case 35, 45, 55, 65, 75, 85, 95:
            gameSeconds += 16
            gameTimerLabel.text = "\(gameSeconds)"
        default:
            print("too slow")
        }
    }
    
    /*func increaseBatMunition()
    {
        switch score {
        case 3, 6:
            batFire += 2
            
        default:
            print("too slow")
        }
    }*/
    
    /*func createJumpButton()
    {
        jumpButton.addTarget(self, action: #selector(jump), for: .touchUpInside)
        jumpButton.setImage(UIImage(named:"jumpButton"), for: .normal)
        
        switch  (deviceIdiom)
        {
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                jumpButton.frame = CGRect(x: self.frame.midX + 40, y: self.frame.midY + 130, width: 100, height: 100)
            
            case 321...375: // iPhone 6, 7, 8
                jumpButton.frame = CGRect(x: self.frame.midX + 50, y: self.frame.midY + 180, width: 100, height: 100)
            
            case 376...414: // iPhone 6+, 7+, 8+
                jumpButton.frame = CGRect(x: self.frame.midX + 60, y: self.frame.midY + 210, width: 100, height: 100)
                
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
                jumpButton.frame = CGRect(x: self.frame.midX + 60, y: self.frame.midY + 260, width: 100, height: 100)
            case 2436: // iPhone X, Xs
                jumpButton.frame = CGRect(x: self.frame.midX + 60, y: self.frame.midY + 210, width: 100, height: 100)
            case 2688: // iPhone Xs Max
                jumpButton.frame = CGRect(x: self.frame.midX + 60, y: self.frame.midY + 260, width: 100, height: 100)
            default:
                print("unknown")
            }
        }
        
        self.view?.addSubview(jumpButton)
    }
    
    @objc func jump(sender:UIButton!)
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
    }*/
    
    
    /*func createFireButton()
    {
        fireButton.addTarget(self, action: #selector(fireMunition), for: .touchUpInside)
        fireButton.setImage(UIImage(named:"fireButton"), for: .normal)
        
        switch  (deviceIdiom)
        {
        case .phone:
            switch screenWidth
            {
            case 0...320: // iPhone 5, SE
                fireButton.frame = CGRect(x: self.frame.midX + 100, y: self.frame.midY + 50, width: 60, height: 60)
                
            case 321...375: // iPhone 6, 7, 8, X
                fireButton.frame = CGRect(x: self.frame.midX + 70, y: self.frame.midY + 170, width: 60, height: 60)
                
            case 376...414: // iPhone 6+, 7+, 8+
                fireButton.frame = CGRect(x: self.frame.midX + 100, y: self.frame.midY + 70, width: 60, height: 60)
                
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
            case 2436:
                fireButton.frame = CGRect(x: self.frame.midX + 100, y: self.frame.midY + 100, width: 60, height: 60)
            default:
                print("unknown")
            }
        }
        
        self.view?.addSubview(fireButton)
    }*/
}


