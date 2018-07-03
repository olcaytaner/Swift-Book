//
//  Parametre.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Parametre{
    var yasamSayisi : Int
    var cubuk : Cubuk
    var seviye : Seviye
    var puan : Int
    var ekranGenislik : CGFloat = 0
    var ekranYukseklik : CGFloat = 0
    fileprivate var toplar : [Top] = []
    fileprivate var dusenTuglalar : [DusenTugla] = []
    
    func yeniSeviye(_ seviye : Seviye){
        self.seviye = seviye
        cubuk = Cubuk(ekranGenislik: ekranGenislik, ekranYukseklik : ekranYukseklik)
        toplar.removeAll(keepingCapacity: false)
        toplar.append(Top(cubukX: cubuk.yer.origin.x, cubukY: cubuk.yer.origin.y, ekranGenislik: ekranGenislik))
    }
    
    init(genislik : CGFloat, yukseklik : CGFloat, seviye : Seviye){
        ekranGenislik = genislik
        ekranYukseklik = yukseklik
        yasamSayisi = 3
        puan = 0
        cubuk = Cubuk(ekranGenislik: ekranGenislik, ekranYukseklik : ekranYukseklik)
        self.seviye = seviye
        toplar.append(Top(cubukX: cubuk.yer.origin.x, cubukY: cubuk.yer.origin.y, ekranGenislik: ekranGenislik))
    }
    
    func topSayisi()->Int{
        return toplar.count
    }
    
    func top(_ pozisyon : Int)->Top{
        return toplar[pozisyon]
    }
    
    func dusenTuglaSayisi()->Int{
        return dusenTuglalar.count
    }
    
    func dusenTugla(_ pozisyon : Int)->DusenTugla{
        return dusenTuglalar[pozisyon]
    }
    
    func topSinirlarlaTemasKontrol(_ top : Top, index : Int)->Bool{
        var yeniTop : Top
        if (top.sinirlarlaTemas(ekranGenislik, ekranYukseklik : ekranYukseklik)){
            toplar.remove(at: index)
            if (toplar.count == 0){
                yasamSayisi -= 1
                if (yasamSayisi > 0){
                    yeniTop = Top(cubukX : cubuk.yer.origin.x, cubukY : cubuk.yer.origin.y, ekranGenislik : ekranGenislik)
                    toplar.append(yeniTop)
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    func topTuglaylaTemasKontrol(_ top : Top)->Bool{
        var tugla : Tugla
        var dusenTugla : DusenTugla
        for i in 0..<seviye.satir{
            for j in 0..<seviye.sutun{
                tugla = seviye.tugla(i, sutun : j)
                if (!tugla.kirildi && top.tuglaylaTemas(tugla)){
                    tugla.vuruldu()
                    if (tugla.kirildi){
                        if (tugla.tip != .zor){
                            puan += 10
                        }else{
                            puan += 20
                        }
                        if (tugla.tip != .normal && tugla.tip != .zor){
                            dusenTugla = DusenTugla(tip: tugla.tip, yer : tugla.yer, yukseklik : ekranYukseklik)
                            dusenTuglalar.append(dusenTugla)
                        }
                        if (seviye.bittiMi()){
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    func topCubuklaTemasKontrol(_ top : Top)->Bool{
        return top.cubuklaTemas(cubuk)
    }
    
    func elleCubukTemas(_ x : CGFloat, y : CGFloat)->Bool{
        if (x > cubuk.yer.origin.x && x < cubuk.yer.origin.x + cubuk.yer.size.width && y > cubuk.yer.origin.y && y < cubuk.yer.origin.y + cubuk.yer.size.height){
            return true
        } else {
            return false
        }
    }
    
    func cubukYeniX(_ x : CGFloat){
        if (x > 0 && x < ekranGenislik - cubuk.yer.size.width){
            cubuk.yeniPozisyon(x)
        }
    }
    
    func dusenTuglaCubuklaTemasKontrol()->Bool{
        var yeniTop : Top
        var dusenTugla : DusenTugla
        for i in 0..<dusenTuglalar.count{
            dusenTugla = dusenTuglalar[i]
            if (dusenTugla.cubuklaTemas(cubuk)){
                switch (dusenTugla.tip){
                    case .hizli:
                        for top in toplar{
                            top.hizlandir()
                        }
                    case .yavas:
                        for top in toplar{
                            top.yavaslat()
                        }
                    case .buyuk:
                        cubuk.buyult()
                    case .kucuk:
                        cubuk.kucult()
                    case .yasam:
                        yasamSayisi += 1
                    case .olum:
                        yasamSayisi -= 1
                        if (yasamSayisi == 0){
                            return false
                        }
                    case .coktop:
                        yeniTop = Top(cubukX : cubuk.yer.origin.x, cubukY : cubuk.yer.origin.y, ekranGenislik : ekranGenislik)
                        toplar.append(yeniTop)
                    default:
                        break
                }
                dusenTuglalar.remove(at: i)
                break
            }
        }
        return true
    }
}
