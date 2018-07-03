//
//  ViewController.swift
//  SatrancTaslari
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class SatrancTaslari: UIViewController {

    @IBOutlet weak var zamanGosterge: UILabel!
    @IBOutlet var ekran: Ekran!
    var bulmaca : Bulmaca?
    var bitti : Bool = false
    var soruSayisi : Int = 0
    var bulmacalar : [Bulmaca] = []
    var cozum : Cozum?
    var zamanlayici : Timer?
    var gecenSaniye : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ekran.tahtaGenislik = UIScreen.main.bounds.size.width
        ekran.hucreGenislik = ekran.tahtaGenislik / 10
        dosyaOku()
        yeniOyun()
    }

    func dosyaOku(){
        var dosyaAdi, dosyaIcerik : String
        var ayirici : Scanner
        var x : Int = 0
        var y: Int = 0
        var tehditSayisi : Int = 0
        var kareSayisi : Int = 0
        var kare : Kare
        var tehdit : Tehdit
        dosyaAdi = Bundle.main.path(forResource: "bulmacalar", ofType: "txt")!
        dosyaIcerik = try! String(contentsOfFile:dosyaAdi, encoding:String.Encoding.utf8)
        ayirici = Scanner(string: dosyaIcerik)
        ayirici.scanInt(&soruSayisi)
        for _ in 0..<soruSayisi{
            bulmaca = Bulmaca()
            if let bulmaca = bulmaca{
                for _ in 0...7{
                    ayirici.scanInt(&x)
                    ayirici.scanInt(&y)
                    kare = Kare(x : x - 1, y : y - 1)
                    bulmaca.yerlestirilecekYerEkle(kare)
                }
                ayirici.scanInt(&kareSayisi)
                for _ in 0..<kareSayisi{
                    ayirici.scanInt(&x)
                    ayirici.scanInt(&y)
                    ayirici.scanInt(&tehditSayisi)
                    tehdit = Tehdit(x : x - 1, y : y - 1, tehditSayisi : tehditSayisi)
                    bulmaca.tehditEkle(tehdit)
                }
                bulmacalar.append(bulmaca)
            }
        }
    }
    
    func yeniOyun(){
        bitti = false
        bulmaca = bulmacalar[Int(arc4random_uniform(UInt32(bulmacalar.count)))]
        ekran.tablo.removeAll(keepingCapacity: false)
        ekran.tahtayaKonduMu.removeAll(keepingCapacity: false)
        for _ in 0...7{
            ekran.tablo.append(-1)
            ekran.tahtayaKonduMu.append(false)
        }
        ekran.hareketEdiyor = false
        ekran.bulmaca = bulmaca
        gecenSaniye = 0
        if let zamanlayici = zamanlayici{
            zamanlayici.invalidate()
        }
        zamanlayici = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SatrancTaslari.onTimer), userInfo: nil, repeats: true)
        ekran.setNeedsDisplay()
    }
    
    func cozumKontrol(){
        var mesaj : String = ""
        var alarm : UIAlertView
        cozum = Cozum()
        if let cozum = cozum{
            if let bulmaca = bulmaca{
                for i in 0...7{
                    cozum.tasNoIleEkle(ekran.tablo[i])
                    if (!bulmaca.sartlariSaglar(cozum)){
                        mesaj = "Çözümünüz yanlış!"
                    } else {
                        mesaj = "Çözümünüz doğru!"
                    }
                }
            }
        }
        alarm = UIAlertView(title:"Bulmaca Bitti!", message:mesaj, delegate:self, cancelButtonTitle:"Vazgec")
        alarm.show()
    }
    
    func cozumArama(){
        var adaylar : [Tas] = []
        if let bulmaca = bulmaca{
            if let cozum = cozum{
                if (!bulmaca.sartlariSimdilikSaglar(cozum)){
                    return
                } else {
                    if (cozum.tasSayisi() == 8){
                        if (bulmaca.sartlariSaglar(cozum)){
                            bitti = true
                        }
                    }
                    else{
                        adaylar = cozum.adaylariOlustur()
                        for tas in adaylar{
                            cozum.tasEkle(tas)
                            cozumArama()
                            if (bitti){
                                return
                            }
                            cozum.tasCikar()
                        }
                    }
                }
            }
        }
    }
    
    func coz(){
        bitti = false
        cozum = Cozum()
        cozumArama()
        if let cozum = cozum{
            ekran.tablo.removeAll(keepingCapacity: false)
            ekran.tahtayaKonduMu.removeAll(keepingCapacity: false)
            for i in 0...7{
                ekran.tablo.append(cozum.tasNo(i))
                ekran.tahtayaKonduMu.append(true)
            }
        }
    }
    
    func onTimer(){
        gecenSaniye += 1
        if (gecenSaniye % 60 < 10){
            if (gecenSaniye < 600){
                zamanGosterge.text = String(format:"0%d:0%d", gecenSaniye / 60, gecenSaniye % 60)
            } else {
                zamanGosterge.text = String(format:"%d:0%d", gecenSaniye / 60, gecenSaniye % 60)
            }
        } else {
            if (gecenSaniye < 600){
                zamanGosterge.text = String(format:"0%d:%2d", gecenSaniye / 60, gecenSaniye % 60)
            } else {
                zamanGosterge.text = String(format:"%d:%2d", gecenSaniye / 60, gecenSaniye % 60)
            }
        }
    }

    @IBAction func hareketEttir(_ hareketAlgilayici: UIPanGestureRecognizer) {
        var pozisyon, posx, posy: Int
        var x, y: CGFloat
        var p : CGPoint
        p = hareketAlgilayici.location(in: hareketAlgilayici.view)
        x = p.x
        y = p.y - 50
        if let bulmaca = bulmaca{
            if (hareketAlgilayici.state == UIGestureRecognizerState.began){
                if (y < 9 * ekran.hucreGenislik){
                    posx = Int(x / ekran.hucreGenislik - 1)
                    posy = Int(y / ekran.hucreGenislik - 1)
                    pozisyon = bulmaca.yerlestirilecekYerNo(posy, y : posx)
                    if (pozisyon != -1 && ekran.tablo[pozisyon] != -1){
                        ekran.hangiTas = pozisyon + 8
                        ekran.hareketEdiyor = true
                        ekran.setNeedsDisplay()
                    }
                } else {
                    posx = Int(x / ekran.hucreGenislik - 1)
                    if (posx >= 0 && posx < 8 && !ekran.tahtayaKonduMu[posx]){
                        ekran.hangiTas = posx
                        ekran.hareketEdiyor = true
                        ekran.setNeedsDisplay()
                    }
                }
            } else {
                if (hareketAlgilayici.state == UIGestureRecognizerState.ended){
                    ekran.hareketEdiyor = false
                    if (y < 9 * ekran.hucreGenislik){
                        posx = Int(x / ekran.hucreGenislik - 1)
                        posy = Int(y / ekran.hucreGenislik - 1)
                        pozisyon = bulmaca.yerlestirilecekYerNo(posy, y : posx)
                        if (pozisyon != -1 && ekran.tablo[pozisyon] == -1 && ekran.hangiTas >= 0 && ekran.hangiTas < 8 && !ekran.tahtayaKonduMu[ekran.hangiTas]){
                            ekran.tahtayaKonduMu[ekran.hangiTas] = true
                            ekran.tablo[pozisyon] = ekran.hangiTas
                        }
                    } else {
                        posx = Int(x / ekran.hucreGenislik - 1)
                        if (posx >= 0 && posx < 8 && ekran.hangiTas >= 8 && ekran.tahtayaKonduMu[ekran.tablo[ekran.hangiTas - 8]]){
                            ekran.tahtayaKonduMu[ekran.tablo[ekran.hangiTas - 8]] = false
                            ekran.tablo[ekran.hangiTas - 8] = -1
                        }
                    }
                    ekran.setNeedsDisplay()
                } else {
                    if (hareketAlgilayici.state == UIGestureRecognizerState.changed){
                        ekran.hareketX = x - ekran.hucreGenislik / 2
                        ekran.hareketY = y - ekran.hucreGenislik / 2
                        ekran.setNeedsDisplay()
                    }
                }
            }
        }
    }
    
    @IBAction func kontrolEtTikla(_ sender: UIButton) {
        cozumKontrol()
        if let zamanlayici = zamanlayici{
            zamanlayici.invalidate()
        }
    }
    
    @IBAction func yeniOyunTikla(_ sender: UIButton) {
        yeniOyun()
    }
    
    @IBAction func cozTikla(_ sender: UIButton) {
        coz()
        ekran.setNeedsDisplay()
        if let zamanlayici = zamanlayici{
            zamanlayici.invalidate()
        }
    }
    
}

