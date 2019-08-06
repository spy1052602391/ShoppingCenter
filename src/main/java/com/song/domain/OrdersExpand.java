package com.song.domain;

public class OrdersExpand extends Orders {
    Product product;

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
