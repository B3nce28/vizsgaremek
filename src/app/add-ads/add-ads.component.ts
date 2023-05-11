import { group } from '@angular/animations';
import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-add-ads',
  templateUrl: './add-ads.component.html',
  styleUrls: ['./add-ads.component.css']
})
export class AddAdsComponent {


  constructor(private formBuilder : FormBuilder, private http: HttpClient, private router:Router){}

  public adsForm!: FormGroup



  ngOnInit(): void {
    let user = JSON.parse(localStorage.getItem('token')!)
    this.adsForm = this.formBuilder.group({
      speciesOfAnimal:['',Validators.required],
      title:['',Validators.required],
      description:['',Validators.required],
      date:['',Validators.required],
      userId:[user.id],
      lostOrFund:['talált'],
      address:this.formBuilder.group({
        county:['',Validators.required],
        city:['',Validators.required],
        zipCode:['',Validators.pattern('')]
      })
    })


  }

  onFormSubmit(){
    this.http.post<any>("http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/AnimalAd/create_new_ad", this.adsForm.value)
    .subscribe(res=>{
      console.log(res);
      alert("a hírdetés feladás sikeres volt");
      this.adsForm.reset();
      this.router.navigate(['my-ads'])
    },err=>{ if(err.status != 200){
      console.log(err);
      alert("Valami nem sikerült")
    }else{
      alert("a hírdetés feladás sikeres volt");}
    }
    )
  }

  get address(){
    return this.adsForm.get('address') as FormGroup;
  }
}

