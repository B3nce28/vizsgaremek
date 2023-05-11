/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/GenericResource.java to edit this template
 */
package Controller;

import com.helix.vizsgaremek.Address;
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
@Path("Address")
public class AddressController {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of Address
     */
    public AddressController() {
    }

    /**
     * Retrieves representation of an instance of Controller.Address
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_XML)
    public String getXml() {
        //TODO return proper representation object
        throw new UnsupportedOperationException();
    }

    /**
     * PUT method for updating or creating an instance of Address
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.APPLICATION_XML)
    public void putXml(String content) {
    }
    
    @POST
    @Path("add_new_address")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response add_new_address(Address address){
        String result = Address.add_new_address(address);
        return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
    
    @POST
    @Path("update_address")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response update_address(Address address){
        String result = Address.update_address(address);
        return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
    
    @POST
    @Path("delete_address")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response delete_address(Address address){
        String result = Address.delete_address(address.getId());
        return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
    @GET
    @Path("get_all_address")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response get_all_address(){
    List<Address> result = Address.get_all_address();
    return Response.status(Response.Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
    }
}
