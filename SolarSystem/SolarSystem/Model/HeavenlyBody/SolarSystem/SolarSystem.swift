//
//  SolarSystem.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/10/28.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

class SolarSystem {
    
    var nodeList: Array<SCNNode>
    
    init(x: Float, y: Float, z: Float) {
        let sun = Sun().create(x: x, y: y, z: z)
        let mercury = Mercury().create(x: x, y: y, z: z)
        let venus = Venus().create(x: x, y: y, z: z)
        let earth = Earth().create(x: x, y: y, z: z)
        let mars = Mars().create(x: x, y: y, z: z)
        let jupiter = Jupiter().create(x: x, y: y, z: z)
        let saturn = Saturn().create(x: x, y: y, z: z)
        let uranus = Uranus().create(x: x, y: y, z: z)
        let neptune = Neptune().create(x: x, y: y, z: z)
        self.nodeList = [sun, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune]
    }
   
    func getNodeList() -> Array<SCNNode> {
        return self.nodeList
    }
}
