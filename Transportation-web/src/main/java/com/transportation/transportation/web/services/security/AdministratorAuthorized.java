/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services.security;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import javax.ws.rs.NameBinding;

/**
 *
 * @author youssef
 */
@NameBinding
@Retention(RetentionPolicy.RUNTIME)
public @interface AdministratorAuthorized {
}
