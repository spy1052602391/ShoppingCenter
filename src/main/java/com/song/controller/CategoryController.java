package com.song.controller;

import com.song.domain.Category;
import com.song.service.CategoryService;

import com.song.utils.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.incrementer.HsqlMaxValueIncrementer;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.json.Json;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class CategoryController {

    @Autowired
    CategoryService categoryService;

    @RequestMapping(value = "/category", method = RequestMethod.GET)
    public void findCategory(HttpServletResponse response) throws Exception{
        List<Category> list = categoryService.findAll();
        String str = JsonUtil.list2json(list);
        response.setContentType("text/html;charset=utf-8");
        response.getWriter().print(str);
    }

}
