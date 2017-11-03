//
//  SaturnRing.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/11/03.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

class SaturnRing: Planet {
    
    func create(x: Float, y: Float, z: Float) -> SCNNode {
        let saturnRingTorus = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
        saturnRingTorus.pipeSegmentCount = 2
        let saturnRing = SCNNode(geometry: saturnRingTorus)
        saturnRing.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Saturn Ring")
        saturnRing.position = SCNVector3(x, y, z)
        saturnRing.renderingOrder = Consts.solarSystemRenderingOrder
        return saturnRing
    }
}
