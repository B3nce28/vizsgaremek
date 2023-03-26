/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.helix.vizsgaremek;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
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
@Table(name = "password_replacement")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PasswordReplacement.findAll", query = "SELECT p FROM PasswordReplacement p"),
    @NamedQuery(name = "PasswordReplacement.findById", query = "SELECT p FROM PasswordReplacement p WHERE p.id = :id"),
    @NamedQuery(name = "PasswordReplacement.findByEmail", query = "SELECT p FROM PasswordReplacement p WHERE p.email = :email"),
    @NamedQuery(name = "PasswordReplacement.findByToken", query = "SELECT p FROM PasswordReplacement p WHERE p.token = :token"),
    @NamedQuery(name = "PasswordReplacement.findByTokenExpire", query = "SELECT p FROM PasswordReplacement p WHERE p.tokenExpire = :tokenExpire"),
    @NamedQuery(name = "PasswordReplacement.findByUsed", query = "SELECT p FROM PasswordReplacement p WHERE p.used = :used"),
    @NamedQuery(name = "PasswordReplacement.findByIsDeleted", query = "SELECT p FROM PasswordReplacement p WHERE p.isDeleted = :isDeleted")})
public class PasswordReplacement implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "email")
    private String email;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 256)
    @Column(name = "token")
    private String token;
    @Basic(optional = false)
    @NotNull
    @Column(name = "token_expire")
    @Temporal(TemporalType.TIMESTAMP)
    private Date tokenExpire;
    @Basic(optional = false)
    @NotNull
    @Column(name = "used")
    private boolean used;
    @Basic(optional = false)
    @NotNull
    @Column(name = "is_deleted")
    private boolean isDeleted;

    public PasswordReplacement() {
    }

    public PasswordReplacement(Integer id) {
        this.id = id;
    }

    public PasswordReplacement(Integer id, String email, String token, Date tokenExpire, boolean used, boolean isDeleted) {
        this.id = id;
        this.email = email;
        this.token = token;
        this.tokenExpire = tokenExpire;
        this.used = used;
        this.isDeleted = isDeleted;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Date getTokenExpire() {
        return tokenExpire;
    }

    public void setTokenExpire(Date tokenExpire) {
        this.tokenExpire = tokenExpire;
    }

    public boolean getUsed() {
        return used;
    }

    public void setUsed(boolean used) {
        this.used = used;
    }

    public boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
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
        if (!(object instanceof PasswordReplacement)) {
            return false;
        }
        PasswordReplacement other = (PasswordReplacement) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.helix.vizsgaremek.PasswordReplacement[ id=" + id + " ]";
    }
    
}
