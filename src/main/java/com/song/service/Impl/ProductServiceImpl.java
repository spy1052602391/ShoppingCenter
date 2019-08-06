package com.song.service.Impl;

import com.song.dao.ProductMapper;
import com.song.domain.PageBean;
import com.song.domain.Product;
import com.song.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class ProductServiceImpl implements ProductService {

    @Autowired
    ProductMapper productMapper;

    @Override
    public List<Product> findHot() throws Exception {
        return productMapper.findHot();
    }

    @Override
    public List<Product> findNew() throws Exception {
        return productMapper.findNew();
    }

    @Override
    public Product findById(Integer pid) throws Exception {
        return productMapper.findProductById(pid);
    }

    @Override
    public PageBean<Product> findByPage(int cid, int currentPage, int pageSize) throws Exception {
        //查询总记录数:通过分类id
        int totalCount = productMapper.getTotalCount(cid) ;
        //通过分页查询:列表页面中的集合数据list
        List<Product> list  = productMapper.findByPage(cid,(currentPage-1)*pageSize,pageSize);
        if(list.size() == 0 || list == null){
            return null;
        }else{
            return new PageBean<Product>(totalCount,currentPage,pageSize,list);
        }
    }



    @Override
    public List<Product> findById(String str) throws Exception {
        String[] strings = str.split("-");
        return productMapper.findById(strings);
    }

    @Override
    public List<Product> findByName(String name) throws Exception {
        return productMapper.findByName(name);
    }
}


