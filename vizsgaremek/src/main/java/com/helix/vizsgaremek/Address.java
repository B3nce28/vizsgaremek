/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.helix.vizsgaremek;

import Configuration.Database;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.ParameterMode;
import javax.persistence.Persistence;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Csoszi
 */
@Entity
@Table(name = "address")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Address.findAll", query = "SELECT a FROM Address a"),
    @NamedQuery(name = "Address.findById", query = "SELECT a FROM Address a WHERE a.id = :id"),
    @NamedQuery(name = "Address.findByCounty", query = "SELECT a FROM Address a WHERE a.county = :county"),
    @NamedQuery(name = "Address.findByCity", query = "SELECT a FROM Address a WHERE a.city = :city"),
    @NamedQuery(name = "Address.findByZipCode", query = "SELECT a FROM Address a WHERE a.zipCode = :zipCode")})
public class Address implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "county")
    private String county;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "city")
    private String city;
    @Basic(optional = false)
    @NotNull
    @Column(name = "zip_code")
    private int zipCode;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "addressId")
    private Collection<AnimalAd> animalAdCollection;

    public Address() {
    }

    public Address(Integer id) {
        this.id = id;
    }

    public Address(Integer id, String county, String city, int zipCode) {
        this.id = id;
        this.county = county;
        this.city = city;
        this.zipCode = zipCode;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getZipCode() {
        return zipCode;
    }

    public void setZipCode(int zipCode) {
        this.zipCode = zipCode;
    }

    @XmlTransient
    public Collection<AnimalAd> getAnimalAdCollection() {
        return animalAdCollection;
    }

    public void setAnimalAdCollection(Collection<AnimalAd> animalAdCollection) {
        this.animalAdCollection = animalAdCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Address)) {
            return false;
        }
        Address other = (Address) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.helix.mavenproject1.Address[ id=" + id + " ]";
    }
    
    
        public static String add_new_address(Address a){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
        EntityManager em = emf.createEntityManager();
        
        try{
            //Create SPQ and run it
            StoredProcedureQuery spq = em.createStoredProcedureQuery("add_new_address");
            
            
            spq.registerStoredProcedureParameter("county_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("city_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("zip_code_in", Integer.class, ParameterMode.IN);
            
                           
            spq.setParameter("county_in", a.getCounty());
            spq.setParameter("city_in", a.getCity());
            spq.setParameter("zip_code_in", a.getZipCode());
            
            spq.execute();
            return "Új cím hozzáadva!";
        }
        catch(Exception ex){
            //Handle database exceptions
            if(ex.getMessage().equals("org.hibernate.exception.ConstraintViolationException: Error calling CallableStatement.getMoreResults")){
                return "Some unique value is duplicate!";
            }
            return "Hiba";
        }
        finally{
            //clean up metods, and close connections
            em.clear();
            em.close();
            emf.close();
        }        
    }
        
        public static String update_address(Address a){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
        EntityManager em = emf.createEntityManager();
        
        try{
            //Create SPQ and run it
            StoredProcedureQuery spq = em.createStoredProcedureQuery("update_address");
            
            spq.registerStoredProcedureParameter("id_in", Integer.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("county_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("city_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("zip_code_in", Integer.class, ParameterMode.IN);
            
                           
            spq.setParameter("id_in", a.getId());
            spq.setParameter("county_in", a.getCounty());
            spq.setParameter("city_in", a.getCity());
            spq.setParameter("zip_code_in", a.getZipCode());
            spq.execute();
            return "A cím adatainak megváltoztatása sikeresen végbement!";
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
            return "Hiba!";
    }
        finally{
            //clean up metods, and close connections
            em.clear();
            em.close();
            emf.close();
        }              
       }      
        
        public static String delete_address(Integer id){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
        EntityManager em = emf.createEntityManager();
        
        try{
            //Create SPQ and run it
            StoredProcedureQuery spq = em.createStoredProcedureQuery("delete_address");
            
            spq.registerStoredProcedureParameter("id_in", Integer.class, ParameterMode.IN);
              
            spq.setParameter("id_in", id);
            
            spq.execute();
            return "A cím törlésre került!";
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
            return "Hiba!";
    }
        finally{
            //clean up metods, and close connections
            em.clear();
            em.close();
            emf.close();
        }              
    }
        
        public static List<Address> get_all_address(){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
        EntityManager em = emf.createEntityManager();
        List<Address> addresses = new ArrayList();
        try{
            StoredProcedureQuery spq = em.createStoredProcedureQuery("get_all_address");
            List<Object[]> result = spq.getResultList();


            for(Object[] rekord : result){
                Integer id = Integer.parseInt(rekord[0].toString());
                String county = rekord[1].toString();
                String city = rekord[2].toString();
                Integer zipCode = Integer.parseInt(rekord[3].toString());
                                
                Address a = new Address(id,county,city,zipCode);
                addresses.add(a);
            }

            return addresses;
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
            return addresses;
        }
        finally{
            em.clear();
            em.close();
            emf.close();
        }
    } 
    
}
