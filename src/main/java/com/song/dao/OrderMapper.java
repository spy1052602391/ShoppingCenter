package com.song.dao;

import com.song.domain.Cart;
import com.song.domain.CartExpand;
import com.song.domain.Orders;
import com.song.domain.OrdersExpand;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderMapper {

    public void addOrders(@Param("list") List<CartExpand> list, @Param("oid") String oid , @Param("uid") String uid) throws Exception;

    public void addItems(Orders orders) throws Exception;

    public List<OrdersExpand> findOrders(@Param("uid") String uid) throws Exception;

    public List<CartExpand> findOrderById(@Param("uid") String uid,@Param("oid") String oid) throws Exception;

    public Orders checkOrder(@Param("uid") String uid,@Param("oid") String oid) throws Exception;

    public void updateOrder(Orders orders) throws Exception;

    public void deleteOrder(@Param("uid") String uid,@Param("oid") String oid) throws Exception;

    public void deleteOrderItem(@Param("uid") String uid,@Param("oid") String oid) throws Exception;
}
