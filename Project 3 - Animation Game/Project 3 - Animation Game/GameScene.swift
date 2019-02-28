//
//  GameScene.swift
//  Project 3 - Animation Game
//
//  Created by Kevin Ren on 2/25/19.
//  Copyright © 2019 Binghamton University. All rights reserved.
//

import SpriteKit
import GameKit

enum GameState{
    case mainMenu
    case playing
    static var current = GameState.playing
}

struct Physics{
    static let none: UInt32 = 0x1 << 0
    static let ball: UInt32 = 0x1 << 1
    static let leftHoop: UInt32 = 0x1 << 2
    static let rightHoop: UInt32 = 0x1 << 3
    //static let floor: UInt32 = 0x1 << 4
    static let sg: UInt32 = 0x1 << 4
    static let eg: UInt32 = 0x1 << 5
}

struct TouchPoints{
    static var start = CGPoint()
    static var end = CGPoint()
}

struct GameConstants{
    static var gravity = CGFloat()
    static var YVel = CGFloat()
    static var AirTime = TimeInterval()
}

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var grids = true
    
    var bg = SKSpriteNode(imageNamed: "bg")
    var hoop = SKSpriteNode(imageNamed: "hoop")
    var basketball = SKSpriteNode(imageNamed: "ball")
    
    var ball = SKShapeNode()
    var leftWall = SKShapeNode()
    var rightWall = SKShapeNode()
    var startGround = SKShapeNode() // Where the balls starts from
    var endGround = SKShapeNode() //Where the ball will stop/bounce
    
    var pi = Double.pi
    var score = CGFloat()
    var scoreDisplay = SKLabelNode()

    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            GameConstants.gravity = -6
            GameConstants.YVel = self.frame.height / 4
            GameConstants.AirTime = 2
        }
        
        physicsWorld.gravity = CGVector(dx: 0, dy: GameConstants.gravity)
        
        runGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if GameState.current == .playing && ball.contains(location){
                    TouchPoints.start = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if GameState.current == .playing && !ball.contains(location){
                    TouchPoints.end = location
                    shootBall()
            }
        }
    }
    
    func runGame(){
        GameState.current = .playing
        
        //Display the Background
        let bgScale = CGFloat(bg.frame.width / bg.frame.height)
        bg.size.height = self.frame.height
        bg.size.width = bg.size.height * bgScale
        bg.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        bg.zPosition = 0
        
        self.addChild(bg)
        
        //Display the hoop
        let hoopScale = CGFloat(hoop.frame.width / hoop.frame.height)
        hoop.size.height = self.frame.height / 3
        hoop.size.width = hoop.size.height * hoopScale
        hoop.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.5)
        hoop.zPosition = bg.zPosition + 1
        
        self.addChild(hoop)
        
        
        //Physics of the start ground
        startGround = SKShapeNode(rectOf: CGSize(width: self.frame.width, height: 5))
        startGround.fillColor = .blue
        startGround.strokeColor = .clear
        startGround.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 10)
        startGround.zPosition = 10
        startGround.alpha = grids ? 1 : 0
        
        startGround.physicsBody = SKPhysicsBody(rectangleOf: startGround.frame.size)
        startGround.physicsBody?.categoryBitMask = Physics.sg
        startGround.physicsBody?.collisionBitMask = Physics.ball
        startGround.physicsBody?.contactTestBitMask = Physics.none
        startGround.physicsBody?.affectedByGravity = false
        startGround.physicsBody?.isDynamic = false
        
        self.addChild(startGround)
        
        // Physics of end ground
        endGround = SKShapeNode(rectOf: CGSize(width: self.frame.width * 2, height: 5))
        endGround.fillColor = .blue
        endGround.strokeColor = .clear
        endGround.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.5 - hoop.frame.height / 2)
        endGround.zPosition = 10
        endGround.alpha = grids ? 1 : 0
        
        endGround.physicsBody = SKPhysicsBody(rectangleOf: startGround.frame.size)
        endGround.physicsBody?.categoryBitMask = Physics.eg
        endGround.physicsBody?.collisionBitMask = Physics.ball
        endGround.physicsBody?.contactTestBitMask = Physics.none
        endGround.physicsBody?.affectedByGravity = false
        endGround.physicsBody?.isDynamic = false
        
        self.addChild(endGround)

        
        
        
    }
    
    func shootBall(){
        
    }
}
