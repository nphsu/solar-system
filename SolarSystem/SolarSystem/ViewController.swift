//
//  ViewController.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/10/15.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import GoogleMobileAds

class ViewController: UIViewController, ARSCNViewDelegate, GADBannerViewDelegate {

    @IBOutlet weak var bannerView: GADBannerView!
    let request = GADRequest()
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var showPortal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.delegate = self
        self.sceneView.autoenablesDefaultLighting = true
        
        // config banner
        request.testDevices = [kGADSimulatorID]
        bannerView.delegate = self
        bannerView.adUnitID = Consts.bannerAdUnitId
        bannerView.rootViewController = self
        bannerView.load(request)
    }
    
    @IBAction func clearPortal(_ sender: Any) {
        for node in self.sceneView.scene.rootNode.childNodes {
            print(node)
            node.removeFromParentNode()
        }
        showPortal = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (showPortal) {
            return
        }
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            if let hitResult = results.first {
                let portalScene = SCNScene(named: "art.scnassets/portal.scn")!
                if let portalNode = portalScene.rootNode.childNode(withName: "portal", recursively: true) {
                    
                    let x = hitResult.worldTransform.columns.3.x
                    let y = hitResult.worldTransform.columns.3.y + 1
                    let z = hitResult.worldTransform.columns.3.z - 6
                    
                    for node in self.sceneView.scene.rootNode.childNodes {
                        node.removeFromParentNode()
                    }
                    
                    let fireNode = Fire().createFire(x: x, y: y - 3, z: z + 2)
                    self.sceneView.scene.rootNode.addChildNode(fireNode)
             
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        
                        portalNode.position = SCNVector3(x: x, y: y, z: z)
                        portalNode.renderingOrder = 100
                        portalNode.opacity = 0
                        let fadeIn = SCNAction.fadeIn(duration: 5)
                        portalNode.runAction(fadeIn)
                        self.sceneView.scene.rootNode.addChildNode(portalNode)
                        
                        let solarSystem = SolarSystem(x: x, y: y, z: z)
                        for node in solarSystem.getNodeList() {
                            self.sceneView.scene.rootNode.addChildNode(node)
                        }
                        self.showPortal = true
                    }
                }
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if (showPortal) {
            return
        }
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        let planeNode = SCNNode()
        planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        plane.materials = [GridMaterial().create()]
        planeNode.geometry = plane
        node.addChildNode(planeNode)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


