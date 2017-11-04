//
//  Star.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/10/28.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

/// 恒星
class Star: HeavenlyBody {
    
    func doRotation(time: TimeInterval) -> SCNAction {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(rotation)
        return foreverRotation
    }
    
    func create(diffuse: UIImage,
                radius: CGFloat,
                rotationSpeed: Double,
                x: Float,
                y: Float,
                z: Float) -> SCNNode {
        let sun = SCNNode(geometry: SCNSphere(radius: radius))
        sun.position = SCNVector3(x, y, z)
        sun.geometry?.firstMaterial?.diffuse.contents = diffuse
        sun.renderingOrder = Consts.solarSystemRenderingOrder
        sun.runAction(doRotation(time: rotationSpeed))
        return sun
    }
}
