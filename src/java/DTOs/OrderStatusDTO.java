/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTOs;

/**
 *
 * @author ASUS
 */
public class OrderStatusDTO {

    private String status;
    private int totalOrders;

    public OrderStatusDTO() {
    }

    public OrderStatusDTO(String status, int totalOrders) {
        this.status = status;
        this.totalOrders = totalOrders;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }
    
}
