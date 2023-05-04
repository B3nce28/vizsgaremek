import { Component, OnInit} from '@angular/core';
import { FormBuilder, FormGroup, Validators,FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { LoginService } from '../services/login.service';

@Component({
  selector: 'app-profil',
  templateUrl: './profil.component.html',
  styleUrls: ['./profil.component.css']
})
export class ProfilComponent implements OnInit {
  profileForm!: FormGroup;

  constructor(private formBuilder: FormBuilder,  private router:Router, private userService: LoginService) { }

  ngOnInit() {
    this.profileForm = this.formBuilder.group({
      username: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(8)]],
      phoneNumber: ['', Validators.pattern('[0-9]*')]
    });
  }

  saveProfile(): void {
    if (this.profileForm.valid) {
      console.log('Profile saved successfully!');
      this.router.navigate(['/home']);
    } else {
      console.log('Profile form is invalid!');
    }
  }

  deleteProfile(): void {
    console.log('Profile deleted successfully!');
    this.router.navigate(['/login']);
  }

  // getUserData() {
  //   this.userService.getUser().subscribe(
  //     user => {
  //       this.user = user;
  //       // az input mezőkbe betöltjük a felhasználó adatait
  //       this.profileForm.setValue({
  //         username: this.user.username,
  //         email: this.user.email,
  //         password: this.user.password,
  //         phoneNumber: this.user.phoneNumber
  //       });
  //     },
  //     error => console.log(error)
  //   );
  // }
}
