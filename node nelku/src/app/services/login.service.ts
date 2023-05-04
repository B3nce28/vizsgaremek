import { Injectable } from '@angular/core';
import {HttpClientModule} from '@angular/common/http';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  private apiUrl = 'http://127.0.0.1:8080/vizsgaremek-1.0-SNAPSHOT/webresources/User';
  constructor(private http:HttpClient) { }

  getUserData(): any{
    return localStorage.getItem('token');
    // this.http.get(`${this.apiUrl}/current-user`);
  }

  updateUserData():any {
    //return localStorage.setItem();
  }

  deleteAccount(): Observable<any> {
    return this.http.delete(`${this.apiUrl}/current-user`);
  }


}


