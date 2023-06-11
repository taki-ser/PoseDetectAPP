//
//  ViewController.swift
//  PoseDetectAPP
//
//  Created by 滝瀬隆斗 on 2023/06/09.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func ShowImage() {
        let poseDetection = PoseDetection()
        if let sampleImage = UIImage(named: "Image 1") {
            print("サンプルイメージの画素数:\(sampleImage.size.width), \(sampleImage.size.height)")
            print("画面上のサイズ:\(ImagePlace.frame.size.width), \(ImagePlace.frame.size.height)")
            ImagePlace.image = sampleImage
            poseDetection.bodyPoseDetect(from: sampleImage, ImagePlace.frame.size)
            if let overwrapLayer = poseDetection.showJointPointsLayer() {
//                print(overwrapLayer.path)
                ImagePlace.layer.addSublayer(overwrapLayer)
                
            } else {
                print("can't add Layer.")
            }
        }else {
            print("No images.")
        }
        
    }
    @IBOutlet weak var ImagePlace: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        描画できる以下
////        let path = UIBezierPath()
////        path.move(to: CGPoint(x: 50, y: 50))
////        path.addLine(to: CGPoint(x: 100, y: 100))
////        path.addLine(to: CGPoint(x: 0, y: 100))
////        path.close()
//        let patha = UIBezierPath()
//        for i in 1...3 {
//            let path = UIBezierPath(arcCenter: CGPoint(x:100*i, y:100*1), radius: 50, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
//            patha.append(path)
//        }
//        // CAShapeLayerを作成
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = patha.cgPath
//        print(shapeLayer.path)
//        shapeLayer.strokeColor = UIColor.red.cgColor
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.lineWidth = 2.0
//
//        // CAShapeLayerをUIImageViewのレイヤに追加
//        ImagePlace.layer.addSublayer(shapeLayer)
        
        
        // Do any additional setup after loading the view.
    }
//    private func initImageView(){
//            // UIImage インスタンスの生成
//            let image1:UIImage = UIImage(named:"serina")!
//
//            // UIImageView 初期化
//            let imageView = UIImageView(image:image1)
//
//            // スクリーンの縦横サイズを取得
//            let screenWidth:CGFloat = view.frame.size.width
//            let screenHeight:CGFloat = view.frame.size.height
//
//            // 画像の縦横サイズを取得
//            let imgWidth:CGFloat = image1.size.width
//            let imgHeight:CGFloat = image1.size.height
//
//            // 画像サイズをスクリーン幅に合わせる
//            let scale:CGFloat = screenWidth / imgWidth
//            let rect:CGRect =
//                CGRect(x:0, y:0, width:imgWidth*scale, height:imgHeight*scale)
//
//            // ImageView frame をCGRectで作った矩形に合わせる
//            imageView.frame = rect;
//
//            // 画像の中心を画面の中心に設定
//            imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
//
//            // UIImageViewのインスタンスをビューに追加
//            self.view.addSubview(imageView)
//
//        }

}
