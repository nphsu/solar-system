//
//  EarthMoon.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/10/28.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

class EarthMoon: Satellite {
    
    let size = CGFloat(0.01) // enumへ
    let distance = Float(-0.1) // enumへ
    let rotationSpeed = Double(3) // enumへ
    
    func create(x: Float, y: Float, z: Float) -> SCNNode {
        return super.create(diffuse: #imageLiteral(resourceName: "Moon"), radius: size, distance: distance, rotationSpeed: rotationSpeed, x: x, y: y, z: z)
    }
}
