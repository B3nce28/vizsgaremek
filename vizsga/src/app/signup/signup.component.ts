import { HttpClient } from '@angular/common/http';
import { Component,OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { phoneNumberValidator } from '../app.component';

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
      firstname: ['', Validators.required],
      lastname: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(8)]],
      phoneNumber: ['', [Validators.required, phoneNumberValidator]],
    })

  }
  signUp(){
    this.http.post<any>("http://localhost:3000/signupUsers", this.signupForm.value)
    .subscribe(res=>{
      alert("a regisztáció sikeres volt");
      this.signupForm.reset();
      this.router.navigate(['login'])
    },err=>{
      alert("Valami nem sikerült")
    }
    )
  }

}
