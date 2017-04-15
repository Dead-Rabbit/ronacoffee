package entity;

import java.sql.Timestamp;

public class WorkOrders {
	private String orderId = null;
	private String weichatId = null;
	private String shopId = null;
	private String itemIds = null;
	private Float price = null;
	private Boolean ifBalance = null;
	private String token = null;
	private Timestamp createTime = null;
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public String getWeichatId() {
		return weichatId;
	}
	public void setWeichatId(String weichatId) {
		this.weichatId = weichatId;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getShopId() {
		return shopId;
	}
	public void setShopId(String shopId) {
		this.shopId = shopId;
	}
	public String getItemIds() {
		return itemIds;
	}
	public void setItemIds(String itemIds) {
		this.itemIds = itemIds;
	}
	public Float getPrice() {
		return price;
	}
	public void setPrice(Float price) {
		this.price = price;
	}
	public Boolean getIfBalance() {
		return ifBalance;
	}
	public void setIfBalance(Boolean ifBalance) {
		this.ifBalance = ifBalance;
	}
}
