import { HttpClient } from '@angular/common/http';
import { Component,OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {

  public signupForm !: FormGroup;
  constructor(private formBuilder : FormBuilder, private http: HttpClient, private router:Router){}
  ngOnInit(): void {
    this.signupForm = this.formBuilder.group({
      username: ['', Validators.required],
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      email: ['', [Validators.required, Validators.pattern(/^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/)]],
      password: ['', [Validators.required, Validators.minLength(8)]],
      phoneNumber: ['', [Validators.required,  ]],
    })
    //Validators.pattern(/^(?!(\+0(\s|-)?(\(|\[\.\])?\s*0(\s|-)?(\)|\[\.\])?\s*0)).*(\+\d{1,3}\s?)?(\d{2,4}\s?\-?\s?\d{3}\s?\-?\s?\d{3,4})?(?!.*(\d)\1{9,}).{10,}$/)]

  }
  signUp(){
    this.http.post<any>("http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/User/Registration", this.signupForm.value)
    .subscribe(res=>{
      console.log(res);
      alert("a regisztáció sikeres volt");
      this.signupForm.reset();
      this.router.navigate(['login'])
    },err=>{
      console.log(err);
      alert("Valami nem sikerült")
    }
    )
  }

}
