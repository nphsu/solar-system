//
//  Sun.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/10/28.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

// 太陽
class Sun : Star {
    
    let size = CGFloat(0.20)
    let rotationTime = Double(20)
    
    func create(x: Float, y: Float, z: Float) -> SCNNode {
        return super.create(diffuse: #imageLiteral(resourceName: "Sun"), radius: size, rotationSpeed: rotationTime, x: x, y: y, z: z)
    }
}

