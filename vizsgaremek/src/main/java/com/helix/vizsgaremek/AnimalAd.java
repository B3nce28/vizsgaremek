/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.helix.vizsgaremek;

import Configuration.Database;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
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
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.ParameterMode;
import javax.persistence.Persistence;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Csoszi
 */
@Entity
@Table(name = "animal_ad")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AnimalAd.findAll", query = "SELECT a FROM AnimalAd a"),
    @NamedQuery(name = "AnimalAd.findById", query = "SELECT a FROM AnimalAd a WHERE a.id = :id"),
    @NamedQuery(name = "AnimalAd.findBySpeciesOfAnimal", query = "SELECT a FROM AnimalAd a WHERE a.speciesOfAnimal = :speciesOfAnimal"),
    @NamedQuery(name = "AnimalAd.findByTitle", query = "SELECT a FROM AnimalAd a WHERE a.title = :title"),
    @NamedQuery(name = "AnimalAd.findByDescription", query = "SELECT a FROM AnimalAd a WHERE a.description = :description"),
    @NamedQuery(name = "AnimalAd.findByDate", query = "SELECT a FROM AnimalAd a WHERE a.date = :date"),
    @NamedQuery(name = "AnimalAd.findByDateOfAdd", query = "SELECT a FROM AnimalAd a WHERE a.dateOfAdd = :dateOfAdd"),
    @NamedQuery(name = "AnimalAd.findByLostOrFund", query = "SELECT a FROM AnimalAd a WHERE a.lostOrFund = :lostOrFund")})
public class AnimalAd implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "species_of_animal")
    private String speciesOfAnimal;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "title")
    private String title;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2000)
    @Column(name = "description")
    private String description;
    @Basic(optional = false)
    @NotNull
    @Column(name = "date")
    @Temporal(TemporalType.DATE)
    private Date date;
    @Basic(optional = false)
    @NotNull
    @Column(name = "date_of_add")
    @Temporal(TemporalType.DATE)
    private Date dateOfAdd;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "lost_or_fund")
    private String lostOrFund;
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private User userId;
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "animalAd")
    private Address address;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "adId")
    private Collection<Picture> pictureCollection;

    public AnimalAd() {
    }

    public AnimalAd(Integer id) {
        this.id = id;
    }

    public AnimalAd(Integer id, String speciesOfAnimal, String title, String description, Date date, Date dateOfAdd, String lostOrFund) {
        this.id = id;
        this.speciesOfAnimal = speciesOfAnimal;
        this.title = title;
        this.description = description;
        this.date = date;
        this.dateOfAdd = dateOfAdd;
        this.lostOrFund = lostOrFund;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSpeciesOfAnimal() {
        return speciesOfAnimal;
    }

    public void setSpeciesOfAnimal(String speciesOfAnimal) {
        this.speciesOfAnimal = speciesOfAnimal;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getDateOfAdd() {
        return dateOfAdd;
    }

    public void setDateOfAdd(Date dateOfAdd) {
        this.dateOfAdd = dateOfAdd;
    }

    public String getLostOrFund() {
        return lostOrFund;
    }

    public void setLostOrFund(String lostOrFund) {
        this.lostOrFund = lostOrFund;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    @XmlTransient
    public Collection<Picture> getPictureCollection() {
        return pictureCollection;
    }

    public void setPictureCollection(Collection<Picture> pictureCollection) {
        this.pictureCollection = pictureCollection;
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
        if (!(object instanceof AnimalAd)) {
            return false;
        }
        AnimalAd other = (AnimalAd) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.helix.vizsgaremek.AnimalAd[ id=" + id + " ]";
    }
    
        public static String create_new_ad(AnimalAd a){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
        EntityManager em = emf.createEntityManager();
        
        try{
            //Create SPQ and run it
            StoredProcedureQuery spq = em.createStoredProcedureQuery("create_new_ad");
            
            spq.registerStoredProcedureParameter("user_id_in", Integer.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("species_of_animal_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("title_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("description_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("date_in", Date.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("lost_or_fund_in", String.class, ParameterMode.IN);
                           
            spq.setParameter("user_id_in", a.getUserId());
            spq.setParameter("species_of_animal_in", a.getSpeciesOfAnimal());
            spq.setParameter("title_in", a.getTitle());
            spq.setParameter("description_in", a.getDescription());
            spq.setParameter("date_in", a.getDate());
            spq.setParameter("lost_or_fund_in", a.getLostOrFund());
            
            spq.execute();
            return "Új hírdetés sikeresen létre lett hozva!";
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
    
        
        public static String delete_ad(Integer id){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
        EntityManager em = emf.createEntityManager();
        
        try{
            //Create SPQ and run it
            StoredProcedureQuery spq = em.createStoredProcedureQuery("delete_ad");
            
            spq.registerStoredProcedureParameter("id_in", Integer.class, ParameterMode.IN);
              
            spq.setParameter("id_in", id);
            
            spq.execute();
            return "A hírdetés törlésre került!";
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
