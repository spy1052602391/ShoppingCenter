package com.song.service.Impl;

import com.song.dao.OrderMapper;
import com.song.dao.ProductMapper;
import com.song.domain.Cart;
import com.song.domain.CartExpand;
import com.song.domain.Orders;
import com.song.domain.OrdersExpand;
import com.song.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class OrderServiceImpl implements OrderService {

    @Autowired
    ProductMapper productMapper;

    @Autowired
    OrderMapper orderMapper;

    @Override
    public void addOrders(List<CartExpand> list, String orderId , String uid) throws Exception {
        orderMapper.addOrders(list,orderId,uid);
    }

    @Override
    public void addItems(Orders orders) throws Exception {
        orderMapper.addItems(orders);
    }

    @Override
    public List<OrdersExpand> findOrderById(String uid) throws Exception {
        return orderMapper.findOrders(uid);
    }

    public List<CartExpand> findOrderItem(String uid,String oid) throws Exception{
        List<CartExpand> list = orderMapper.findOrderById(uid,oid);
        return list;
    }

    @Override
    public void updateOrder(Orders orders) throws Exception {
        orderMapper.updateOrder(orders);
    }

    @Override
    public void deleteOrder(String uid, String oid) throws Exception {
        orderMapper.deleteOrderItem(uid,oid);
        orderMapper.deleteOrder(uid,oid);

    }


    public Orders checkOrder(String uid,String oid) throws Exception{
        return orderMapper.checkOrder(uid,oid);
    }
}
