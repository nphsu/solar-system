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
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            if let hitResult = results.first {
                let portalScene = SCNScene(named: "art.scnassets/portal.scn")!
                if let portalNode = portalScene.rootNode.childNode(withName: "portal", recursively: true) {
                    
                    let x = hitResult.worldTransform.columns.3.x
                    let y = hitResult.worldTransform.columns.3.y
                    let z = hitResult.worldTransform.columns.3.z
                    
                    portalNode.position = SCNVector3(x: x, y: y + 1, z: z - 2)
                    portalNode.renderingOrder = 100
                    sceneView.scene.rootNode.addChildNode(portalNode)

                    let solarSystem = SolarSystem(x: x, y: y + 1, z: z - 2)
                    for node in solarSystem.getNodeList() {
                        sceneView.scene.rootNode.addChildNode(node)
                    }
                }
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            let planeAnchor = anchor as! ARPlaneAnchor
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            plane.materials = [gridMaterial]
            planeNode.geometry = plane
            node.addChildNode(planeNode)
        } else {
            return
        }
    }
    
//    @objc func handleTap(sender: UITapGestureRecognizer) {
//        guard let touchedSceneView = sender.view as? ARSCNView else {return}
//        let touchCordinates = sender.location(in: touchedSceneView)
//        let hitTest = touchedSceneView.hitTest(touchCordinates)
//        if hitTest.isEmpty {
//            print("did't touch anything")
//        } else {
//            print("touched the planet")
//            let node = hitTest.first?.node
//            expandPlanets(node: node!)
//        }
//    }
    
//    func expandPlanets(node: SCNNode) {
//        let spin = CABasicAnimation(keyPath: "position")
//        spin.fromValue = node.presentation.position
//        spin.toValue = SCNVector3(0, 0, -1)
//        spin.autoreverses = true
//        spin.duration = 2
//        node.addAnimation(spin, forKey: "position")
//
//        node.parent?.runAction(SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 0))
//        node.runAction(SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 0))
//        print(node)
//    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


