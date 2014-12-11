package org.javaee7.samples.employees;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

/**
 * @author Arun Gupta
 */
@Path("employees")
public class EmployeeEndpoint {

    @PersistenceContext
    EntityManager em;
    
//    public void persist(Employee e) {
//        em.persist(e);
//    }
    
    @GET
    public List<Employee> get() {
        return em.createNamedQuery("Employee.findAll", Employee.class).getResultList();
    }
}
