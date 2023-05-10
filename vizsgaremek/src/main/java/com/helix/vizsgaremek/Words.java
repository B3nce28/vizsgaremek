/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.helix.vizsgaremek;

/**
 *
 * @author Csoszi
 */
public class Words {
    private String searchedWord1;
    private String searchedWord2;

    public Words(String searchedWord1, String searchedWord2) {
        this.searchedWord1 = searchedWord1;
        this.searchedWord2 = searchedWord2;
    }

    public Words() {
    }

    public String getSearchedWord1() {
        return searchedWord1;
    }

    public void setSearchedWord1(String searchedWord1) {
        this.searchedWord1 = searchedWord1;
    }

    public String getSearchedWord2() {
        return searchedWord2;
    }

    public void setSearchedWord2(String searchedWord2) {
        this.searchedWord2 = searchedWord2;
    }
    
    
    
}
