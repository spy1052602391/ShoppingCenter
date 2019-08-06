package com.song.controller;

import com.song.domain.*;
import com.song.service.OrderService;

import org.omg.CORBA.SetOverrideType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.server.PathParam;
import java.util.List;

@Controller
public class OrderController {

    @Autowired
    OrderService orderService;

    @RequestMapping(value = "/submitOrder" , method = RequestMethod.GET)
    public ModelAndView submitOrder(HttpServletRequest request, @PathParam("sum")Double sum) throws Exception {
        ModelAndView modelAndView = new ModelAndView();

        User user = (User)request.getSession().getAttribute("user");
        Orders orders = new Orders();

        orders.setUid(user.getUid());

        orders.setTotal(sum);
        List<CartExpand> list = (List<CartExpand>) request.getSession().getAttribute("CartList");
        orders.setPid(list.get(0).getProduct().getPid());


        orderService.addItems(orders);
        orderService.addOrders(list,orders.getOid(),user.getUid());

        list.clear();
        request.getSession().setAttribute("CartList",list);

        modelAndView.setViewName("redirect:/OrderList.action");
        return modelAndView;
    }

    @RequestMapping(value = "/OrderList" , method = RequestMethod.GET)
    public ModelAndView OrderList(HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();

        User user = (User)request.getSession().getAttribute("user");
        if(user == null){
            String msg = "登陆已经过期，请重新登陆！";
            request.setAttribute("msg",msg);
            modelAndView.setViewName("login");
        }else {
            String uid = user.getUid();
            List<OrdersExpand> list = orderService.findOrderById(uid);
            request.setAttribute("OrderList", list);
            modelAndView.setViewName("order_list");
        }
        return modelAndView;
    }

    @RequestMapping(value = "/lookOrders" , method = RequestMethod.GET)
    public ModelAndView lookOrders(HttpServletRequest request,@PathParam("oid") String oid) throws Exception{
        ModelAndView modelAndView = new ModelAndView();
        User user = (User)request.getSession().getAttribute("user");
        String uid = user.getUid();
        List<CartExpand> list = orderService.findOrderItem(uid,oid);
        Orders orders = orderService.checkOrder(uid,oid);
        request.setAttribute("order",orders);
        request.setAttribute("CartList",list);
        modelAndView.setViewName("order_info");
        return modelAndView;
    }

    @RequestMapping(value = "/buyProduct" , method = RequestMethod.GET)
    public ModelAndView buyProduct(HttpServletRequest request) throws Exception{
        ModelAndView modelAndView = new ModelAndView();
        request.setCharacterEncoding("utf-8");
        String address = request.getParameter("address");
        String name = request.getParameter("name");
        String telephone = request.getParameter("telephone");
        String uid = request.getParameter("uid");
        String oid = request.getParameter("oid");
        Orders orders = new Orders();
        orders.setOid(oid);
        orders.setUid(uid);
        orders.setAddress(address);
        orders.setTelephone(telephone);
        orders.setState(1);
        orders.setName(name);
        orderService.updateOrder(orders);
        request.setAttribute("oid",oid);
        modelAndView.setViewName("buyJump");
        return modelAndView;
    }

    @RequestMapping(value = "/deleteOrder" , method = RequestMethod.GET)
    public ModelAndView deleteOrder(HttpServletRequest request,@PathParam("uid")String uid,@PathParam("oid")String oid) throws Exception{
        ModelAndView modelAndView = new ModelAndView();
        orderService.deleteOrder(uid,oid);
        List<OrdersExpand> list = orderService.findOrderById(uid);
        request.setAttribute("OrderList",list);
        modelAndView.setViewName("order_list");
        return modelAndView;
    }

}
