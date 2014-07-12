/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service;

import com.transportation.transportation.model.entities.User;
import com.transportation.transportation.model.exceptions.InvalidCredentialsException;
import com.transportation.transportation.model.exceptions.UserExistException;

/**
 *
 * @author youssef
 */
public interface ServiceUser {

    public User signIn(User user) throws InvalidCredentialsException;

    public void subscribe(User user) throws UserExistException;

    public boolean isAuthorizedUser(String authorizationString);
    
    public boolean isAuthorizedAdministrator(String authorizationString);
}
