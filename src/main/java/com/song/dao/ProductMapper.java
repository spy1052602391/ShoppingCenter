package com.song.dao;

import com.song.domain.Product;
import org.apache.ibatis.annotations.Param;

import javax.persistence.criteria.CriteriaBuilder;
import javax.websocket.server.PathParam;
import java.util.List;

public interface ProductMapper {

    List<Product> findHot() throws Exception ;

    List<Product> findNew() throws Exception ;

    Product findProductById(Integer pid) throws Exception;

    List<Product> findByPage( @Param("cid") int cid, @Param("currentPage") int currentPage, @Param("pageSize") int pageSize) throws Exception;

    int getTotalCount(int cid) throws Exception;

    List<Product> findById(@Param("strings") String[] strings) throws Exception;

    List<Product> findByName(@Param("name")String name) throws Exception;
}
