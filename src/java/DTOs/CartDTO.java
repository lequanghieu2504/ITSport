/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;

import java.util.List;

/**
 *
 * @author SUPPER LOQ
 */
public class CartDTO {
    private int cart_id;
    private int client_id;
    private List<CartItemDTO> items;
    private double totalPrice;

    public CartDTO() {
    }

    public CartDTO(int cart_id, int client_id, List<CartItemDTO> items, double totalPrice) {
        this.cart_id = cart_id;
        this.client_id = client_id;
        this.items = items;
        this.totalPrice = totalPrice;
    }

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public int getClient_id() {
        return client_id;
    }

    public void setClient_id(int client_id) {
        this.client_id = client_id;
    }

    public List<CartItemDTO> getItems() {
        return items;
    }

    public void setItems(List<CartItemDTO> items) {
        this.items = items;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "CartDTO{" + "cart_id=" + cart_id + ", client_id=" + client_id + ", items=" + items + ", totalPrice=" + totalPrice + '}';
    }
}
