//
//  ViewController.swift
//  EhliyetSinavi
//
//  Created by Olcay Taner YILDIZ on 1/11/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class EhliyetSinavi: UIViewController {

    @IBOutlet weak var soru: UITextView!
    @IBOutlet weak var cevap1: UIButton!
    @IBOutlet weak var cevap2: UIButton!
    @IBOutlet weak var cevap3: UIButton!
    @IBOutlet weak var cevap4: UIButton!
    var tercihler : Tercihler?
    var konular : Konular?
    var trafikSoruSayisi : Int = 10
    var motorSoruSayisi : Int = 10
    var ilkYardimSoruSayisi : Int = 10
    var dogruCevapSayisi : Int = 0
    var soruNo : Int = 0
    var dogruCevap : Int = 0
    var sorular : [Soru] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soru.isEditable = false
        soruDosyasiOku()
        tercihleriOku()
        sinaviBaslat()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func tercihleriOku(){
        let temelTercihListesi : NSDictionary = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "TemelTercihler", ofType: "plist")!)!
        UserDefaults.standard.register(defaults: temelTercihListesi as! [String : AnyObject])
        let temelTercihler = UserDefaults.standard
        tercihler = Tercihler(trafikVarMi: temelTercihler.bool(forKey: "trafikVarMi"), motorVarMi: temelTercihler.bool(forKey: "motorVarMi"), ilkYardimVarMi: temelTercihler.bool(forKey: "ilkYardimVarMi"), trafikSoruSayisi: temelTercihler.integer(forKey: "trafikSoruSayisi"), motorSoruSayisi: temelTercihler.integer(forKey: "motorSoruSayisi"), ilkYardimSoruSayisi: temelTercihler.integer(forKey: "ilkYardimSoruSayisi"))
    }
    
    func soruDosyasiOku(){
        var dosyaAdi, dosyaIcerik : String
        var satirlar, soruIcerik : [String]
        var yeniSoru : Soru
        dosyaAdi = Bundle.main.path(forResource: "ehliyet", ofType: "txt")!
        do{
            dosyaIcerik = try String(contentsOfFile:dosyaAdi, encoding:String.Encoding.utf16)
        }
        catch{
            dosyaIcerik = ""
        }
        satirlar = dosyaIcerik.components(separatedBy: "\n")
        sorular = []
        for soru in satirlar{
            soruIcerik = soru.components(separatedBy: ";")
            if (soruIcerik[0] == "T" || soruIcerik[0] == "M" || soruIcerik[0] == "Y"){
                if (soruIcerik[6] == "A" || soruIcerik[6] == "B" || soruIcerik[6] == "C" || soruIcerik[6] == "D"){
                    yeniSoru = Soru(soruTipi:soruIcerik[0], soruCumle:soruIcerik[1], cevap1:soruIcerik[2], cevap2:soruIcerik[3], cevap3:soruIcerik[4], cevap4:soruIcerik[5], dogruCevap:soruIcerik[6])
                    sorular.append(yeniSoru)
                }
            }
        }
    }
    
    func simdikiSoruyuBul()->Soru?{
        var hangiSoru, i : Int
        var soruTipi : String
        if (soruNo < trafikSoruSayisi){
            hangiSoru = soruNo
            soruTipi = "T"
        } else {
            if (soruNo < trafikSoruSayisi + motorSoruSayisi){
                hangiSoru = soruNo - trafikSoruSayisi
                soruTipi = "M"
            } else {
                hangiSoru = soruNo - trafikSoruSayisi - motorSoruSayisi
                soruTipi = "Y"
            }
        }
        i = 0
        for soru in sorular{
            if (soru.soruTipi == soruTipi){
                if (i == hangiSoru){
                    return soru
                } else {
                    i += 1
                }
            }
        }
        return nil
    }
    
    func karistir(){
        var kalan, degistirilen : Int
        var geciciSoru : Soru
        for i in 0..<sorular.count{
            kalan = sorular.count - i
            degistirilen = i + Int(arc4random_uniform(UInt32(kalan)))
            geciciSoru = sorular[i]
            sorular[i] = sorular[degistirilen]
            sorular[degistirilen] = geciciSoru
        }
    }
    
    func simdikiSoruyuGoster(){
        var soruNoYazi : String
        if let simdikiSoru = simdikiSoruyuBul(){
            soruNoYazi = String(format: "%d) ", soruNo + 1)
            soru.text = soruNoYazi + simdikiSoru.soruCumle
            cevap1.setTitle("A) " + simdikiSoru.cevap1, for: UIControlState())
            cevap2.setTitle("B) " + simdikiSoru.cevap2, for: UIControlState())
            cevap3.setTitle("C) " + simdikiSoru.cevap3, for: UIControlState())
            cevap4.setTitle("D) " + simdikiSoru.cevap4, for: UIControlState())
            if (simdikiSoru.dogruCevap == "A"){
                dogruCevap = 1
            } else {
                if (simdikiSoru.dogruCevap == "B"){
                    dogruCevap = 2
                } else {
                    if (simdikiSoru.dogruCevap == "C"){
                        dogruCevap = 3
                    } else {
                        dogruCevap = 4
                    }
                }
            }
        }
    }
    
    func sinaviBaslat(){
        if let _tercihler = tercihler{
            if (!_tercihler.trafikVarMi){
                trafikSoruSayisi = 0
            }else{
                trafikSoruSayisi = _tercihler.trafikSoruSayisi
            }
            if (!_tercihler.motorVarMi){
                motorSoruSayisi = 0
            }else{
                motorSoruSayisi = _tercihler.motorSoruSayisi
            }
            if (!_tercihler.ilkYardimVarMi){
                ilkYardimSoruSayisi = 0
            }else{
                ilkYardimSoruSayisi = _tercihler.ilkYardimSoruSayisi
            }
        }
        soruNo = 0
        dogruCevapSayisi = 0
        karistir()
        simdikiSoruyuGoster()
        cevap1.isEnabled = true
        cevap2.isEnabled = true
        cevap3.isEnabled = true
        cevap4.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        var konular : Konular
        if (segue.identifier == "tercihSecimi"){
            konular = segue.destination as! Konular
            konular.tercihler = tercihler
        }
    }
    
    @IBAction func unwindToEhliyetSinavi(_ unwindSegue: UIStoryboardSegue){
        if (unwindSegue.identifier == "sinaviYenidenBaslat"){
            tercihleriOku()
            sinaviBaslat()
        }
    }

    @IBAction func sinaviBaslatTikla(_ sender: UIButton) {
        sinaviBaslat()
    }
    
    @IBAction func cevapTikla(_ sender: UIButton) {
        var mesaj : String
        var alarm : UIAlertView
        if (sender.tag == dogruCevap){
            dogruCevapSayisi += 1
        }
        soruNo += 1
        if (soruNo < trafikSoruSayisi + motorSoruSayisi + ilkYardimSoruSayisi){
            simdikiSoruyuGoster()
        } else {
            mesaj = String(format:"%d soruyu doğru cevapladınız!", dogruCevapSayisi)
            alarm = UIAlertView(title:"Sınav Bitti!", message:mesaj, delegate:self, cancelButtonTitle:"Vazgec")
            alarm.show()
            cevap1.isEnabled = false
            cevap2.isEnabled = false
            cevap3.isEnabled = false
            cevap4.isEnabled = false
        }
    }
}

