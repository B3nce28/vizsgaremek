/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Configuration;

/**
 *
 * @author Csoszi
 */
public class Database {
     private static final String persistnceUnitName = "com.Helix_vizsgaremek_war_1.0-SNAPSHOTPU";
    
    public static String getPuName(){
        return Database.persistnceUnitName;
    }
}
