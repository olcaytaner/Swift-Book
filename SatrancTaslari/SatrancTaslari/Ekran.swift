//
//  Ekran.swift
//  SatrancTaslari
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Ekran : UIView{
    var tahtaGenislik : CGFloat = 0
    var hucreGenislik : CGFloat = 0
    var bulmaca : Bulmaca?
    var tablo : [Int] = []
    var tahtayaKonduMu : [Bool] = []
    var hareketX : CGFloat = 0
    var hareketY : CGFloat = 0
    var hareketEdiyor : Bool = false
    var hangiTas : Int = -1

    func tasResim(_ tas : Int)->UIImage{
        switch (tas){
            case 0:
                return UIImage(named:"sah.png")!
            case 1:
                return UIImage(named:"vezir.png")!
            case 2, 3:
                return UIImage(named:"kale.png")!
            case 4, 5:
                return UIImage(named:"fil.png")!
            case 6, 7:
                return UIImage(named:"at.png")!
            default:
                return UIImage(named:"sah.png")!
        }
    }
    
    override func draw(_ rect:CGRect){
        var x, y : Int
        let UST : CGFloat = 50
        var context: CGContext
        var rectangle, alan : CGRect
        var tas, sayi : UIImage
        var tehdit : Tehdit
        var W, H, w, h, l, posx, posy : CGFloat
        context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(UIColor.black.cgColor)
        for i in 0...8{
            context.move(to: CGPoint(x: CGFloat(i + 1) * hucreGenislik, y: hucreGenislik + UST))
            context.addLine(to: CGPoint(x: CGFloat(i + 1) * hucreGenislik, y: 9 * hucreGenislik + UST))
            context.strokePath()
            context.move(to: CGPoint(x: hucreGenislik, y: CGFloat(i + 1) * hucreGenislik + UST))
            context.addLine(to: CGPoint(x: 9 * hucreGenislik, y: CGFloat(i + 1) * hucreGenislik + UST))
            context.strokePath()
        }
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(3.0)
        if let bulmaca = bulmaca{
            for i in 0..<bulmaca.yerlestirilecekYerSayisi(){
                let kare : Kare = bulmaca.yerlestirilecekYer(i)
                x = kare.x
                y = kare.y
                if (tablo[i] == -1){
                    rectangle = CGRect(x: CGFloat(y + 1) * hucreGenislik, y: UST + CGFloat(x + 1) * hucreGenislik, width: hucreGenislik, height: hucreGenislik)
                    context.addRect(rectangle)
                    context.strokePath()
                } else {
                    if (hareketEdiyor && hangiTas >= 8 && hangiTas - 8 == i){
                        tas = tasResim(tablo[i])
                        alan = CGRect(x: hareketX, y: UST + hareketY, width: hucreGenislik - 2, height: hucreGenislik - 2)
                        tas.draw(in: alan)
                    } else {
                        tas = tasResim(tablo[i])
                        alan = CGRect(x: CGFloat(y + 1) * hucreGenislik + 1, y: UST + CGFloat(x + 1) * hucreGenislik + 1, width: hucreGenislik - 1, height: hucreGenislik - 1)
                        tas.draw(in: alan)
                    }
                }
            }
            for i in 0..<bulmaca.tehditSayisi(){
                tehdit = bulmaca.tehdit(i)
                x = tehdit.x
                y = tehdit.y
                posx = CGFloat(y + 1) * hucreGenislik - 2
                posy = CGFloat(x + 1) * hucreGenislik
                let sayiString : String = String(format:"%d.png", tehdit.tehditSayisi)
                sayi = UIImage(named:sayiString)!
                w = sayi.size.width
                h = sayi.size.height
                l = hucreGenislik / 2
                if (h > w){
                    W = (w * l) / h
                    alan = CGRect(x: posx + (hucreGenislik - W) / 2, y: UST + posy + (hucreGenislik - l) / 2, width: hucreGenislik / 2, height: hucreGenislik / 2)
                    sayi.draw(in: alan)
                } else {
                    H = (h * l) / w
                    alan = CGRect(x: posx + (hucreGenislik - l) / 2, y: UST + posy + (hucreGenislik - H) / 2, width: hucreGenislik / 2, height: hucreGenislik / 2)
                    sayi.draw(in: alan)
                }
            }
        }
        for i in 0...7{
            if (!tahtayaKonduMu[i]){
                if (hareketEdiyor && hangiTas < 8 && hangiTas == i){
                    tas = tasResim(i)
                    alan = CGRect(x: hareketX, y: UST + hareketY, width: hucreGenislik - 2, height: hucreGenislik - 2)
                    tas.draw(in: alan)
                } else {
                    tas = tasResim(i)
                    alan = CGRect(x: CGFloat(i + 1) * hucreGenislik + 1, y: UST + 9 * hucreGenislik + 1, width: hucreGenislik - 1, height: hucreGenislik - 1)
                    tas.draw(in: alan)
                }
            }
        }
    }

}
