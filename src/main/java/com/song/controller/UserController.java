package com.song.controller;

import com.song.converter.MyConverter;

import com.song.domain.Product;
import com.song.domain.User;
import com.song.service.ProductService;
import com.song.service.UserService;
import com.song.utils.UUIDUtils;

import com.sun.org.apache.xpath.internal.operations.Mod;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.server.PathParam;


import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    ProductService productService;
    @Autowired
    UserService userService;

    @RequestMapping(value = "/registerOnclick" , method = RequestMethod.GET)
    public ModelAndView registerOnclick(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("register");
        return modelAndView;
    }

    @RequestMapping(value = "/loginOnclick" , method = RequestMethod.GET)
    public ModelAndView loginOnclick(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("login");
        return modelAndView;
    }

    @RequestMapping(value = "/cartOnclick" , method = RequestMethod.GET)
    public ModelAndView cartOnclick(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("cart");
        return modelAndView;
    }

    @RequestMapping(value = "/msgOnclick" , method = RequestMethod.GET)
    public ModelAndView msgOnclick(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("msg");
        return modelAndView;
    }


    @RequestMapping(value = "/index" , method = RequestMethod.GET)
    public ModelAndView jumpIndex(HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();

        List<Product> hList = productService.findHot();
        List<Product> nList = productService.findNew();
        request.getSession().setAttribute("hList",hList);
        request.getSession().setAttribute("nList",nList);

        modelAndView.setViewName("index");
        return modelAndView;
    }

    @RequestMapping(value = "/register" , method = RequestMethod.POST)
    public ModelAndView register(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");

        //防止验证码重复使用
        request.getSession().removeAttribute("sessionCode");

        ModelAndView modelAndView = new ModelAndView();

        Map<String,String[]> map = request.getParameterMap();

        User user = new User();

        //注册转换器
        ConvertUtils.register(new MyConverter(),Date.class);
        BeanUtils.populate(user,map);

        //设置用户id  使用随机生成的工具类
        user.setUid(UUIDUtils.getId());
        //设置用户的激活码（唯一）
        user.setCode(UUIDUtils.getCode());

        userService.regist(user);
        request.getSession().setAttribute("user",user);
        request.getSession().setAttribute("msg","注册成功！");
        modelAndView.setViewName("redirect:msgOnclick.action"); //使用重定向的原因是，否则刷新页面将会导致同一个用户两次注册。

        return modelAndView;
    }

    @RequestMapping(value = "/UserLogin",method = RequestMethod.POST)
    public ModelAndView UserLogin(HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        String username = request.getParameter("username");
        User user = userService.findUserByName(username);
        request.getSession().setAttribute("user",user);
        request.getSession().setMaxInactiveInterval(2400);
        modelAndView.setViewName("index");
        return modelAndView;
    }

    @RequestMapping(value = "/userCheck",method = RequestMethod.POST)
    @ResponseBody
    public String userCheck(@PathParam("username") String username,@PathParam("password") String password) throws Exception {
        int result = userService.findByUsernameAndPassword(username,password);
        return "{\"state\":"+result+"}";
    }

    @RequestMapping(value = "/registerCheck" , method = RequestMethod.POST)
    @ResponseBody
    public String registerCheck(@PathParam("username") String username) throws Exception{

        int result = userService.checkUserName(username);

        return "{\"state\":"+result+"}";
    }

    @RequestMapping(value = "/codeCheck" , method = RequestMethod.POST)
    @ResponseBody
    public String CodeCheck(@PathParam("check1") String check1,HttpServletRequest request) throws Exception{
        int result = 1;

        String sessionCode = (String) request.getSession().getAttribute("sessionCode");

        if(sessionCode == null || !sessionCode.equalsIgnoreCase(check1)){
            request.setAttribute("msg","验证码错误");
            result = 0;
        }

        return "{\"state\":"+result+"}";
    }

    @RequestMapping(value = "/quitUser" , method = RequestMethod.GET)
    public ModelAndView quitUser(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        User user = (User)request.getSession().getAttribute("user");
        if(user != null){
            request.getSession().removeAttribute("user");
        }
        if(request.getSession().getAttribute("CartList") != null){
            request.getSession().removeAttribute("CartList");
        }
        modelAndView.setViewName("index");
        return modelAndView;
    }
}
