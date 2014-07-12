/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.dao;

import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author youssef
 * @param <T>
 */
public interface DaoGeneric<T> {
    void create(T entity);
    T read(Object id);
    void update(T entity);
    void delete(T entity);
    List<T> readAll();
}
