/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service.impl;

import com.transportation.transportation.ejb.dao.DaoUser;
import com.transportation.transportation.ejb.service.ServiceUser;
import com.transportation.transportation.model.entities.Administrator;
import com.transportation.transportation.model.entities.User;
import com.transportation.transportation.model.exceptions.EmailExistException;
import com.transportation.transportation.model.exceptions.InvalidCredentialsException;
import com.transportation.transportation.model.exceptions.UserExistException;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author youssef
 */
@Stateless
public class ServiceUserImpl implements ServiceUser {

    @EJB
    private DaoUser dao;

    @Override
    public User signIn(User user) throws InvalidCredentialsException {
        User dbUser = dao.findByEmailAndPassword(user);
        if (dbUser != null) {
            return dbUser;
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

    public void unsubscribe(User user) {
        dao.delete(user);
    }

    private User getAuthorizedUser(String authorizationString) throws InvalidCredentialsException {
        User user = new User();
        user.setId(authorizationString.substring(0, authorizationString.indexOf(":")));
        user.setPassword(authorizationString.substring(authorizationString.indexOf(":")+1));
        return dao.findByIdAndPassword(user);
    }

    @Override
    public boolean isAuthorizedUser(String authorizationString) {
        try {
            if (getAuthorizedUser(authorizationString) instanceof User) {
                return true;
            }
        } catch (InvalidCredentialsException ex) {
        }
        return false;
    }

    @Override
    public boolean isAuthorizedAdministrator(String authorizationString) {
        try {
            if (getAuthorizedUser(authorizationString) instanceof Administrator) {
                return true;
            }
        } catch (InvalidCredentialsException ex) {
        }
        return false;
    }

    private static final Logger LOG = Logger.getLogger(ServiceUserImpl.class.getName());

}
