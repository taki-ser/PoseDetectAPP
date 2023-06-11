//
//  PoseDetection.swift
//  PoseDetectAPP
//
//  Created by 滝瀬隆斗 on 2023/06/09.
//

import Vision
import UIKit

class PoseDetection {
    private var jointPointsLayer: CAShapeLayer?
    
    func bodyPoseDetect(from image: UIImage, _ imageSize: CGSize) {
        guard let cgImage = image.cgImage
        else {
            print("Image not found.")
            return
        }
        print("CGImageのサイズ：\(cgImage.width),\( cgImage.height)")
//        guard let cgImage = UIImage(named: "sample_small.jpg")?.cgImage else {
//            print("Image not found.")
//            return
//        }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNDetectHumanBodyPoseRequest(completionHandler: bodyPoseHandler)
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the request: \(error).")
        }
        
        
        
        func bodyPoseHandler(request: VNRequest, error: Error?) {
            guard let observations = request.results as? [VNHumanBodyPoseObservation] else { return }
            observations.forEach { processObservation($0) }
        }
        func processObservation(_ observation: VNHumanBodyPoseObservation) {
            guard let recognizedPoints = try? observation.recognizedPoints(.all) else { return }
            let torsoJointNames: [VNHumanBodyPoseObservation.JointName] = [
//                .neck,
//                .rightShoulder,
//                .rightHip,
//                .root,
//                .leftHip,
//                .leftShoulder,
//                .leftAnkle,
//                .leftElbow
                .root,
                .neck,
                .leftShoulder,
                .rightShoulder,
                .leftElbow,
                .rightElbow,
                .leftWrist,
                .rightWrist,
                .leftHip,
                .rightHip,
                .leftKnee,
                .rightKnee,
                .leftAnkle,
                .rightAnkle,
                .nose,
                .leftEye,
                .rightEye,
                .leftEar,
                .rightEar
            ]
            let imagePoints: [CGPoint] = torsoJointNames.compactMap {
                guard let point = recognizedPoints[$0], point.confidence > 0 else { return nil }
                let adjustedY = 1 - point.location.y
                //　Visionにおいて座標原点は左下のため、反転させる
                return VNImagePointForNormalizedPoint(CGPoint(x: point.location.x, y: adjustedY), Int(imageSize.width), Int(imageSize.height))
//                return VNImagePointForNormalizedPoint(point.location, Int(imageSize.width), Int(imageSize.height))
            }
            print(imagePoints)
            jointPointsLayer = draw(points: imagePoints)
        }
        
        func draw(points: [CGPoint]) -> CAShapeLayer {
            let jointPath = UIBezierPath()
            let jointsLayer = CAShapeLayer()
//            jointsLayer.frame = CGRect(x: 0, y: 0,
//                                      width: imageSize.width, height: imageSize.height)
            jointsLayer.fillColor = CGColor(red: 1, green: 0.0, blue: 0.0, alpha: 0.5)
            jointsLayer.strokeColor = CGColor(red: 1, green: 0.0, blue: 0.0, alpha: 0.5)
            for point in points {
                let nextJointPath = UIBezierPath(arcCenter: point, radius: 5, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                jointPath.append(nextJointPath)
//                jointPath.close()
            }
            print(jointPath.cgPath)
            jointsLayer.path = jointPath.cgPath
//            jointsLayer.strokeColor = UIColor.red.cgColor
//            jointsLayer.fillColor = UIColor.clear.cgColor
//            jointsLayer.lineWidth = 2.0
//            print(jointsLayer)
            return jointsLayer
        }
    }
    func showJointPointsLayer() -> CAShapeLayer? {
        return jointPointsLayer
    }
}

//let poseDetection = PoseDetection()
//poseDetection.bodyPoseDetect()
