package DTOs;  // Đổi thành package của bạn

public class UserBuyingInfoDTO {
    private long userBuyingInforId; 
    private long userId = -1;
    private String recipientName;
    private String province;
    private String district;
    private String ward;
    private String street;
    private String phone;

    public UserBuyingInfoDTO() {
    }

    public UserBuyingInfoDTO(String recipientName, String province, String district,
                             String ward, String street, String phone) {
        this.recipientName = recipientName;
        this.province = province;
        this.district = district;
        this.ward = ward;
        this.street = street;
        this.phone = phone;
    }

    public UserBuyingInfoDTO(long userId, String recipientName, String province, String district, String ward, String street, String phone) {
        this.userId = userId;
        this.recipientName = recipientName;
        this.province = province;
        this.district = district;
        this.ward = ward;
        this.street = street;
        this.phone = phone;
    }

    // Getter và Setter
    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public long getUserBuyingInforId() {
        return userBuyingInforId;
    }

    public void setUserBuyingInforId(long userBuyingInforId) {
        this.userBuyingInforId = userBuyingInforId;
    }
    
}
