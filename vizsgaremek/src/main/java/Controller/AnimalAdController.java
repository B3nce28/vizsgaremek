/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/GenericResource.java to edit this template
 */
package Controller;

import com.helix.vizsgaremek.AnimalAd;
import java.util.List;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * REST Web Service
 *
 * @author Csoszi
 */
@Path("AnimalAd")
public class AnimalAdController {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of AnimalAdController
     */
    public AnimalAdController() {
    }

    /**
     * Retrieves representation of an instance of Controller.AnimalAdController
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_XML)
    public String getXml() {
        //TODO return proper representation object
        throw new UnsupportedOperationException();
    }

    /**
     * PUT method for updating or creating an instance of AnimalAdController
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.APPLICATION_XML)
    public void putXml(String content) {
    }
    
    @POST
    @Path("create_new_ad")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response create_new_ad(AnimalAd ad){
        String result = AnimalAd.create_new_ad(ad);
        return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
    
    @DELETE
    @Path("delete_ad")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response delete_ad(AnimalAd ad){
        String result = AnimalAd.delete_ad(ad.getId());
        return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
    
    @POST
    @Path("update_ad")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response update_ad(AnimalAd ad){
        String result = AnimalAd.update_ad(ad);
        return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
    @GET
    @Path("get_all_ads")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response get_all_ads(){
    List<AnimalAd> result = AnimalAd.get_all_ads();
    return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
    @POST
    @Path("search_ads")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response search_ads(){
    List<AnimalAd> result = AnimalAd.search_ads("searchedWord1", "searchedWord2");
    return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
}
