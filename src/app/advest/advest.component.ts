import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-advest',
  templateUrl: './advest.component.html',
  styleUrls: ['./advest.component.css']
})
export class AdvestComponent implements OnInit {


  @Input() ad!: any
  @Input() userId!: number

  ngOnInit(): void {
    if(this.userId >0){

    }else{this.userId== -1}

  }



}
