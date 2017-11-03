//
//  Saturn.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/11/03.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

class Saturn: Planet {
    
    let size = CGFloat(0.12) // enumへ
    let distance = Float(1.8) // enumへ
    let rotationSpeed = Double(32) // enumへ
    
    func create(x: Float, y: Float, z: Float) -> SCNNode {
        let saturn = super.create(diffuse: #imageLiteral(resourceName: "Saturn"), radius: size, distance: distance, rotationSpeed: Double(rotationSpeed), x: x, y: y, z: z)
        let saturnRing = SaturnRing().create(x: distance, y: 0, z: 0)
        saturn.addChildNode(saturnRing)
        return saturn
    }
}
