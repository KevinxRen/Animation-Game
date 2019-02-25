//
//  GameViewController.swift
//  Project 3 - Animation Game
//
//  Created by Kevin Ren on 2/18/19.
//  Copyright © 2019 Binghamton University. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    class Gamelogic : UIViewController, GamelogicProtocol {
        //Setting up the game board
        var dimension: Int
        var threshold: Int
        
        init(dimension d: Int, threshold t: Int) {
            dimension = d > 2 ? d : 2
            threshold = t > 8 ? t : 8
            super.init(nibName: nil, bundle: nil)
            model = GameModel(dimension: dimension, threshold: threshold, delegate: self)
            view.backgroundColor = UIColor.white
            setupSwipeControls()
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("NSCoding not supported")
        }
}
