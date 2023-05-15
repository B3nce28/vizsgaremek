import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { MatRadioButton } from '@angular/material/radio';
import { AddAdsComponent } from '../add-ads/add-ads.component';

@Component({
  selector: 'app-my-ads',
  templateUrl: './my-ads.component.html',
  styleUrls: ['./my-ads.component.css']
})
export class MyAdsComponent  {

  adsForm!: FormGroup;
  hirdetes: any[]=[];
  user: any;

  constructor(private formBuilder : FormBuilder, private http: HttpClient, private router:Router, private _dialog : MatDialog){
    this.user = JSON.parse(localStorage.getItem('token')!)
  }

  ngOnInit(){
    this.loadMyAds()
  }
  onSubmit(): void{

  }
  openAddAds() {
    const dialogRef = this._dialog.open(AddAdsComponent);
    dialogRef.afterClosed().subscribe({
      next: (val) => {
        if (val) {
        }
      },
    });
  }

  loadMyAds(){
    this.http.get<any>("http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/AnimalAd/get_all_ads")
    .subscribe(res=>{
      console.log(res)
      this.filterAds(res)
    })
  }

  filterAds(ads:any[]){
    console.log("A bejelentkezett user id",this.user.id)
    ads.forEach(ad => {
      console.log("hírdetés user id",ad.userId.id)
      if(this.user.id == ad.userId.id){
        this.hirdetes.push(ad)
      }
    });
  }
}
