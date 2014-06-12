/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.config;

import com.mongodb.DBObject;
import java.util.Set;
import java.util.logging.Logger;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.mapping.event.AbstractMongoEventListener;
import org.springframework.stereotype.Component;

/**
 *
 * @author youssef
 */
@Component
public class BeforeSaveValidator extends AbstractMongoEventListener {
    
    private static final Logger LOG = Logger.getLogger(BeforeSaveValidator.class.getName());
    
    @Autowired
    private Validator validator;
    
    @Override
    public void onBeforeSave(Object source, DBObject dbo) {
        Set<ConstraintViolation<Object>> violations = validator.validate(source);
        if (violations.size() > 0) {
            for (ConstraintViolation<Object> constraintViolation : violations) {
                LOG.severe(constraintViolation.getMessage());
            }
            throw new ConstraintViolationException(violations);
        }
    }
}
