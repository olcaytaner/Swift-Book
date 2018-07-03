//
//  ViewController.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class TuglaKirmaca: UIViewController {
    fileprivate var oyun : Oyun?
    fileprivate var seviyeNo : Int = 0
    fileprivate var zamanlayici : Timer?
    fileprivate var hareketBasladi : Bool = false
    fileprivate var ekranGenislik : CGFloat = 0
    fileprivate var ekranYukseklik : CGFloat = 0
    fileprivate var fark : CGFloat = 0
    @IBOutlet var ekran: Ekran!
    
    func yeniSeviye(){
        seviyeNo += 1
        ekran.parametre!.yeniSeviye(oyun!.seviye(seviyeNo))
        zamanlayici = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TuglaKirmaca.onTimer), userInfo: nil, repeats: true)
    }

    override func viewDidLoad() {
        var oyunParametre : Parametre
        super.viewDidLoad()
        ekranGenislik = UIScreen.main.bounds.size.width
        ekranYukseklik = UIScreen.main.bounds.size.height
        seviyeNo = 0
        oyun = Oyun(dosyaAd: "seviyeler", genislik: ekranGenislik)
        oyunParametre = Parametre(genislik: ekranGenislik, yukseklik: ekranYukseklik, seviye: oyun!.seviye(seviyeNo))
        ekran.parametre = oyunParametre
        zamanlayici = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TuglaKirmaca.onTimer), userInfo: nil, repeats: true)
    }
    
    func onTimer(){
        var top : Top
        var dusenTugla : DusenTugla
        for i in 0..<ekran.parametre!.topSayisi(){
            top = ekran.parametre!.top(i)
            top.hareketEttir()
            ekran.parametre!.topCubuklaTemasKontrol(top)
            if (ekran.parametre!.topTuglaylaTemasKontrol(top)){
                zamanlayici?.invalidate()
                yeniSeviye()
                return
            }
            if (!ekran.parametre!.topSinirlarlaTemasKontrol(top, index: i)){
                zamanlayici?.invalidate()
            }
        }
        for i in 0..<ekran.parametre!.dusenTuglaSayisi(){
            dusenTugla = ekran.parametre!.dusenTugla(i)
            dusenTugla.hareketEttir()
            if (!ekran.parametre!.dusenTuglaCubuklaTemasKontrol()){
                zamanlayici?.invalidate()
            }
            ekran.setNeedsDisplay()
        }
    }

    @IBAction func hareketEttir(_ hareketAlgilayici: UIPanGestureRecognizer) {
        var p : CGPoint
        p = hareketAlgilayici.location(in: hareketAlgilayici.view)
        if (hareketAlgilayici.state == UIGestureRecognizerState.began){
            if (ekran.parametre!.elleCubukTemas(p.x, y : p.y)){
                fark = p.x - ekran.parametre!.cubuk.yer.origin.x
                hareketBasladi = true
            } else {
                hareketBasladi = false
            }
        } else {
            if (hareketAlgilayici.state == UIGestureRecognizerState.ended){
                if (hareketBasladi){
                    ekran.parametre!.cubukYeniX(p.x - fark)
                    ekran.setNeedsDisplay()
                }
                hareketBasladi = false
            } else {
                if (hareketAlgilayici.state == UIGestureRecognizerState.changed){
                    if (hareketBasladi){
                        ekran.parametre!.cubukYeniX(p.x - fark)
                        ekran.setNeedsDisplay()
                    }
                }
            }
        }
    }
}

