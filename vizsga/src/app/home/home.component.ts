import { HttpClient } from '@angular/common/http';
import { Component, OnInit, Output } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { EventEmitter } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  constructor(private formBuilder : FormBuilder, private http: HttpClient, private router: Router){}

 hirdetes :any=[];


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

  onSearchTextChanged(){
    this.searchTextChanged.emit()
  }


}
