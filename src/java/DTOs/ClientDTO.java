package DTOs;

public class ClientDTO {

    private int client_id;
    private long user_id;
    private int cart_id;
    private String full_name;
    private String phone_number;
    private String address;

    public ClientDTO() {
    }

    public ClientDTO(int client_id, int user_id, int cart_id, String full_name, String phone_number, String address) {
        this.client_id = client_id;
        this.user_id = user_id;
        this.cart_id = cart_id;
        this.full_name = full_name;
        this.phone_number = phone_number;
        this.address = address;
    }

    public int getClient_id() {
        return client_id;
    }

    public void setClient_id(int client_id) {
        this.client_id = client_id;
    }

    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "ClientDTO{"
                + "client_id=" + client_id
                + ", user_id=" + user_id
                + ", cart_id=" + cart_id
                + ", full_name='" + full_name + '\''
                + ", phone_number='" + phone_number + '\''
                + ", address='" + address + '\''
                + '}';
    }
}
