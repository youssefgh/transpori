/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service.impl;

import com.transportation.transportation.ejb.dao.DaoUser;
import com.transportation.transportation.ejb.service.ServiceUser;
import com.transportation.transportation.model.entities.User;
import com.transportation.transportation.model.exceptions.EmailExistException;
import com.transportation.transportation.model.exceptions.InvalidCredentialsException;
import com.transportation.transportation.model.exceptions.UserExistException;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author youssef
 */
@Stateless
public class ServiceUserImpl implements ServiceUser {
    
    @EJB
    DaoUser dao;
    
    @Override
    public User signIn(User user) throws InvalidCredentialsException {
        User dbUser = dao.findByEmail(user);System.out.println("null");
        if (dbUser != null) {System.out.println(user.getPassword());
            if (dbUser.getPassword().equals(user.getPassword())) {
                return dbUser;
            }
        }
        throw new InvalidCredentialsException();
    }
    
    @Override
    public void subscribe(User user) throws UserExistException {
        if (dao.isEmailExist(user)) {
            throw new EmailExistException();
        }
        dao.create(user);
    }
    
    @Override
    public boolean isAuthorized(String authorizationString) {
        //TODO implement
        return true;
    }
}
