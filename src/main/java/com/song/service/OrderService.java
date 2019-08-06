package com.song.service;

import com.song.domain.Cart;
import com.song.domain.CartExpand;
import com.song.domain.Orders;
import com.song.domain.OrdersExpand;


import java.util.List;

public interface OrderService {

    public void addOrders(List<CartExpand> list, String orderId, String uid) throws Exception;

    public void addItems(Orders orders) throws Exception;

    public List<OrdersExpand> findOrderById(String uid) throws Exception;

    public List<CartExpand> findOrderItem(String uid,String oid) throws Exception;

    public Orders checkOrder(String uid,String oid) throws Exception;

    public void updateOrder(Orders orders) throws Exception;

    public void deleteOrder(String uid,String oid) throws Exception;
}
