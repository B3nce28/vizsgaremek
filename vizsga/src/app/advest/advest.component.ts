import { HttpClient } from '@angular/common/http';
import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-advest',
  templateUrl: './advest.component.html',
  styleUrls: ['./advest.component.css']
})
export class AdvestComponent implements OnInit {

  constructor(private http: HttpClient, private router:Router){}

  @Input() ad!: any
  @Input() userId!: number

  ngOnInit(): void {
    console.log(this.ad.userId)
    if(this.userId >0){

    }else{this.userId== -1}

  }


  deletePost(): void{
    const id = this.ad.id
    this.http.post(`http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/AnimalAd/delete_ad`,id)
    .subscribe((res)=>{
      console.log('post törlése sikeres volt')
    },
    (error)=>{
    if(error.status == 200 && error.statusText == 'OK'){
      window.location.reload();
          }
          console.log(error);
    }
    )


  }

}
