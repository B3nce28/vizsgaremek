import { Component } from '@angular/core';
import { AbstractControl, ValidationErrors } from '@angular/forms';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'vizsgaremek';
}
export function phoneNumberValidator(control: AbstractControl): ValidationErrors | null {
  const phoneNumberRegex = /^(\+?\d{1,3}[- ]?)?\d{10}$/;

  if (!phoneNumberRegex.test(control.value)) {
    return { phoneNumber: true };
  }

  return null;
}
