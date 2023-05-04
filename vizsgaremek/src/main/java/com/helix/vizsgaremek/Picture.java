/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.helix.vizsgaremek;

import Configuration.Database;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.ParameterMode;
import javax.persistence.Persistence;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Csoszi
 */
@Entity
@Table(name = "picture")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Picture.findAll", query = "SELECT p FROM Picture p"),
    @NamedQuery(name = "Picture.findById", query = "SELECT p FROM Picture p WHERE p.id = :id"),
    @NamedQuery(name = "Picture.findByPictureUrl", query = "SELECT p FROM Picture p WHERE p.pictureUrl = :pictureUrl")})
public class Picture implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "picture_url")
    private String pictureUrl;
    @JoinColumn(name = "ad_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private AnimalAd adId;

    public Picture() {
    }

    public Picture(Integer id) {
        this.id = id;
    }

    public Picture(Integer id, String pictureUrl) {
        this.id = id;
        this.pictureUrl = pictureUrl;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    public AnimalAd getAdId() {
        return adId;
    }

    public void setAdId(AnimalAd adId) {
        this.adId = adId;
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
        if (!(object instanceof Picture)) {
            return false;
        }
        Picture other = (Picture) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.helix.vizsgaremek.Picture[ id=" + id + " ]";
    }
    
    public static String add_picture(Picture p){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
        EntityManager em = emf.createEntityManager();
        
        try{
            //Create SPQ and run it
            StoredProcedureQuery spq = em.createStoredProcedureQuery("add_picture");
            
            spq.registerStoredProcedureParameter("ad_id_in", Integer.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("picture_url_in", String.class, ParameterMode.IN);
            
            spq.setParameter("ad_id_in", p.getAdId().getId());
            spq.setParameter("picture_url_in", p.getPictureUrl());
            
            spq.execute();
            return "Új kép sikeresen hozzáadva a hírdetéshez!";
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
    
    public static String delete_picture(Integer id){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
        EntityManager em = emf.createEntityManager();
        
        try{
            //Create SPQ and run it
            StoredProcedureQuery spq = em.createStoredProcedureQuery("delete_picture");
            
            spq.registerStoredProcedureParameter("id_in", Integer.class, ParameterMode.IN);
              
            spq.setParameter("id_in", id);
            
            spq.execute();
            return "A kép törlésre került!";
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
    
}
