//
//  Oyun.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Oyun{
    fileprivate var seviyeler : [Seviye] = []
    fileprivate var seviyeSayisi : Int = 0

    init(dosyaAd : String, genislik : CGFloat){
        var dosyaAdi, dosyaIcerik : String
        var ayirici : Scanner
        var satir : Int = 0
        var sutun : Int = 0
        var seviye : Seviye
        var satirBilgi : NSString?
        dosyaAdi = Bundle.main.path(forResource: dosyaAd, ofType: "txt")!
        do{
            dosyaIcerik = try String(contentsOfFile:dosyaAdi, encoding:String.Encoding.utf8)
        }
        catch{
            dosyaIcerik = ""
        }
        ayirici = Scanner(string: dosyaIcerik)
        ayirici.scanInt(&seviyeSayisi)
        for i in 0..<seviyeSayisi{
            ayirici.scanInt(&satir)
            ayirici.scanInt(&sutun)
            seviye = Seviye(satir : satir, sutun : sutun, genislik : genislik, seviyeNo : i)
            for j in 0..<satir{
                ayirici.scanUpTo("\n", into : &satirBilgi)
                seviye.satirAyarla(j, satirBilgi : satirBilgi! as String)
            }
            seviyeler.append(seviye)
        }
    }
    
    func seviye(_ pozisyon : Int)->Seviye{
        return seviyeler[pozisyon]
    }
}
