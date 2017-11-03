//
//  Satellite.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/10/28.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

// 衛生
class Satellite: HeavenlyBody {
    
    func create(diffuse: UIImage,
                radius: CGFloat,
                distance: Float,
                rotationSpeed: Double,
                x: Float,
                y: Float,
                z: Float) -> SCNNode {
        let planetParent = SCNNode()
        planetParent.position = SCNVector3(x, y, z)
        let parentRotation = doRotation(time: rotationSpeed)
        planetParent.runAction(parentRotation)
        let planet = makeRotatingPlanet(diffuse: diffuse, radius: radius, distance: distance)
        planet.renderingOrder = Consts.solarSystemRenderingOrder
        planetParent.addChildNode(planet)
        return planetParent
    }
    
    /// 回転する星を作成します
    ///
    /// - Parameters:
    ///   - diffuse: 表面
    ///   - radius: 大きさ
    /// - Returns: 回転する星
    func makeRotatingPlanet(diffuse: UIImage, radius: CGFloat, distance: Float) -> SCNNode {
        let mercury = makePlanet(geometry: SCNSphere(radius: radius), diffuse: diffuse, specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, distance))
        let mercuryRotation = doRotation(time: 5)
        mercury.runAction(mercuryRotation)
        return mercury
    }
    
    /// 星を作成します
    ///
    /// - Parameters:
    ///   - geometry: 物体
    ///   - diffuse: 表面
    ///   - specular: 鏡面
    ///   - emission: 大気
    ///   - normal: 通常面
    ///   - position: 位置
    /// - Returns: 星
    func makePlanet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    /// 回転させます
    ///
    /// - Parameter time: 回転スピード
    /// - Returns: 回転アクション
    func doRotation(time: TimeInterval) -> SCNAction {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(rotation)
        return foreverRotation
    }
}
