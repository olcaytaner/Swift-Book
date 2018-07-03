//
//  Seviye.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Seviye{
    var satir : Int = 0
    var sutun : Int = 0
    var seviyeNo : Int = 0
    fileprivate var satirlar : [[Tugla]] = []
    fileprivate var tuglaGenislik : CGFloat = 0
    fileprivate var tuglaYukseklik : CGFloat = 0
    
    init(satir : Int, sutun : Int, genislik : CGFloat, seviyeNo : Int){
        self.satir = satir
        self.sutun = sutun
        self.seviyeNo = seviyeNo
        tuglaGenislik = genislik / CGFloat(sutun)
        tuglaYukseklik = 0.7 * tuglaGenislik
    }
    
    func bittiMi()->Bool{
        var tugla : Tugla
        for i in 0..<satir{
            for j in 0..<sutun{
                tugla = satirlar[i][j]
                if (!tugla.kirildi){
                    return false
                }
            }
        }
        return true
    }
    
    func tugla(_ satir : Int, sutun : Int)->Tugla{
        return satirlar[satir][sutun]
    }
    
    func satirAyarla(_ satirNo : Int, satirBilgi : String){
        var yer: CGRect
        var satirEklenen : [Tugla] = []
        for i in 0..<satirBilgi.characters.count{
            yer = CGRect(x: CGFloat(i) * tuglaGenislik, y: CGFloat(satirNo) * tuglaYukseklik, width: tuglaGenislik, height: tuglaYukseklik)
            switch (satirBilgi[satirBilgi.characters.index(satirBilgi.startIndex, offsetBy: i)]){
                case "1":
                    satirEklenen.append(Tugla(tip: .normal, yer: yer))
                case "2":
                    satirEklenen.append(Tugla(tip: .zor, yer: yer))
                case "3":
                    satirEklenen.append(Tugla(tip: .hizli, yer: yer))
                case "4":
                    satirEklenen.append(Tugla(tip: .yavas, yer: yer))
                case "5":
                    satirEklenen.append(Tugla(tip: .buyuk, yer: yer))
                case "6":
                    satirEklenen.append(Tugla(tip: .kucuk, yer: yer))
                case "7":
                    satirEklenen.append(Tugla(tip: .yasam, yer: yer))
                case "8":
                    satirEklenen.append(Tugla(tip: .olum, yer: yer))
                case "9":
                    satirEklenen.append(Tugla(tip: .coktop, yer: yer))
                default:
                    break
            }
        }
        satirlar.append(satirEklenen)
    }

}
