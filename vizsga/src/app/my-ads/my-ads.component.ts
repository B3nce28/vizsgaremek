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
export class MyAdsComponent {

  adsForm!: FormGroup;

  constructor(private formBuilder : FormBuilder, private http: HttpClient, private router:Router, private _dialog : MatDialog){}

  ngOninit(){

  }
  onSubmit(): void{

  }
  openAddAds() {
    const dialogRef = this._dialog.open(AddAdsComponent);
    dialogRef.afterClosed().subscribe({
      next: (val) => {
        if (val) {
          //this.getEmployeeList();
        }
      },
    });
  }

}
