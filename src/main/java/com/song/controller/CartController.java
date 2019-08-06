package com.song.controller;



import com.song.domain.CartExpand;
import com.song.domain.Product;
import com.song.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

import javax.websocket.server.PathParam;
import java.util.ArrayList;
import java.util.List;

@Controller
public class CartController {



    @Autowired
    ProductService productService;

    @RequestMapping(value = "/Cart" , method = RequestMethod.GET)
    public ModelAndView Cart(HttpServletRequest request,@PathParam("pid") Integer pid) throws Exception{
        request.setCharacterEncoding("utf-8");
        ModelAndView modelAndView = new ModelAndView();
        ArrayList<CartExpand> list = null;
        CartExpand cart = new CartExpand();
        Product product = productService.findById(pid);
        cart.setProduct(product);
        int count = Integer.valueOf(request.getParameter("count"));
        cart.setCount(count);
        cart.setSubtotal(count*product.getShop_price());
        Object o = request.getSession().getAttribute("CartList");
        if(o == null){
            list = new ArrayList();
            list.add(cart);
        }else{
            list = (ArrayList<CartExpand>)o;
            list.add(cart);
        }
        request.getSession().setAttribute("CartList",list);
        modelAndView.setViewName("redirect:cartOnclick.action");
        return modelAndView;
    }

    @RequestMapping(value = "/deleteItem" , method = RequestMethod.GET)
    public ModelAndView deleteItem(HttpServletRequest request,@PathParam("index") int index) throws Exception{

        ModelAndView modelAndView = new ModelAndView();
        List<CartExpand> list = (List<CartExpand>) request.getSession().getAttribute("CartList");
        list.remove(index);
        request.getSession().setAttribute("CartList",list);
        modelAndView.setViewName("redirect:cartOnclick.action");
        return modelAndView;
    }

    @RequestMapping(value = "/clearItem" , method = RequestMethod.GET)
    public ModelAndView clearItem(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        List<CartExpand> list = (List<CartExpand>) request.getSession().getAttribute("CartList");
        list.clear();
        request.getSession().setAttribute("CartList",list);
        modelAndView.setViewName("redirect:cartOnclick.action");
        return modelAndView;
    }
}
