/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main.java.com.servipro.dao.api;

import main.java.com.servipro.entity.Tipo_novedad;
import org.springframework.data.repository.CrudRepository;

/**
 *
 * @author PRACTICANTE
 */
public interface Tipo_novedadDaoApi extends CrudRepository<Tipo_novedad, Integer> {
    
    
}