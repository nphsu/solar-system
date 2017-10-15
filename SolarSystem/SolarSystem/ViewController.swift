//
//  ViewController.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/10/15.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import UIKit
import ARKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var bannerView: GADBannerView!
    let request = GADRequest()
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    let xPosition = 0
    let yPosition = 0
    let zPosition = -2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        
        let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.sceneView.addGestureRecognizer(touchRecognizer)
        
        // config banner
        request.testDevices = [kGADSimulatorID]
        bannerView.delegate = self
        bannerView.adUnitID = Consts.bannerAdUnitId
        bannerView.rootViewController = self
        bannerView.load(request)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else {return}
        guard let pointOfView = sceneView.pointOfView else {return}
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.20))
        let mercuryParent = SCNNode()
        let venusParent = SCNNode()
        let earthParent = SCNNode()
        let moonParent = SCNNode()
        let marsParent = SCNNode()
        let jupiterParent = SCNNode()
        let saturnParent = SCNNode()
        let uranusParent = SCNNode()
        let neptuneParent = SCNNode()
        let saturnRingParent = SCNNode()
        
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun")
        
        
        sun.position = SCNVector3(xPosition, yPosition, zPosition)
        mercuryParent.position = SCNVector3(xPosition, yPosition, zPosition)
        venusParent.position = SCNVector3(xPosition, yPosition, zPosition)
        earthParent.position = SCNVector3(xPosition, yPosition, zPosition)
        moonParent.position = SCNVector3(0.8, 0, 0)
        marsParent.position = SCNVector3(xPosition, yPosition, zPosition)
        jupiterParent.position = SCNVector3(xPosition, yPosition, zPosition)
        saturnParent.position = SCNVector3(xPosition, yPosition, zPosition)
        saturnRingParent.position = SCNVector3(2.2, 0, 0)
        uranusParent.position = SCNVector3(xPosition, yPosition, zPosition)
        neptuneParent.position = SCNVector3(xPosition, yPosition, zPosition)
        
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(mercuryParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(marsParent)
        self.sceneView.scene.rootNode.addChildNode(jupiterParent)
        self.sceneView.scene.rootNode.addChildNode(saturnParent)
        self.sceneView.scene.rootNode.addChildNode(saturnRingParent)
        self.sceneView.scene.rootNode.addChildNode(uranusParent)
        self.sceneView.scene.rootNode.addChildNode(neptuneParent)
        
        // Planets
        let mercury = makePlanet(geometry: SCNSphere(radius: 0.02), diffuse: #imageLiteral(resourceName: "Mercury"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.3, 0, 0))
        let venus = makePlanet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Venus"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.5, 0, 0))
        let earth = makePlanet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Earth"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.8, 0, 0))
        let moon = makePlanet(geometry: SCNSphere(radius: 0.01), diffuse: #imageLiteral(resourceName: "Moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.1))
        let mars = makePlanet(geometry: SCNSphere(radius: 0.04), diffuse: #imageLiteral(resourceName: "Mars"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1.2, 0, 0))
        let jupiter = makePlanet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Jupiter"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1.8, 0, 0))
        let saturn = makePlanet(geometry: SCNSphere(radius: 0.15), diffuse: #imageLiteral(resourceName: "Saturn"), specular: nil, emission: nil, normal: nil, position: SCNVector3(2.2, 0, 0))
        let uranus = makePlanet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Uranus"), specular: nil, emission: nil, normal: nil, position: SCNVector3(2.5, 0, 0))
        let neptune = makePlanet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Neptune"), specular: nil, emission: nil, normal: nil, position: SCNVector3(2.8, 0, 0))

        let saturnRingTorus = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
        saturnRingTorus.pipeSegmentCount = 2
        let saturnRing = SCNNode(geometry: saturnRingTorus)
        saturnRing.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Saturn Ring")
        
        // 自転
        let sunRotation = doRotation(time: 20)
        let mercuryRotation = doRotation(time: 5)
        let venusRotation = doRotation(time: 5)
        let earthRotation = doRotation(time: 5)
        let moonRotation = doRotation(time: 5)
        let marsRotation = doRotation(time: 5)
        let jupiterRotation = doRotation(time: 5)
        let saturnRotation = doRotation(time: 5)
        let uranusRotation = doRotation(time: 5)
        let neptuneRotation = doRotation(time: 5)
        
        // 公転
        let mercuryParentRotation = doRotation(time: 5)
        let venusParentRotation = doRotation(time: 7)
        let earthParentRotation = doRotation(time: 9)
        let marsParentRotation = doRotation(time: 11)
        let jupiterParentRotation = doRotation(time: 13)
        let saturnParentRotation = doRotation(time: 15)
        let saturnRingParentRotation = doRotation(time: 15)
        let uranusParentRotation = doRotation(time: 17)
        let neptuneParentRotation = doRotation(time: 19)
        
        sun.runAction(sunRotation)
        mercury.runAction(mercuryRotation)
        mercuryParent.runAction(mercuryParentRotation)
        venus.runAction(venusRotation)
        venusParent.runAction(venusParentRotation)
        earth.runAction(earthRotation)
        earthParent.runAction(earthParentRotation)
        moonParent.runAction(moonRotation)
        mars.runAction(marsRotation)
        marsParent.runAction(marsParentRotation)
        jupiter.runAction(jupiterRotation)
        jupiterParent.runAction(jupiterParentRotation)
        saturn.runAction(saturnRotation)
        saturnParent.runAction(saturnParentRotation)
        saturnRingParent.runAction(saturnRingParentRotation)
        uranus.runAction(uranusRotation)
        uranusParent.runAction(uranusParentRotation)
        neptune.runAction(neptuneRotation)
        neptuneParent.runAction(neptuneParentRotation)
        
        mercuryParent.addChildNode(mercury)
        venusParent.addChildNode(venus)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        earth.addChildNode(moon)
        moonParent.addChildNode(moon)
        marsParent.addChildNode(mars)
        jupiterParent.addChildNode(jupiter)
        saturnParent.addChildNode(saturn)
        saturnParent.addChildNode(saturnRingParent)
        saturn.addChildNode(saturnRing)
        uranusParent.addChildNode(uranus)
        neptuneParent.addChildNode(neptune)
    }
    
    func makePlanet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }

    func doRotation(time: TimeInterval) -> SCNAction {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(rotation)
        return foreverRotation
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi/180
    }
}
