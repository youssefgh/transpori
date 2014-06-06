/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.dao.impl;

import com.transportation.transportation.ejb.dao.DaoUser;
import com.transportation.transportation.model.entities.User;
import java.io.Serializable;
import javax.ejb.Stateless;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

/**
 *
 * @author youssef
 */
@Stateless
public class DaoUserImpl extends DaoGenericImpl<User> implements DaoUser, Serializable {

    public DaoUserImpl() {
        super(User.class);
    }

    @Override
    public User findByName(User user) {System.out.println(getDb().findOne(new Query().addCriteria(Criteria.where("name").is(user.getName())), getEntityClass()).getClass().toString());
        return getDb().findOne(new Query().addCriteria(Criteria.where("name").is(user.getName())), getEntityClass());
    }
    
    @Override
    public Boolean isNameExist(User user){
        return getDb().exists(new Query().addCriteria(Criteria.where("name").is(user.getName())), getEntityClass());
    }
    
    @Override
    public Boolean isEmailExist(User user){
        return getDb().exists(new Query().addCriteria(Criteria.where("email").is(user.getEmail())), getEntityClass());
    }

}
