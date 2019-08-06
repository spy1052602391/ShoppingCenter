package com.song.controller;

import com.song.domain.PageBean;
import com.song.domain.Product;
import com.song.service.ProductService;
import com.song.utils.CookUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

@Controller
public class ProductController {

    @Autowired
    ProductService productService;

    @RequestMapping(value = "/productInfo" , method = RequestMethod.GET)
    public ModelAndView productInfo(@PathParam("pid") Integer pid, HttpServletRequest request, HttpServletResponse response) throws Exception{
        ModelAndView modelAndView = new ModelAndView();
        Cookie[] cookies = request.getCookies();
        Cookie cookie = CookUtils.getCookieByName("History",cookies);
        if(cookie == null){
            Cookie a = new Cookie("History",pid+"");
            response.addCookie(a);
        }else{
            String str = pid+"";
            String[] strings = cookie.getValue().split("-");
            List<String> asList = Arrays.asList(strings);
            LinkedList<String> linkedList = new LinkedList<>(asList);
            if(linkedList.contains(str)){
                linkedList.remove(str);
                linkedList.addFirst(str);
            }else{
                linkedList.addFirst(str);
            }
            str = "";
            for(String string : linkedList){
                str += string+"-";
            }
            Cookie a = new Cookie("History",str.substring(0,str.length()-1));
            response.addCookie(a);
        }
        Product product = productService.findById(pid);
        modelAndView.addObject("bean",product);
        modelAndView.setViewName("product_info");
        return modelAndView;
    }

    @RequestMapping(value = "/productShow" , method = RequestMethod.GET)
    public ModelAndView productShow(HttpServletRequest request) throws Exception{
        ModelAndView modelAndView = new ModelAndView();
        Integer cid = Integer.valueOf(request.getParameter("cid"));
        //当前页码
        int currentPage = Integer.parseInt(request.getParameter("currentPage"));
        //pageSize的默认值
        int pageSize = 12 ;
        PageBean<Product> pb = productService.findByPage(cid,currentPage,pageSize);
        //3.将PageBean对象存储request域中
        request.setAttribute("pb",pb);
        //4.cookie中的浏览记录
        Cookie[] cookies = request.getCookies();
        Cookie cookie = CookUtils.getCookieByName("History",cookies);
        List<Product> list = null;
        if(cookie != null){
            list = productService.findById(cookie.getValue());
        }
        request.setAttribute("historyList",list);
        modelAndView.setViewName("product_list");
        return modelAndView;
    }

    @RequestMapping(value = "/searchProduct" , method = RequestMethod.GET)
    public ModelAndView searchProduct(HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        request.setCharacterEncoding("utf-8");
        String name = request.getParameter("search");
        System.out.println(name);
        List<Product> list = productService.findByName(name);
        request.setAttribute("list",list);

        modelAndView.setViewName("searchProduct");
        return modelAndView;
    }
}
