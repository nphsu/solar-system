//
//  Mercury.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/10/28.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit


/// 水星
class Mercury: Planet {
    
    let size = CGFloat(0.02) // enumへ
    let distance = Float(0.3) // enumへ
    let rotationSpeed = Double(10) // enumへ
    
    func create(x: Float, y: Float, z: Float) -> SCNNode {
        return super.create(diffuse: #imageLiteral(resourceName: "Mercury"), radius: size, distance: distance, rotationSpeed: rotationSpeed, x: x, y: y, z: z)
    }
}
