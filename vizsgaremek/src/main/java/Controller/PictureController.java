/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/GenericResource.java to edit this template
 */
package Controller;

import com.helix.vizsgaremek.Picture;
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
@Path("Picture")
public class PictureController {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of PictureController
     */
    public PictureController() {
    }

    /**
     * Retrieves representation of an instance of Controller.PictureController
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_XML)
    public String getXml() {
        //TODO return proper representation object
        throw new UnsupportedOperationException();
    }

    /**
     * PUT method for updating or creating an instance of PictureController
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.APPLICATION_XML)
    public void putXml(String content) {
    }
    
    @POST
    @Path("add_picture")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response add_picture(Picture picture){
        String result = Picture.add_picture(picture);
        return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
    @DELETE
    @Path("delete_picture")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response delete_picture(Picture picture){
        String result = Picture.delete_picture(picture.getId());
        return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
}
