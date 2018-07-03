//
//  Ekran.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Ekran : UIView{
    var parametre : Parametre?
    
    func tuglaRenk(_ tip : TuglaTip)->UIColor{
        switch (tip){
            case .normal:
                return UIColor.black
            case .zor:
                return UIColor.brown
            case .hizli:
                return UIColor.blue
            case .yavas:
                return UIColor.cyan
            case .buyuk:
                return UIColor.orange
            case .kucuk:
                return UIColor.green
            case .yasam:
                return UIColor.magenta
            case .olum:
                return UIColor.red
            case .coktop:
                return UIColor.yellow
        }
    }

    override func draw(_ rect:CGRect){
        var context: CGContext
        var alan : CGRect
        var seviye : Seviye
        var cizilenTugla : Tugla
        var cubuk : Cubuk
        var top : Top
        var dusenTugla : DusenTugla
        var renk : UIColor
        var fontBuyukluk : CGFloat
        context = UIGraphicsGetCurrentContext()!
        seviye = parametre!.seviye
        for i in 0..<seviye.satir{
            for j in 0..<seviye.sutun{
                cizilenTugla = seviye.tugla(i, sutun:j)
                if (!cizilenTugla.kirildi){
                    renk = tuglaRenk(cizilenTugla.tip)
                    context.setFillColor(renk.cgColor)
                    context.fill(cizilenTugla.yer)
                    context.setStrokeColor(UIColor.gray.cgColor)
                    context.addRect(cizilenTugla.yer)
                    context.strokePath()
                }
            }
        }
        cubuk = parametre!.cubuk
        context.setFillColor(UIColor.darkGray.cgColor)
        context.fill(cubuk.yer)
        context.setStrokeColor(UIColor.gray.cgColor)
        context.addRect(cubuk.yer)
        context.strokePath()
        for i in 0..<parametre!.topSayisi(){
            top = parametre!.top(i)
            alan = CGRect(x: top.merkez.x - top.yariCap, y: top.merkez.y - top.yariCap, width: 2 * top.yariCap, height: 2 * top.yariCap)
            context.setFillColor(UIColor.purple.cgColor)
            context.fillEllipse(in: alan)
        }
        for i in 0..<parametre!.dusenTuglaSayisi(){
            dusenTugla = parametre!.dusenTugla(i)
            renk = tuglaRenk(dusenTugla.tip)
            context.setFillColor(renk.cgColor)
            context.fillEllipse(in: dusenTugla.yer)
        }
        top = parametre!.top(0)
        for i in 0..<parametre!.yasamSayisi{
            alan = CGRect(x: 5.0 + CGFloat(i * 2) * top.yariCap, y: parametre!.cubuk.yer.origin.y + 1.4 * parametre!.cubuk.yer.size.height, width: 1.6 * top.yariCap, height: 1.6 * top.yariCap)
            context.setFillColor(UIColor.purple.cgColor)
            context.fillEllipse(in: alan)
        }
        fontBuyukluk = parametre!.ekranGenislik * 12 / 300
        let puanOzellik = [NSFontAttributeName : UIFont.systemFont(ofSize: fontBuyukluk)]
        context.textMatrix = CGAffineTransform(scaleX: 1.0, y: -1.0)
        let puanYazi = NSMutableAttributedString(string:String(format: "%d", parametre!.puan), attributes:puanOzellik)
        context.textPosition = CGPoint(x : parametre!.ekranGenislik - puanYazi.size().width, y : parametre!.ekranYukseklik - 10 - puanYazi.size().height)
        CTLineDraw(CTLineCreateWithAttributedString(puanYazi), context)
        fontBuyukluk = parametre!.ekranGenislik * 12 / 100
        let seviyeOzellik = [NSFontAttributeName : UIFont.systemFont(ofSize: fontBuyukluk)]
        let seviyeYazi = NSMutableAttributedString(string:String(format: "Seviye %d", parametre!.seviye.seviyeNo + 1), attributes:seviyeOzellik)
        context.textPosition = CGPoint(x : parametre!.ekranGenislik / 2 - seviyeYazi.size().width / 2, y : parametre!.ekranYukseklik / 2)
        CTLineDraw(CTLineCreateWithAttributedString(seviyeYazi), context)
    }
    
}
