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

  constructor(private formBuilder: FormBuilder,  private router:Router, private userService: LoginService, private http: HttpClient) { }

  ngOnInit() {
    this.profileForm = this.formBuilder.group({
      username: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(8)]],
      phoneNumber: ['', Validators.pattern('[0-9]*')]
    });
    this.getUserData();
  }

  updateUserData(): void {
    if (this.profileForm.valid) {
      console.log('Profile saved successfully!');
      this.router.navigate(['/home']);
    } else {
      console.log('Profile form is invalid!');
    }
  }

  deleteProfile(): void {
    const id = this.user.id;
    this.http.delete(`http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/User/delete_user?id=${id}`)
      .subscribe(
        (response) => {
          console.log('User deleted successfully!');
          this.router.navigate(['/login']);
        },
        (error) => {
          console.log('Error deleting user:', error);
        }
      );
  }


  getUserData() {
    let user = JSON.parse(this.userService.getUserData());
    console.log(user);
    this.user = user;
    this.profileForm.setValue({
      username: user.username,
      email: user.email,
      password: user.password,
      phoneNumber: user.phoneNumber
    });
  }


}
