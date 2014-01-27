/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.dao.impl;

import com.transportation.transportation.ejb.dao.DaoGeneric;
import java.util.List;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.data.mongodb.core.MongoOperations;

/**
 *
 * @author youssef
 * @param <T>
 */
public abstract class DaoGenericImpl<T> implements DaoGeneric<T> {

    private final Class<T> entityClass;
    private final ApplicationContext ctx;
    
    {
        ctx = new GenericXmlApplicationContext("SpringConfig.xml");
    }

    public DaoGenericImpl(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    protected MongoOperations getDb() {
        return (MongoOperations) ctx.getBean("mongoTemplate");
    }

    @Override
    public void create(T entity) {
        getDb().insert(entity);
    }

    @Override
    public T read(Object id) {
        return getDb().findById(id, entityClass);
    }

    @Override
    public void update(T entity) {
        getDb().save(entity);
    }

    @Override
    public void delete(T entity) {
        getDb().remove(entity);
    }

    @Override
    public List<T> readAll() {
        return getDb().findAll(entityClass);
    }

    protected Class<T> getEntityClass() {
        return entityClass;
    }
}
