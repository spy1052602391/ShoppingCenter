package com.song.service;

import com.song.domain.PageBean;
import com.song.domain.Product;

import java.util.List;

public interface ProductService {

    List<Product> findHot() throws Exception ;

    List<Product> findNew() throws Exception ;

    Product findById(Integer pid) throws Exception;

    PageBean<Product> findByPage(int cid, int currentPage, int pageSize) throws Exception;

    List<Product> findById(String str) throws Exception;

    List<Product> findByName(String name) throws Exception;
}
