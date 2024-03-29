import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { LoginComponent } from './login/login.component';
import { MyAdsComponent } from './my-ads/my-ads.component';
import { ProfilComponent } from './profil/profil.component';
import { SignupComponent } from './signup/signup.component';
import { AuthGuard } from './shared/auth.guard';

const routes: Routes = [
  {path:'',redirectTo:'login',pathMatch:'full'},
  {path: 'login' ,component:LoginComponent},
  {path: 'signup' ,component:SignupComponent},
  {path: 'home' ,component:HomeComponent,canActivate: [AuthGuard]},
  {path: 'profil',component:ProfilComponent,  canActivate: [AuthGuard]},
  {path:'my-ads', component:MyAdsComponent,canActivate: [AuthGuard] }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
