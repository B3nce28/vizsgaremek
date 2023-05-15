import { Component, OnInit} from '@angular/core';
import { FormBuilder, FormGroup, Validators,FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { LoginService } from '../services/login.service';

@Component({
  selector: 'app-profil',
  templateUrl: './profil.component.html',
  styleUrls: ['./profil.component.css']
})
export class ProfilComponent implements OnInit {
  profileForm!: FormGroup;
  user!: any;
  addressForm!: FormGroup;

  constructor(private formBuilder: FormBuilder,  private router:Router, private userService: LoginService, private http: HttpClient) {
    this.user = JSON.parse(this.userService.getUserData());
   }

  ngOnInit() {
    this.profileForm = this.formBuilder.group({
      username: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(8)]],
      phoneNumber: ['', Validators.pattern('[0-9]*')],
      id:[this.user.id],
    });
    this.addressForm= this.formBuilder.group({
      county:['',Validators.required],
      city:['',Validators.required],
      zipCode:['',Validators.required]
    })
    this.getUserData();
  }

  updateUserData(): void {
    this.http.post(`http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/User/update_user`,this.profileForm.value)
    .subscribe((response) => {
    },
    (error) => {
      if(error.status == 200 && error.statusText == 'OK'){
        alert("A módosítások sikerese voltak")
      }
    }
  );

  }

  deleteProfile(): void {
    const id = this.user.id;
    this.http.post(`http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/User/delete_user`,id)
      .subscribe(
        (response) => {
          console.log('User deleted successfully!');
        },
        (error) => {
          if(error.status == 200 && error.statusText == 'OK'){
              this.router.navigate(['/login']);
              localStorage.clear()
          }
          console.log('Error deleting user:', error);
        }
      );
  }


  getUserData() {
    this.profileForm.setValue({
      id: this.user.id,
      username: this.user.username,
      email: this.user.email,
      password: this.user.password,
      phoneNumber: this.user.phoneNumber
    });
  }

}
