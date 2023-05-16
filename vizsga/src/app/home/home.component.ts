import { HttpClient } from '@angular/common/http';
import { Component, OnInit, Output } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { EventEmitter } from '@angular/core';
import { nev } from '../model/nev';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  constructor(private formBuilder : FormBuilder, private http: HttpClient, private router: Router){}

 hirdetes :any=[];
 nev!: nev;

  ngOnInit(): void {
    this.loadAds()
  }

  loadAds(){
    this.http.get<any>("http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/AnimalAd/get_all_ads")
    .subscribe(res=>{
      console.log(res)
      this.hirdetes = res;
    })
  }
  logout(){
    localStorage.removeItem('token');
    this.router.navigateByUrl("/login")
  }

  enteredSearchValue: string = ''

  @Output()
  searchTextChanged: EventEmitter<string> = new EventEmitter<string>();

  searchAd(){
    const text = document.getElementById('inputAnimal')as HTMLInputElement
    const city = document.getElementById('inputCity')as HTMLInputElement
    const nev : nev ={searchedWord1 : "",searchedWord2 : ""}
    const allat = text.value
    const varos = city.value
    if(allat!="" && varos!=""){
      const cardContent =document.getElementById('cardContent') as HTMLDivElement
      while(cardContent.firstChild){
        cardContent.removeChild(cardContent.firstChild)
      }
      nev.searchedWord1 = allat;
      nev.searchedWord2 = varos;
      this.http.post<nev>("http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/AnimalAd/search_ads",nev)
      .subscribe(res=>{
        for(const data of Object.values(res)){
          const kartya = `<div class="container" style="display: flex;">
          <mat-card class="example-card" style="background-color: #fff;
          border-radius: 10px;
          box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.15);
          max-width: 400px;
          width: 100%;">
            <mat-card-header>
              <mat-card-title>${data.title}</mat-card-title>
              <mat-card-title>${data.lostOrFund}</mat-card-title>
              <mat-card-title>${data.speciesOfAnimal}</mat-card-title>
              <img mat-card-image src="">
            </mat-card-header>
            <mat-card-content>
              <p>Felhasználó: ${data.userId.username}</p>
              <p>Elérhetőség: ${data.userId.email}</p>
              <p>${data.description}</p>
              <p>Eltűnés dátuma: ${data.date}</p>
              <p>Feltöltés dátuma: ${data.dateOfAdd}</p>
              <mat-card-subtitle>${data.addressId.county+' '+data.addressId.zipCode+' '+data.addressId.city}</mat-card-subtitle>
            </mat-card-content>
            <mat-card-actions *ngIf="userId == ad.userId.id">
            </mat-card-actions>
          </mat-card>
        </div>`
        cardContent.innerHTML += kartya
        }

      })
    }
  }


}
