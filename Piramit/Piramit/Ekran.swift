//
//  Ekran.swift
//  Piramit
//
//  Created by Olcay Taner YILDIZ on 1/9/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Ekran: UIView {

    var hucreGenislik : CGFloat = 0
    var bulmaca : Bulmaca?
    
    override func draw(_ rect:CGRect){
        var context: CGContext
        var alan : CGRect
        var x, y, solSira, fontBuyukluk : CGFloat
        context = UIGraphicsGetCurrentContext()!
        if let kareSayisi = bulmaca?.buyukluk{
            for i in 0..<kareSayisi{
                for j in 0...i{
                    if (bulmaca?.oynananDeger(i) != j){
                        context.setStrokeColor(UIColor.black.cgColor)
                        context.setLineWidth(1.0)
                    } else {
                        context.setStrokeColor(UIColor.blue.cgColor)
                        context.setLineWidth(3.0)
                    }
                    solSira = CGFloat(kareSayisi - i + 1 + 2 * j) / 2.0
                    x = solSira * hucreGenislik
                    y = CGFloat(i + 1) * hucreGenislik
                    alan = CGRect(x: x, y: y, width: hucreGenislik, height: hucreGenislik)
                    context.addRect(alan)
                    context.strokePath()
                    if let sayi = bulmaca?.sayi(i, sutun:j){
                        fontBuyukluk = hucreGenislik / 1.5
                        let ozellik = [NSFontAttributeName : UIFont.systemFont(ofSize: fontBuyukluk)]
                        let sayiYazi = NSMutableAttributedString(string:String(format: "%d", sayi), attributes:ozellik)
                        context.textMatrix = CGAffineTransform(scaleX: 1.0, y: -1.0)
                        context.textPosition = CGPoint(x: alan.origin.x + (hucreGenislik - sayiYazi.size().width) / 2, y: alan.origin.y + 1.5 * hucreGenislik - sayiYazi.size().height)
                        CTLineDraw(CTLineCreateWithAttributedString(sayiYazi), context)
                    }
                }
            }
        }
    }
    
}
