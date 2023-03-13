/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.helix.vizsgaremek;

import Configuration.Database;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.ParameterMode;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;


/**
 *
 * @author Csoszi
 */
@Entity
@Table(name = "user")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "User.findAll", query = "SELECT u FROM User u"),
    @NamedQuery(name = "User.findById", query = "SELECT u FROM User u WHERE u.id = :id"),
    @NamedQuery(name = "User.findByFirstName", query = "SELECT u FROM User u WHERE u.firstName = :firstName"),
    @NamedQuery(name = "User.findByLastName", query = "SELECT u FROM User u WHERE u.lastName = :lastName"),
    @NamedQuery(name = "User.findByEmail", query = "SELECT u FROM User u WHERE u.email = :email"),
    @NamedQuery(name = "User.findByUsername", query = "SELECT u FROM User u WHERE u.username = :username"),
    @NamedQuery(name = "User.findByPassword", query = "SELECT u FROM User u WHERE u.password = :password"),
    @NamedQuery(name = "User.findByPhoneNumber", query = "SELECT u FROM User u WHERE u.phoneNumber = :phoneNumber"),
    @NamedQuery(name = "User.findByDateOfRegistration", query = "SELECT u FROM User u WHERE u.dateOfRegistration = :dateOfRegistration")})
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    public static boolean authenticate(String username, String password) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "first_name")
    private String firstName;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "last_name")
    private String lastName;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "email")
    private String email;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "username")
    private String username;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "password")
    private String password;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "phone_number")
    private String phoneNumber;
    @Basic(optional = false)
    @NotNull
    @Column(name = "date_of_registration")
    @Temporal(TemporalType.DATE)
    private Date dateOfRegistration;
    //@OneToMany(cascade = CascadeType.ALL, mappedBy = "userId")
    //private Collection<AnimalAd> animalAdCollection;

    public User() {
    }

    public User(Integer id) {
        this.id = id;
    }

    public User(Integer id, String firstName, String lastName, String email, String username, String password, String phoneNumber, Date dateOfRegistration) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.username = username;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.dateOfRegistration = dateOfRegistration;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getDateOfRegistration() {
        return dateOfRegistration;
    }

    public void setDateOfRegistration(Date dateOfRegistration) {
        this.dateOfRegistration = dateOfRegistration;
    }

//    @XmlTransient
//    public Collection<AnimalAd> getAnimalAdCollection() {
//        return animalAdCollection;
//    }

//    public void setAnimalAdCollection(Collection<AnimalAd> animalAdCollection) {
//        this.animalAdCollection = animalAdCollection;
//    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof User)) {
            return false;
        }
        User other = (User) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.helix.vizsgaremek.User[ id=" + id + " ]";
    }
    
    public static String Registration(User u){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
        EntityManager em = emf.createEntityManager();
        
        try{
            //Create SPQ and run it
            StoredProcedureQuery spq = em.createStoredProcedureQuery("Registration");
            
            spq.registerStoredProcedureParameter("first_name_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("last_name_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("email_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("username_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("password_in", String.class, ParameterMode.IN);
            spq.registerStoredProcedureParameter("phone_number_in", String.class, ParameterMode.IN);
            
               
            spq.setParameter("first_name_in", u.getFirstName());
            spq.setParameter("last_name_in", u.getLastName());
            spq.setParameter("email_in", u.getLastName());
            spq.setParameter("username_in", u.getUsername());
            spq.setParameter("password_in", u.getPassword());
            spq.setParameter("phone_number_in", u.getPhoneNumber());
            
            spq.execute();
            return "Sikeres regisztráció!";
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
    
    public static List<User> get(){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
        EntityManager em = emf.createEntityManager();
        List<User> users = new ArrayList();
        try{
            StoredProcedureQuery spq = em.createStoredProcedureQuery("get_all_user");
            List<Object[]> result = spq.getResultList();


            for(Object[] rekord : result){
                Integer id = Integer.parseInt(rekord[0].toString());
                String firstName = rekord[1].toString();
                String  lastName = rekord[2].toString();
                String email = rekord[3].toString();
                String username = rekord[4].toString();
                String password = rekord[5].toString();
                String phoneNumber = rekord[6].toString();
                
                
                User u = new User(id,firstName,lastName,email,username,password,phoneNumber, null);
                users.add(u);
            }



            return users;
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
            return users;
        }
        finally{
            em.clear();
            em.close();
            emf.close();
        }
    } 
    
   public static Boolean login(String username, String password) {
    EntityManagerFactory emf = Persistence.createEntityManagerFactory(Database.getPuName());
    EntityManager em = emf.createEntityManager();
    try {
        StoredProcedureQuery spq = em.createStoredProcedureQuery("login");
        spq.registerStoredProcedureParameter("username_in", String.class, ParameterMode.IN);
        spq.registerStoredProcedureParameter("password_in", String.class, ParameterMode.IN);
        spq.registerStoredProcedureParameter("result_out", Integer.class, ParameterMode.OUT);
        spq.setParameter("username_in", username);
        spq.setParameter("password_in", password);
        spq.execute();
        int result = (int) spq.getOutputParameterValue("result_out");
        if (result == 1) {
            return true;
        } else {
            return false;
        }
        
    }
    catch(Exception ex){
            System.out.println(ex.getMessage());
            return false;
    }
    
    finally {
        em.clear();
        em.close();
        emf.close();
    }
   }
        
   
}
