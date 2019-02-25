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
    static let startGround: UInt32 = 0x1 << 4
    static let endGround: UInt32 = 0x1 << 5
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
    
    var hoop = SKSpriteNode(imageNamed: "hoop")
    var basketball = SKSpriteNode(imageNamed: "ball")
    
    var ball = SKShapeNode()
    var leftWall = SKShapeNode()
    var rightWall = SKShapeNode()
    var startGround = SKShapeNode() // Where the balls starts from
    var endGround = SKShapeNode() //Where the ball will stop/bounce
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            
        }
    }
    
    
}
