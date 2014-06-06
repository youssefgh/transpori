/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.dao;

import com.transportation.transportation.model.entities.User;

/**
 *
 * @author youssef
 */
public interface DaoUser extends DaoGeneric<User> {

    public User findByName(User user);

    public Boolean isNameExist(User user);

    public Boolean isEmailExist(User user);
}
