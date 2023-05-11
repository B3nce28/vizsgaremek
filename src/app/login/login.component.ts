import { Component, OnInit} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit{

  public loginForm!: FormGroup;
  constructor(private formBuilder : FormBuilder, private http: HttpClient, private router:Router){}

  ngOnInit(): void {
    this.loginForm = this.formBuilder.group({
      email: ['', [Validators.required, Validators.pattern(/^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/)]],
      password: ['', Validators.required,]
    })
  }

  login(addUser:any){
    this.http.post<any>("http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/User/login",addUser)
    .subscribe(res => {
      console.log(res);
      const user = [res].find((a: any) => {
      return a.email === this.loginForm.value.email && a.password === this.loginForm.value.password;
      });
      if (user) {
        localStorage.setItem('token', JSON.stringify(user))
        alert("A bejelentkezés sikeres volt ");
        this.loginForm.reset();
        this.router.navigate(['home']);
      } else {
        alert("A felhasználó nem található");
      }
    }
    // , err => {
    //   console.log(err);
    //   alert("valami hiba történt");
    // }
    );

  }

}

