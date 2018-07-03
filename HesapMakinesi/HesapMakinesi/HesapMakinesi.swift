//
//  ViewController.swift
//  HesapMakinesi
//
//  Created by Olcay Taner YILDIZ on 1/8/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class HesapMakinesi: UIViewController {

    fileprivate var oncekiIslem: Character = "="
    fileprivate var oncekiSayi: Int = 0
    fileprivate var sayi:Int = 0
    fileprivate var hafiza:Int = 0

    @IBOutlet weak var sonuc: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sonuc.isEnabled = false
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func Dugme1Tikla(_ sender: UIButton) {
        sayiEkle(1)
    }
    
    @IBAction func Dugme2Tikla(_ sender: UIButton) {
        sayiEkle(2)
    }
    
    @IBAction func Dugme3Tikla(_ sender: UIButton) {
        sayiEkle(3)
    }
    
    @IBAction func Dugme4Tikla(_ sender: UIButton) {
        sayiEkle(4)
    }
    
    @IBAction func Dugme5Tikla(_ sender: UIButton) {
        sayiEkle(5)
    }
    
    @IBAction func Dugme6Tikla(_ sender: UIButton) {
        sayiEkle(6)
    }
    
    @IBAction func Dugme7Tikla(_ sender: UIButton) {
        sayiEkle(7)
    }
    
    @IBAction func Dugme8Tikla(_ sender: UIButton) {
        sayiEkle(8)
    }
    
    @IBAction func Dugme9Tikla(_ sender: UIButton) {
        sayiEkle(9)
    }
    
    @IBAction func Dugme0Tikla(_ sender: UIButton) {
        sayiEkle(0)
    }
    
    @IBAction func DugmeArtiTikla(_ sender: UIButton) {
        islemYap("+")
    }
    
    @IBAction func DugmeEksiTikla(_ sender: UIButton) {
        islemYap("-")
    }
    
    @IBAction func DugmeCarpiTikla(_ sender: UIButton) {
        islemYap("x")
    }
    
    @IBAction func DugmeBoluTikla(_ sender: UIButton) {
        islemYap("/")
    }
    
    @IBAction func DugmeEsitTikla(_ sender: UIButton) {
        islemYap("=")
        sayi = oncekiSayi
        oncekiSayi = 0
    }
    
    @IBAction func DugmeSilTikla(_ sender: UIButton) {
        sayi = 0
        ekrandaGoster(sayi)
    }
    
    @IBAction func DugmeHafizayaEkleTikla(_ sender: UIButton) {
        hafiza += sayi
        sayi = 0
    }
    
    @IBAction func DugmeHafizadanCikarTikla(_ sender: UIButton) {
        hafiza -= sayi
        sayi = 0
    }
    
    @IBAction func DugmeHafizayiGosterTikla(_ sender: UIButton) {
        sayi = hafiza
        ekrandaGoster(sayi)
    }
    
    @IBAction func DugmeHafizayiSilTikla(_ sender: UIButton) {
        hafiza = 0
    }
    
    func ekrandaGoster(_ sayi: Int){
        sonuc.text = String(format: "%d", sayi)
    }
    
    func sayiEkle(_ rakam: Int){
        sayi = sayi * 10 + rakam
        ekrandaGoster(sayi)
    }
    
    func islemYap(_ islem: Character){
        switch (oncekiIslem) {
            case "+":oncekiSayi = oncekiSayi + sayi
            case "-":oncekiSayi = oncekiSayi - sayi
            case "x":oncekiSayi = oncekiSayi * sayi
            case "/":if (sayi != 0){
                        oncekiSayi = oncekiSayi / sayi
                    }
            case "=":oncekiSayi = sayi
            default:break
        }
        oncekiIslem = islem
        sayi = 0
        ekrandaGoster(oncekiSayi)
    }

}

