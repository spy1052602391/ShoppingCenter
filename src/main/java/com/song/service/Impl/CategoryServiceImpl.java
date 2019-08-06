package com.song.service.Impl;

import com.song.dao.CategoryMapper;
import com.song.domain.Category;
import com.song.service.CategoryService;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {

    @Autowired
    CategoryMapper categoryMapper;

    @Override
    public List<Category> findAll() throws Exception {

        List<Category> list = null;
        //CacheManager:缓存处理器,需要通过缓存文件来创建该对象
        CacheManager cacheManager = CacheManager.create(CategoryServiceImpl.class.getClassLoader().
                getResourceAsStream("ehcache.xml")) ;

        //通过缓存文件中的标识名称获取缓存对象:Cache
        Cache cache = cacheManager.getCache("categoryCache");

        //从缓存对象获取存储的Element(缓存集合对象)
        Element element = cache.get("cList"); //clist(Key)
        if(element == null){
            //缓存集合对象中没有数据
            //从数据库查
            list =  categoryMapper.findAll() ;
            cache.put(new Element("cList",list));
        }else{
            //不为空,直接从缓存中获取
            list   =(List<Category>) element.getObjectValue();
        }
        return list;
    }
}


