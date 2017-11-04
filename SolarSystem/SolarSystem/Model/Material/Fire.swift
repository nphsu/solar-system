//
//  Fire.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/11/04.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

struct Fire {
    
    func createFire(x: Float, y: Float, z: Float) -> SCNNode {
        let fireNode = SCNNode()
        fireNode.position = SCNVector3(x: x, y: y, z: z)
        let fire = SCNParticleSystem(named: "Fire.scnp", inDirectory: "")
        fireNode.addParticleSystem(fire!)
        return fireNode
    }
}
