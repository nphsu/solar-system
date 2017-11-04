//
//  Venus.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/10/28.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

class Venus: Planet {
    
    let size = CGFloat(0.05) // enumへ
    let distance = Float(0.6) // enumへ
    let rotationSpeed = Double(15) // enumへ
    
    func create(x: Float, y: Float, z: Float) -> SCNNode {
        return super.create(diffuse: #imageLiteral(resourceName: "Venus"), radius: size, distance: distance, rotationSpeed: Double(rotationSpeed), x: x, y: y, z: z)
    }
}
